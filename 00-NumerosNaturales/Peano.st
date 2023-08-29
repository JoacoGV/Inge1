!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'nextNumber'!

!I class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 10:39:32'!
*unNumero

	^unNumero .! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:04:15'!
+ unNumeroNatural

	^ unNumeroNatural  next! !

!I class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:59:32'!
/ unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero).! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:03:51'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	^nextNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:58:54'!
restateA: unNumeroNatural

	^unNumeroNatural previous.
! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := II.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:59:07'!
/ unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:18:57'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
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


!II class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := III.
	previousNumber := I.! !


!classDefinition: #III category: 'Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: 'nextNumber previousNumber'!

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:16'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
/unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
previous

	^previousNumber ! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!III class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIII.
	previousNumber := II.! !


!classDefinition: #IIII category: 'Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: 'nextNumber previousNumber'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
/unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
previous

	^previousNumber ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:23:17'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIII.
	previousNumber := III.! !


!classDefinition: #IIIII category: 'Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Peano'!
IIIII class
	instanceVariableNames: 'nextNumber previousNumber'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
/unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous

	^previousNumber ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIII.
	previousNumber := IIII.! !


!classDefinition: #IIIIII category: 'Peano'!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Peano'!
IIIIII class
	instanceVariableNames: 'nextNumber previousNumber'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
/unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous

	^previousNumber ! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := IIIIIII.
	previousNumber := IIIII.! !


!classDefinition: #IIIIIII category: 'Peano'!
DenotativeObject subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Peano'!
IIIIIII class
	instanceVariableNames: 'nextNumber previousNumber'!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
*unNumero

	^unNumero + (unNumero*self previous ).
	! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
/unNumero
	
	self = unNumero ifTrue: [^I].
	^I + (self - unNumero / unNumero). ! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous

	^previousNumber ! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'Joa 8/27/2023 11:35:05'!
restateA: unNumeroNatural

	^unNumeroNatural previous - self previous.! !


!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'Joa 8/27/2023 12:43:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := nil.
	previousNumber := IIIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
