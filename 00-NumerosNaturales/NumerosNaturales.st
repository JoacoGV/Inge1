!classDefinition: #I category: 'NumerosNaturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'NumerosNaturales'!
I class
	instanceVariableNames: 'nextNumber'!

!I class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 10:39:32'!
*unNumero

	^unNumero .! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:04:15'!
+ unNumeroNatural

	^ unNumeroNatural  next! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:45:38'!
-unNumero
	^self error:self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:46:48'!
/ unNumero
	
	self = unNumero ifTrue: [^I].
	^self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 22:12:25'!
< unNumero
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:46:32'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No puede realizar la division'! !

!I class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:45:21'!
descripcionDeErrorDeNumerosNegativosNoSoportados
 	^'No se puede realizar la resta'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:03:51'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	^nextNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:58:54'!
restateA: unNumeroNatural

	^unNumeroNatural previous.
! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := II.! !


!classDefinition: #II category: 'NumerosNaturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'NumerosNaturales'!
II class
	instanceVariableNames: 'nextNumber previousNumber'!

!II class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 10:43:26'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:26:06'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:57:37'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 22:09:46'!
/ unNumero
	
	self = unNumero ifTrue: [^I].
	(self < unNumero)  ifTrue:[^self error:self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^I + (self - unNumero / unNumero). ! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 22:12:19'!
<unNumero
	unNumero=I ifTrue:[^false].
	^self previous < unNumero previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:47:27'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No puede realizar la division'! !

!II class methodsFor: 'as yet unclassified' stamp: 'AB 8/28/2023 21:11:09'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := II createChildNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:21:22'!
previous

	^previousNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:20:28'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:58:24'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := III.
	previousNumber := I.! !


!classDefinition: #III category: 'NumerosNaturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'NumerosNaturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIII.
	previousNumber := II.! !


!classDefinition: #IIII category: 'NumerosNaturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'NumerosNaturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIII.
	previousNumber := III.! !


!classDefinition: #IIIII category: 'NumerosNaturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'NumerosNaturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIII.
	previousNumber := IIII.! !


!classDefinition: #IIIIII category: 'NumerosNaturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'NumerosNaturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIII.
	previousNumber := IIIII.! !


!classDefinition: #IIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'NumerosNaturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIIII.
	previousNumber := IIIIII.! !


!classDefinition: #IIIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'NumerosNaturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIIIII.
	previousNumber := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'NumerosNaturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIIIIII.
	previousNumber := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'NumerosNaturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIIIIIII.
	previousNumber := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'NumerosNaturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIIIIIIII.
	previousNumber := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'NumerosNaturales'!
II subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosNaturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'NumerosNaturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'AB 8/29/2023 09:59:39'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := nil.
	previousNumber := IIIIIIIIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!