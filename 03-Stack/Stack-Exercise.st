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


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:02:00'!
test01EncuentraLaFraseQueCorrespondeAlPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: 'sum' inStack: stack .
	self assert: sentencesFound size = 1.
	self assert:	(sentencesFound  first = 'summer is here').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:02:34'!
test02EncuentraLasFrasesQueCorrespondenAlPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: 'win' inStack: stack .
	self assert: sentencesFound size = 2.
	self assert:	(sentencesFound  first = 'winning is everything').
	self assert:	(sentencesFound  last = 'winter is coming').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:03:08'!
test03NoEncuentraNingunaFraseParaElPrefijoDado
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: 'Hola' inStack: stack .
	self assert: sentencesFound isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:03:39'!
test04NoEncuentraLaFrasePorElCaseSensitive
|sentencesFound|
	sentencesFound :=senteceFinder findWithPrefix: 'Some' inStack: stack .
	self assert: sentencesFound isEmpty .
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:04:01'!
test05PrefijoInvalidoConEspacio
	self
		should: [ senteceFinder findWithPrefix: 'summer is' inStack: stack .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix spacedPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:04:11'!
test06PrefijoVacio
	self
		should: [ senteceFinder findWithPrefix: '' inStack: stack .]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'AB 9/17/2023 22:04:38'!
test07SeMatieneElStackIgual
	senteceFinder findWithPrefix: 'Wint' inStack: stack .
	self assert: stack size = 6.
	self assert: stack top = 'winning is everything'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topmostElement size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'yy' stamp: 'AB 9/17/2023 12:05:43'!
pop
	|lastPushedObject|
	lastPushedObject := topmostElement .
	topmostElement := topmostElement previusElement.
	size:=size-1.
	^lastPushedObject value.! !

!OOStack methodsFor: 'yy' stamp: 'AB 9/17/2023 12:10:18'!
push: anElement
topmostElement := BodyStackNode with: anElement stackedOver:topmostElement .
size:=size +1.
	! !

!OOStack methodsFor: 'yy' stamp: 'AB 9/17/2023 11:57:16'!
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


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 21:17:31'!
findWithPrefix:aPrefix inStack:aStack
	| lista stackIterator |
	stackIterator := 	StackIterator new.
	aPrefix isEmpty ifTrue: [^self error: 	self class prefixEmptyErrorDescription ].
	(aPrefix includesSubString: ' ' )ifTrue:[^self error: self class spacedPrefixErrorDescription ].
	lista:=stackIterator getAllElementsIn:aStack thatVerifies:[:stackElement| stackElement beginsWith: aPrefix].

	
	^lista.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 21:06:57'!
prefixEmptyErrorDescription
	
	^ 'prefix is empty!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 21:07:34'!
spacedPrefixErrorDescription
	
	^ 'prefix have spaced!!!!!!'! !


!classDefinition: #StackIterator category: 'Stack-Exercise'!
Object subclass: #StackIterator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackIterator methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 21:22:29'!
getAllElementsIn:aStack thatVerifies:aPredicate
| stackAux topmostElementValue elementsThatVerifyCondition |
stackAux := 	OOStack new.
elementsThatVerifyCondition:= OrderedCollection new.
	[aStack isEmpty] whileFalse:[  
			topmostElementValue:= aStack pop.
			(aPredicate value:topmostElementValue) ifTrue: [elementsThatVerifyCondition add:topmostElementValue].
			stackAux push: topmostElementValue.
			].
 [stackAux isEmpty] whileFalse:[ 
			topmostElementValue:= stackAux pop.
			aStack push: topmostElementValue.
			].
		^elementsThatVerifyCondition! !


!classDefinition: #StackNode category: 'Stack-Exercise'!
Object subclass: #StackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 11:55:14'!
previusElement
	^self subclassResponsibility.! !

!StackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 11:58:17'!
value
 	^self subclassResponsibility.! !


!classDefinition: #BaseStackNode category: 'Stack-Exercise'!
StackNode subclass: #BaseStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseStackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 12:06:03'!
previusElement
	^self error: OOStack stackEmptyErrorDescription.! !

!BaseStackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 12:06:28'!
value
	^self error: OOStack  stackEmptyErrorDescription.! !


!classDefinition: #BodyStackNode category: 'Stack-Exercise'!
StackNode subclass: #BodyStackNode
	instanceVariableNames: 'previus value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BodyStackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 11:49:27'!
initalizeWith: anElement andPreviusNode:previusStackNode 
	value:=anElement.
	previus :=previusStackNode .
	! !

!BodyStackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 11:56:47'!
previusElement
	^previus.! !

!BodyStackNode methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 11:59:06'!
value
	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BodyStackNode class' category: 'Stack-Exercise'!
BodyStackNode class
	instanceVariableNames: ''!

!BodyStackNode class methodsFor: 'as yet unclassified' stamp: 'AB 9/17/2023 12:09:49'!
with:anElement stackedOver:previusStackNode

	^self new initalizeWith: anElement andPreviusNode:previusStackNode .! !
