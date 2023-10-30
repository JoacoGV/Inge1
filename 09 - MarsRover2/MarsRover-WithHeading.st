!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:47:31'!
test17IsEmptyLoggerPositionWhenStar

	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	logger := Logger forPositionOnMarsRover: marsRover.
	
	self assert: logger log equals: OrderedCollection new.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:48:44'!
test18LoggerHavePositionForAFowardMove

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	logger := Logger  forPositionOnMarsRover: marsRover.		
	marsRover process: 'f'.
	
	self assert: logger log equals: (OrderedCollection with: (1@2) asString).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:49:36'!
test19LoggerHavePositionForABackwardMove

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	logger := Logger forPositionOnMarsRover: marsRover.
	
	marsRover process: 'b'.
	
	self assert: logger log equals: (OrderedCollection with: (1@0) asString).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:51:11'!
test20LoggerHavePositionsForManyMoves

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self east . 
	
	logger := Logger forPositionOnMarsRover: marsRover.
	
	marsRover process: 'fb'.
	
	self assert: logger log equals: (OrderedCollection with: (2@1) asString with: (1@1) asString).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:52:17'!
test21LoggerHaveRotationForRightMove

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	logger := Logger forRotationOnMarsRover: marsRover.
	
	marsRover process: 'r'.
	
	self assert: logger log equals: (OrderedCollection with: 'East').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:52:34'!
test22LoggerHaveManyRotationsMoves

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self east. 
	
	logger := Logger forRotationOnMarsRover: marsRover.
	
	marsRover process: 'rrr'.
	
	self assert: logger log equals: (OrderedCollection with: 'South' with: 'West' with: 'North').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:52:57'!
test23LoggerHaveRotationAndPositionsMoves

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	logger := Logger forPositionAndRotationOnMarsRover: marsRover.
	
	marsRover process: 'frbl'.
	
	self assert: logger log equals: (OrderedCollection with: '1@2' with: 'East' with: '0@2' with: 'North').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:55:52'!
test24WindowHaveNoPositonWhenMarsRoversStart

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forPositionOnMarsRover: marsRover.
		
	self assert: window log equals: (OrderedCollection new).! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:54:12'!
test25WindowHavePositionForFowardMove

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forPositionOnMarsRover: marsRover.

	marsRover process: 'f'.
		
	self assert: window log equals: (OrderedCollection with: '1@2').! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:54:43'!
test26WindowChangePositionAfterManyMoves

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forPositionOnMarsRover: marsRover.
		
	self assert: window log equals: (OrderedCollection new).
	
	marsRover process: 'rf'.
	
	self assert: window log equals: (OrderedCollection with: '2@1').
	
	marsRover process: 'b'.
	
	self assert: window log equals: (OrderedCollection with: '1@1').
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:55:35'!
test27WindowHaveNoRotationWhenStart

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forRotationOnMarsRover: marsRover.
		
	self assert: window log equals: (OrderedCollection new).
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:56:17'!
test28WindowChangeRotationAfterManyRightMoves

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forRotationOnMarsRover: marsRover.
		
	marsRover process: 'r'.
	self assert: window log equals: (OrderedCollection with: 'East').
	
	marsRover process: 'r'.
	self assert: window log equals: (OrderedCollection with: 'South').
	
	marsRover process: 'r'.
	self assert: window log equals: (OrderedCollection with: 'West').
	
	marsRover process: 'r'.
	self assert: window log equals: (OrderedCollection with: 'North').

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AB 10/30/2023 14:56:40'!
test29WindowHavePositionAndRotation

	| marsRover window |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	
	window := Window forPositionAndRotationOnMarsRover: marsRover.
		
	self assert: window log equals: (OrderedCollection new).
	
	marsRover process: 'f'.
	self assert: window log equals: (OrderedCollection with: '1@2').
	
	marsRover process: 'r'.
	self assert: window log equals: (OrderedCollection with: '1@2' with: 'East').
	
	
	

! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #Logger category: 'MarsRover-WithHeading'!
Object subclass: #Logger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 17:39:09'!
addLog: aPositonToLog
	logs add: aPositonToLog asString.! !

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 16:28:54'!
initialize
	logs := OrderedCollection new.! !

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 19:06:37'!
initializeForPositionAndRotationOnMarsRover: aMarsRover 
	aMarsRover addPositionLogger: [:aPosition | logs add: aPosition asString].
	aMarsRover addRotationLogger: [:aMarsRoverHeading | logs add: aMarsRoverHeading direction].! !

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 20:06:30'!
initializeForPositionWithMarsRover: aMarsRover 
	aMarsRover addPositionLogger: [:aPosition | logs add: aPosition asString].! !

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 18:59:57'!
initializeForRotationWithMarsRover: aMarsRover 
	aMarsRover addRotationLogger: [:aMarsRoverHeading | logs add: aMarsRoverHeading direction ].! !

!Logger methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 18:49:43'!
initializeWithMarsRover: aMarsRover.
	aMarsRover addPositionLogger: [:aPositionToLog | logs add: aPositionToLog asString.].! !


!Logger methodsFor: 'log' stamp: 'Jgv 10/29/2023 16:39:40'!
log
	^logs.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Logger class' category: 'MarsRover-WithHeading'!
Logger class
	instanceVariableNames: ''!

!Logger class methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 18:53:59'!
forPositionOnMarsRover: aMarsRover
	^self new initializeForPositionWithMarsRover: aMarsRover.! !

!Logger class methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 18:57:36'!
forRotationOnMarsRover: aMarsRover
	^self new initializeForRotationWithMarsRover: aMarsRover.! !


!Logger class methodsFor: 'instance creation' stamp: 'Jgv 10/29/2023 19:04:59'!
forPositionAndRotationOnMarsRover: aMarsRover 

	^self new initializeForPositionAndRotationOnMarsRover: aMarsRover ! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 17:59:25'!
