!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack senteceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'AB 9/17/2023 21:00:15'!
setUp
	stack := OOStack new.
	
	stack push: 'summer is here'. 
	stack push: 'Winter is here'.
	stack push: 'The winds of Winter'. 
	stack push: 'something'. 
	stack push: 'winter is coming'. 
	stack push: 'winning is everything'. 
	senteceFinder := 	SentenceFinderByPrefix new.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:34:24'!
test01EncuentraLaFraseQueCorrespondeAlPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: (Prefix withValue: 'sum') inStack: stack .
	self assert: sentencesFound size = 1.
	self assert:	(sentencesFound  first = 'summer is here').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:35:48'!
test02EncuentraLasFrasesQueCorrespondenAlPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: (Prefix withValue: 'win') inStack: stack .
	self assert: sentencesFound size = 2.
	self assert:	(sentencesFound  first = 'winning is everything').
	self assert:	(sentencesFound  last = 'winter is coming').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:36:26'!
test03NoEncuentraNingunaFraseParaElPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: (Prefix withValue: 'Hola') inStack: stack .
	self assert: sentencesFound isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:36:48'!
test04NoEncuentraLaFrasePorElCaseSensitive
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: (Prefix withValue: 'Some') inStack: stack .
	self assert: sentencesFound isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:37:27'!
