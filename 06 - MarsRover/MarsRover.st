!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/5/2023 21:34:28'!
test01
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: #North.
	rover process: ''.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/5/2023 21:40:04'!
test02
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: #North.
	rover process: 'f'.
		
	self assert: (rover isInPosition: (0@1) pointingTo: #North).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position point direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AB 10/5/2023 20:36:24'!
direction
	^#North! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AB 10/5/2023 21:03:48'!
isInPosition: aPosition pointingTo: aDirection 
	^position = aPosition and: [ direction = aDirection ].! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AB 10/5/2023 20:35:21'!
position
	^(0@0).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'AB 10/5/2023 21:42:47'!
process: aCommand
	aCommand  = 'f' ifTrue: [^position := position x @ (position y + 1)].! !


!MarsRover methodsFor: 'initialization' stamp: 'AB 10/5/2023 21:02:14'!
initializeWithPosition: aPoint andDirection: aDirection 
	position := aPoint.
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'AB 10/5/2023 21:04:28'!
withPosition: aPoint andDirection: aDirection 
	^self new initializeWithPosition: aPoint andDirection: aDirection ! !