initializeAt: aPosition heading: aHeadingType

	position := Proxy withValue: aPosition.
	head := Proxy withValue: (aHeadingType for: self). ! !


!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 19:01:27'!
headEast
	
	head changeValue: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 19:03:22'!
headNorth
	
	head changeValue: (MarsRoverHeadingNorth for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 19:02:49'!
headSouth
	
	head changeValue: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 19:03:39'!
headWest
	
	head changeValue: (MarsRoverHeadingWest for: self)! !

!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 18:11:14'!
rotateLeft
	
	head value rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'Jgv 10/29/2023 18:10:59'!
rotateRight
	
	head value rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'Jgv 10/29/2023 18:07:18'!
isAt: aPosition heading: aHeadingType

	^position value = aPosition and: [ head value isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:10:25'!
moveBackward
	
	head value moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:11:39'!
moveEast
	
	position changeValue: position value + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:08:20'!
moveForward
	
	head value moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:09:29'!
moveNorth
	
	position changeValue: position value + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:10:44'!
moveSouth
	
	position changeValue: position value + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'Jgv 10/29/2023 18:11:59'!
moveWest
	
	position changeValue: position value + (-1@0).! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:48'!
addPositionAndRotationLogger: aPositionAndRotationLogger
	position  suscribe: aPositionAndRotationLogger.
	head  suscribe: aPositionAndRotationLogger.
	! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 17:51:04'!
addPositionAndRotationWindow: aPostionAndRotationWindow 
	positionWindow := aPostionAndRotationWindow.
	rotationWindow := aPostionAndRotationWindow.! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:47'!
addPositionLogger: aPositionLogger 
	position suscribe: aPositionLogger.! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:47'!
addPositionWindow: aWindow 
	position suscribe: aWindow.! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:47'!
addRotationLogger: aRotationLogger 
	head suscribe: aRotationLogger.! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:47'!
addRotationWindow: aRotationWindow 
	head suscribe: aRotationWindow.
! !

!MarsRover methodsFor: 'loggers' stamp: 'Jgv 10/29/2023 20:12:47'!
suscribe: aLogger
	aLogger value.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:32:18'!
direction
	^'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:28:09'!
direction
	^'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:28:26'!
direction
	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:28:45'!
direction
	^'West'! !


!classDefinition: #Proxy category: 'MarsRover-WithHeading'!
Object subclass: #Proxy
	instanceVariableNames: 'value loggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Proxy methodsFor: 'getters' stamp: 'Jgv 10/29/2023 20:11:51'!
value
	^value.! !


!Proxy methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 20:11:42'!
initializeWithValue: aValue
	value  := aValue.
	loggers := OrderedCollection new.! !


!Proxy methodsFor: 'setters' stamp: 'Jgv 10/29/2023 20:11:34'!
changeValue: aValue
	value := aValue.
	loggers do: [:logger | logger value: aValue].! !

!Proxy methodsFor: 'setters' stamp: 'Jgv 10/29/2023 20:12:47'!
suscribe: aLogger 
	loggers add: aLogger.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Proxy class' category: 'MarsRover-WithHeading'!
Proxy class
	instanceVariableNames: ''!

!Proxy class methodsFor: 'instance creation' stamp: 'Jgv 10/29/2023 18:05:43'!
withValue: aValue
	^self new initializeWithValue: aValue.! !


!classDefinition: #Window category: 'MarsRover-WithHeading'!
Object subclass: #Window
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!Window methodsFor: 'log' stamp: 'Jgv 10/29/2023 20:11:10'!
log
	|log|
	
	log := OrderedCollection new.
	position isEmpty ifFalse: [log add: position].
	direction  isEmpty ifFalse: [log add: direction].
	
	^log.! !


!Window methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:38:34'!
addPositionLog: aPosition 
	position := aPosition asString.! !

!Window methodsFor: 'as yet unclassified' stamp: 'Jgv 10/29/2023 17:41:06'!
addRotationLog: aDirection
	direction := aDirection.! !


!Window methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 20:09:55'!
initialize
	position := ''.
	direction := ''.! !

!Window methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 19:33:42'!
initializeForPositionAndRotationOnMarsRover: aMarsRover 
	aMarsRover addPositionLogger: [:aPosition | position := aPosition asString].
	aMarsRover addRotationLogger: [:aMarsRoverHeading | direction :=  aMarsRoverHeading direction].! !

!Window methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 19:26:04'!
initializeForPositionOnMarsRover: aMarsRover 
	aMarsRover addPositionWindow: [:aPosition | position := aPosition asString ].! !

!Window methodsFor: 'initialization' stamp: 'Jgv 10/29/2023 19:30:11'!
initializeForRotationOnMarsRover: aMarsRover 
	aMarsRover addRotationWindow: [:aMarsRoverHeading | direction := aMarsRoverHeading direction].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Window class' category: 'MarsRover-WithHeading'!
Window class
	instanceVariableNames: ''!

!Window class methodsFor: 'instance creation' stamp: 'Jgv 10/29/2023 19:32:30'!
forPositionAndRotationOnMarsRover: aMarsRover 
	^self new initializeForPositionAndRotationOnMarsRover: aMarsRover ! !

!Window class methodsFor: 'instance creation' stamp: 'Jgv 10/29/2023 19:07:49'!
forPositionOnMarsRover: aMarsRover 
	^self new initializeForPositionOnMarsRover: aMarsRover ! !

!Window class methodsFor: 'instance creation' stamp: 'Jgv 10/29/2023 19:29:18'!
forRotationOnMarsRover: aMarsRover 
	^self new initializeForRotationOnMarsRover: aMarsRover ! !
