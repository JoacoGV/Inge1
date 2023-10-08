!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:07:35'!
test01ProcessEmptyCommandListDoesNothing
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: ''.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:08:07'!
test02processOneFowardCommandMovesTheRoverOnePositionFoward
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'f'.
		
	self assert: (rover isInPosition: (0@1) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:11:56'!
test03ProcessOneBackwardsCommandMovesTheRoverOnePositionBackwards
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'b'.
		
	self assert: (rover isInPosition: (0@-1) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:11:44'!
test04ProcessManyBackwardsFowardCommands
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'ff'.
		
	self assert: (rover isInPosition: (0@2) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/8/2023 12:39:39'!
test05ProcessOneLeftCommandRotatesTheRoverToTheLeftOnce
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'l'.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:14:36'!
test06ProcessManyLeftCommandRotatesTheRoverToTheLeftTwice
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'll'.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:13:36'!
test07ProcessOneRightCommandRotatesTheRoverToTheRightOnce
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'r'.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:14:19'!
test08ProcessManyRightCommandRotatesTheRoverToTheLeftMany
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'rr'.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:16:03'!
test09ProcessRightAndFowardCommandsMovesAndRotatesTheRover
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'rf'.
		
	self assert: (rover isInPosition: (1@0) pointingTo: #East).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:16:30'!
test10ProcessLeftAndFowardCommandsMovesAndRotatesTheRover
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'lf'.
		
	self assert: (rover isInPosition: (-1@0) pointingTo: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:17:04'!
test11ProcessLeftAndBackwardsCommandMovesAndRotatesTheRover
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'lb'.
		
	self assert: (rover isInPosition: (1@0) pointingTo: #West).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:18:04'!
test12ProcessManyRotationAndMovementCommands
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'rbrb'.
		
	self assert: (rover isInPosition: (-1@1) pointingTo: #South).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:18:55'!
test13UnknownCommandDoesNothing
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: '?'.
		
	self assert: (rover isInPosition: (0@0) pointingTo: #North).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'Joaco 10/7/2023 17:18:49'!
test14UnknownCommandCutsCommandProcessing
	|rover|
	
	rover := MarsRover withPosition: (0@0) andDirection: North new.
	rover process: 'frf?flf'.
		
	self assert: (rover isInPosition: (1@1) pointingTo: #East).! !


!classDefinition: #CardinalPoint category: 'MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalPoint methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:43:58'!
nextPositionBackwardsFromPostion: aPosition 
	self subclassResponsibility .! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:38:43'!
nextPositionFowardFromPosition: aPosition 
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:09:20'!
toMyLeft

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:17:06'!
toMyRight

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:04:08'!
value
	^value.! !


!classDefinition: #East category: 'MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:47:07'!
nextPositionBackwardsFromPostion: aPosition 
	^aPosition - (1@0).! !

!East methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:41:11'!
nextPositionFowardFromPosition: aPosition 
	^aPosition + (1@0).! !

!East methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:12:46'!
toMyLeft
	^North new.! !

!East methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:17:34'!
toMyRight
	^South new.! !


!East methodsFor: 'initialization' stamp: 'Joaco 10/7/2023 16:10:17'!
initialize
	value := #East.! !


!classDefinition: #North category: 'MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:44:29'!
nextPositionBackwardsFromPostion: aPosition 
	^aPosition - (0@1).! !

!North methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:42:36'!
nextPositionFowardFromPosition: aPosition 
	^aPosition + (0@1)! !

!North methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:09:39'!
toMyLeft
	^West new.! !

!North methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:17:43'!
toMyRight
	^East new.! !


!North methodsFor: 'initialization' stamp: 'Joaco 10/7/2023 16:06:07'!
initialize
	value := #North.! !


!classDefinition: #South category: 'MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'initialization' stamp: 'Joaco 10/7/2023 16:10:28'!
initialize
	value := #South.! !


!South methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:47:44'!
nextPositionBackwardsFromPostion: aPosition 
	^aPosition + (0@1).! !

!South methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:43:03'!
nextPositionFowardFromPosition: aPosition 
	^aPosition - (0@1)
	! !

!South methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:12:29'!
toMyLeft
	^East new.! !

!South methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:17:53'!
toMyRight
	^West new.! !


!classDefinition: #West category: 'MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'initialization' stamp: 'Joaco 10/7/2023 16:10:38'!
initialize
	value := #West.! !


!West methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:45:30'!
nextPositionBackwardsFromPostion: aPosition 
	^aPosition + (1@0).! !

!West methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:41:52'!
nextPositionFowardFromPosition: aPosition 
	^aPosition - (1@0).! !

!West methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:09:50'!
toMyLeft
	^South new.! !

!West methodsFor: 'accessing' stamp: 'Joaco 10/7/2023 16:18:12'!
toMyRight
	^North new.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'comparing' stamp: 'Joaco 10/7/2023 16:04:47'!
isInPosition: aPosition pointingTo: aDirection 
	^position = aPosition and: [ direction value = aDirection ].! !

!MarsRover methodsFor: 'comparing' stamp: 'Joaco 10/7/2023 17:06:23'!
isInvalidRoverCommand: aCommand

	^ ((aCommand = $f) not and: [(aCommand = $b) not and: [(aCommand = $l) not and: [ (aCommand = $r) not]]]).! !


!MarsRover methodsFor: 'Procesing' stamp: 'Joaco 10/7/2023 17:06:32'!
process: aCommandList
	
	aCommandList do: [ :aCommand |  
		(self isInvalidRoverCommand: aCommand) ifTrue: [^self].
		aCommand = $f ifTrue: [	 position := direction nextPositionFowardFromPosition:  position ].
		aCommand = $b ifTrue: [ position := direction nextPositionBackwardsFromPostion: position ].	
		aCommand = $l ifTrue: [ direction :=  direction toMyLeft].
		aCommand = $r ifTrue: [ direction := direction toMyRight ].
		].
! !


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