test05PrefijoInvalidoConEspacio
	self
		should: [ senteceFinder findWithPrefix: (Prefix withValue: 'summer is') inStack: stack .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacedPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:37:41'!
test06PrefijoVacio
	self
		should: [ senteceFinder findWithPrefix: (Prefix withValue:'') inStack: stack .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Joa 9/18/2023 13:38:06'!
test07SeMatieneElStackIgual
	senteceFinder findWithPrefix: (Prefix withValue: 'Wint') inStack: stack .
	self assert: stack size = 6.
	self assert: stack top = 'winning is everything'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topmostElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifying' stamp: 'AB 9/17/2023 12:05:43'!
pop
	|lastPushedObject|
	lastPushedObject := topmostElement .
	topmostElement := topmostElement previusElement.
	size:=size-1.
	^lastPushedObject value.! !

!OOStack methodsFor: 'modifying' stamp: 'AB 9/17/2023 12:10:18'!
push: anElement
topmostElement := BodyStackNode with: anElement stackedOver:topmostElement .
size:=size +1.
	! !

!OOStack methodsFor: 'modifying' stamp: 'AB 9/17/2023 11:57:16'!
top

	^topmostElement value.! !


!OOStack methodsFor: 'testing' stamp: 'AB 9/17/2023 12:12:20'!
isEmpty
	^topmostElement class = BaseStackNode.! !

!OOStack methodsFor: 'testing' stamp: 'AB 9/17/2023 11:39:39'!
size
	^size.! !


!OOStack methodsFor: 'initialization' stamp: 'AB 9/17/2023 12:07:30'!
initialize
	size:=0.
	topmostElement  := BaseStackNode new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #Prefix category: 'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: 'Stack-Exercise'!
Prefix class
	instanceVariableNames: ''!

!Prefix class methodsFor: 'instanciation' stamp: 'Joa 9/18/2023 13:29:16'!
withValue: aString
	aString isEmpty ifTrue: [^EmptyPrefix new].
	^ NotEmptyPrefix withValue: aString.! !


!classDefinition: #EmptyPrefix category: 'Stack-Exercise'!
Prefix subclass: #EmptyPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyPrefix methodsFor: 'operation' stamp: 'Joa 9/18/2023 13:26:43'!
beingSearchedBy: aSentenceFinderByPrefix in: aStack
	^ aSentenceFinderByPrefix findWithEmptyPrefix.! !


!EmptyPrefix methodsFor: 'initialization' stamp: 'Joa 9/18/2023 13:07:52'!
initialize
	value := ''.! !


!classDefinition: #NotEmptyPrefix category: 'Stack-Exercise'!
Prefix subclass: #NotEmptyPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyPrefix methodsFor: 'initialization' stamp: 'Joa 9/18/2023 13:12:47'!
initializeWith: aPrefixString
	value := aPrefixString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyPrefix class' category: 'Stack-Exercise'!
NotEmptyPrefix class
	instanceVariableNames: ''!

!NotEmptyPrefix class methodsFor: 'instanciation' stamp: 'Joa 9/18/2023 13:31:11'!
withValue: aPrefixString
	(aPrefixString includesSubString: ' ' ) ifTrue:[^SpacedPrefix withValue: aPrefixString ].
	^NotSpacedPrefix  withValue: aPrefixString.! !


!classDefinition: #NotSpacedPrefix category: 'Stack-Exercise'!
NotEmptyPrefix subclass: #NotSpacedPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!NotSpacedPrefix methodsFor: 'operations' stamp: 'Joa 9/18/2023 13:35:17'!
beingSearchedBy: aSentenceFinderByPrefix in: aStack
	^aSentenceFinderByPrefix  findWithValidPrefix: value in: aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotSpacedPrefix class' category: 'Stack-Exercise'!
NotSpacedPrefix class
	instanceVariableNames: ''!

!NotSpacedPrefix class methodsFor: 'instanciation' stamp: 'Joa 9/18/2023 13:32:53'!
withValue: aPrefixString
	^self basicNew initializeWith: aPrefixString.! !


!classDefinition: #SpacedPrefix category: 'Stack-Exercise'!
NotEmptyPrefix subclass: #SpacedPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SpacedPrefix methodsFor: 'as yet unclassified' stamp: 'Joa 9/18/2023 13:25:48'!
beingSearchedBy: aSentenceFinderByPrefix in: aStack
	^aSentenceFinderByPrefix findWithSpacedPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpacedPrefix class' category: 'Stack-Exercise'!
SpacedPrefix class
	instanceVariableNames: ''!

!SpacedPrefix class methodsFor: 'instance creation' stamp: 'Joa 9/18/2023 13:33:23'!
withValue: aPrefixString
	^self basicNew initializeWith: aPrefixString.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finders' stamp: 'Joa 9/18/2023 13:22:14'!
findWithEmptyPrefix
	^self error: self class prefixEmptyErrorDescription.
	! !

!SentenceFinderByPrefix methodsFor: 'finders' stamp: 'Joa 9/18/2023 13:27:33'!
findWithPrefix: aPrefix inStack:aStack
	^aPrefix beingSearchedBy: self  in: aStack.! !

!SentenceFinderByPrefix methodsFor: 'finders' stamp: 'Joa 9/18/2023 13:22:25'!
findWithSpacedPrefix
	^self error: self class spacedPrefixErrorDescription .
	! !

!SentenceFinderByPrefix methodsFor: 'finders' stamp: 'Joa 9/18/2023 13:23:51'!
findWithValidPrefix: aValidPrefix in: aStack
	| lista stackIterator |
	stackIterator := 	StackIterator new.
	
	lista:=stackIterator getAllElementsIn:aStack thatVerifies:[:stackElement| stackElement beginsWith: aValidPrefix ].

	^lista.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'AB 9/17/2023 21:06:57'!
prefixEmptyErrorDescription
	
	^ 'prefix is empty!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'AB 9/17/2023 21:07:34'!
spacedPrefixErrorDescription
	
	^ 'prefix have spaced!!!!!!'! !


!classDefinition: #StackIterator category: 'Stack-Exercise'!
Object subclass: #StackIterator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackIterator methodsFor: 'enumerating' stamp: 'Joa 9/18/2023 12:34:33'!
getAllElementsIn: aStackToIterate thatVerifies:aPredicate

	| stackAux elementsThatVerifyCondition |

	stackAux := 	OOStack new.
	elementsThatVerifyCondition:= OrderedCollection new.
	
	self  iterateThrough: aStackToIterate 
	       	doing: [:aStackElement|
				(aPredicate value: aStackElement ) ifTrue: [elementsThatVerifyCondition add: aStackElement ].
				]
		andKeepingValuesIn: stackAux.
	
	self    iterateThrough: stackAux 
		 doing: [:aStackElement |]
		 andKeepingValuesIn: aStackToIterate. 

	^elementsThatVerifyCondition! !

!StackIterator methodsFor: 'enumerating' stamp: 'Joa 9/18/2023 12:21:48'!
iterateThrough: aStackToIterate doing: aBlock andKeepingValuesIn: stackAux
	|topmostElementValue|	
	
	[aStackToIterate isEmpty] whileFalse:[  
			topmostElementValue := aStackToIterate pop.
			aBlock value: topmostElementValue.
			stackAux push: topmostElementValue.
			].! !


!classDefinition: #StackNode category: 'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 11:55:14'!
previusElement
	^self subclassResponsibility.! !

!StackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 11:58:17'!
value
 	^self subclassResponsibility.! !


!classDefinition: #BaseStackNode category: 'Stack-Exercise'!
StackNode subclass: #BaseStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 12:06:03'!
previusElement
	^self error: OOStack stackEmptyErrorDescription.! !

!BaseStackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 12:06:28'!
value
	^self error: OOStack  stackEmptyErrorDescription.! !


!classDefinition: #BodyStackNode category: 'Stack-Exercise'!
StackNode subclass: #BodyStackNode
	instanceVariableNames: 'previus value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BodyStackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 11:56:47'!
previusElement
	^previus.! !

!BodyStackNode methodsFor: 'accesing' stamp: 'AB 9/17/2023 11:59:06'!
value
	^value.! !


!BodyStackNode methodsFor: 'initializing' stamp: 'AB 9/17/2023 11:49:27'!
initalizeWith: anElement andPreviusNode:previusStackNode 
	value:=anElement.
	previus :=previusStackNode .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BodyStackNode class' category: 'Stack-Exercise'!
BodyStackNode class
	instanceVariableNames: ''!

!BodyStackNode class methodsFor: 'instantiating' stamp: 'AB 9/17/2023 12:09:49'!
with:anElement stackedOver:previusStackNode

	^self new initalizeWith: anElement andPreviusNode:previusStackNode .! !
