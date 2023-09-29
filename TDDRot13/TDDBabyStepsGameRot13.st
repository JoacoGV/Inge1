!classDefinition: #TDDBabyStepsRot13Test category: 'TDDBabyStepsGameRot13'!
TestCase subclass: #TDDBabyStepsRot13Test
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameRot13'!

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:18:16'!
test01CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $n equals: $a asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:18:37'!
test02CorrectlyEncodesALowercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $z equals: $m asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:20:12'!
test03CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $a equals: $n asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:21:05'!
test04CorrectlyEncodesALowercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $m equals: $z asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:31:52'!
test05CharOnTheBelowRangeDoesntChange
	
	self assert: $` equals: $` asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:33:58'!
test06CharOnTheUpperRangeDoesntChange
	
	self assert: ${ equals: ${ asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:34:13'!
test07CorrectlyEncodesAnUppercaseCharFromTheFirstPartOfTheAlphabet
	
	self assert: $N equals: $A asRot13.
	self assert: $Z equals: $M asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:44:19'!
test08CorrectlyEncodesAnUppercaseCharFromTheSecondPartOfTheAlphabet
	
	self assert: $A equals: $N asRot13.
	self assert: $M equals: $Z asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:46:53'!
test09TheEmptyStringDoesntChange
	
	self assert: '' equals: '' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:47:18'!
test10CorrectlyEncodesAOneCharString
	
	self assert: 'n' equals: 'a' asRot13.
	self assert: 'Z' equals: 'M' asRot13.
	self assert: 'a' equals: 'n' asRot13.
	self assert: '{' equals: '{' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:48:26'!
test11CorrectlyEncodesATwoCharString
	
	self assert: 'nm' equals: 'az' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:50:09'!
test12CorrectlyEncodesMoreThanTwoCharString
	
	self assert: 'uByN!!' equals: 'hOlA!!' asRot13
	! !

!TDDBabyStepsRot13Test methodsFor: 'tests' stamp: 'AB 9/28/2023 21:51:07'!
testExtraToCheckGeneralizationOnKata
		
	self assert: 'Ju3er j3 4e3 t01at j3 q0ag a3rq e04q$...' equals: 'Wh3re w3 4r3 g01ng w3 d0nt n3ed r04d$...' asRot13
	! !
