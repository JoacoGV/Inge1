!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'jgv 9/11/2023 19:52:53'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Fraccion with: (Entero with: 7) over: (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'jgv 9/11/2023 19:53:03'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Fraccion with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'jgv 9/11/2023 19:53:15'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Fraccion with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'jgv 9/11/2023 19:53:20'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Fraccion with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'jgv 9/11/2023 19:42:17'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three := Entero  with: 3.
	four := Entero with: 4.
	five := Entero  with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := Fraccion with: one over: two.
	oneFifth := Fraccion with: one over: five.
	twoFifth := Fraccion with: two over: five.
	twoTwentyfifth :=  Fraccion  with: two over: (Entero with: 25).
	fiveHalfs := Fraccion with: five over: two.
	negativeOneHalf := Fraccion with: negativeOne over: two. ! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:38:56'!
* aMultiplier 

	^self subclassResponsibility.			! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AB 9/10/2023 18:58:29'!
+ anAdder 
	

	self subclassResponsibility .
	self error: 'Tipo de número no soportado'
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:48:21'!
// aDivisor 
	
	^self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:48:36'!
greatestCommonDivisorWith: anEntero 
	
	^self subclassResponsibility .! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AB 9/10/2023 18:55:16'!
negated
	
	type = #Entero ifTrue:
		[ ^self * (self class with: -1) ].
	type = #Fraccion ifTrue:
		[ ^self class with: numerator * (self class with: -1) over: denominator ].! !

!Numero methodsFor: 'arithmetic operations' stamp: 'AB 9/10/2023 18:55:16'!
printOn: aStream
	
	type = #Entero ifTrue:
		[ aStream print: value ].
	
	type = #Fraccion ifTrue:
		[ aStream 
			print: numerator;
			nextPut: $/;
			print: denominator ].! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:49:17'!
isNegative
	
	^self subclassResponsibility .! !

!Numero methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:31:42'!
isOne

	^self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:48:49'!
isZero

	^self subclassResponsibility ! !


!Numero methodsFor: 'comparing' stamp: 'jgv 9/11/2023 19:37:10'!
= anObject

	^self subclassResponsibility.! !

!Numero methodsFor: 'comparing' stamp: 'AB 9/10/2023 18:55:16'!
hash
	type = #Entero ifTrue:
		[ ^value hash ].
	type = #Fraccion ifTrue:
		[ ^(numerator hash / denominator hash) hash ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'instance creation' stamp: 'AB 9/10/2023 19:16:41'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !


!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:37:58'!
* aMultiplier 
		^self class with: value * aMultiplier integerValue.
		
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'AB 9/10/2023 18:35:36'!
+anAdder
	 ^self class with: value + anAdder integerValue ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:47:49'!
// aDivisor 
		^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:44:44'!
greatestCommonDivisorWith: anEntero 
		^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:50:44'!
negated
		 ^self * (self class with: -1).! !


!Entero methodsFor: 'initialization' stamp: 'AB 9/10/2023 19:07:38'!
initializeWith: aValue

	value := aValue! !


!Entero methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:45:45'!
isNegative
		^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:30:48'!
isOne
		^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'AB 9/10/2023 18:48:58'!
isZero
	^value = 0 ! !


!Entero methodsFor: 'comparing' stamp: 'jgv 9/11/2023 19:34:01'!
= anObject

	^(anObject isKindOf: self class) and: [value = anObject integerValue].! !


!Entero methodsFor: 'accessing' stamp: 'AB 9/10/2023 21:25:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'AB 9/10/2023 19:05:20'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initializeWith: aValue! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'initialization' stamp: 'AB 9/10/2023 19:08:29'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'accesing' stamp: 'AB 9/10/2023 21:23:16'!
denominator

	^denominator! !

!Fraccion methodsFor: 'accesing' stamp: 'AB 9/10/2023 21:23:43'!
numerator

	^numerator! !


!Fraccion methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:45:58'!
isNegative
		^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'jgv 9/11/2023 19:31:15'!
isOne
		^false.! !

!Fraccion methodsFor: 'testing' stamp: 'AB 9/10/2023 18:49:53'!
isZero
 	^false! !


!Fraccion methodsFor: 'comparing' stamp: 'jgv 9/11/2023 19:36:45'!
= anObject

	^(anObject isKindOf: self class) and: [(numerator * anObject denominator) = (denominator * anObject numerator)]! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:38:24'!
*aMultiplier

	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'AB 9/10/2023 18:35:55'!
+anAdder
		 | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jgv 9/11/2023 19:57:29'!
negated
		^self class with: numerator * (Entero with: -1) over: denominator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'AB 9/10/2023 19:08:52'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator! !


!Fraccion class methodsFor: 'error descriptions' stamp: 'jgv 9/11/2023 19:46:44'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !
