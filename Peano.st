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

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:04:15'!
+ unNumeroNatural

	^ unNumeroNatural  next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:03:51'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	^nextNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:58:54'!
restateA: unNumeroNatural

	^unNumeroNatural previous.
! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'JGV 8/24/2023 21:59:14'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:26:06'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:57:37'!
-unNumeroNatural
	^unNumeroNatural restateA: self.! !

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


!II class methodsFor: '--** private fileout/in **--' stamp: 'JGV 8/24/2023 21:59:14'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:46:40'!
+ unNumeroNatural

	^self previous + unNumeroNatural next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:47:00'!
-unNumeroNatural
	^ self previous - unNumeroNatural previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:46:40'!
next
	nextNumber ifNotNil: [^nextNumber ].
	nextNumber := self cloneNamed: self name, 'I'.
	nextNumber  previous: self.
	^nextNumber! !

!III class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:46:40'!
previous

	^previousNumber ! !

!III class methodsFor: 'as yet unclassified' stamp: 'JGV 8/24/2023 21:46:40'!
previous: unNumeroNatural

	previousNumber := unNumeroNatural .
	^unNumeroNatural.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'JGV 8/24/2023 21:59:14'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	nextNumber := nil.
	previousNumber := II.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!