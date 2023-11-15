!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/15/2023 17:50:47'!
test01Import

	| numberOfCustomers |
	
	self importCustomers: 'input.txt'.
	
	numberOfCustomers := (session selectAllOfType: Customer) size.
	
	self assert: numberOfCustomers equals: 2.
	
	
	self assertCustomerExistsWithFirstName: 'Pepe' lastName: 'Sanchez'  identificationNumber: '22333444' ofType: 'D' andRegisteredAddreses: 2. 
	self assertAddresExistsWithStreetName: 'San Martin' streetNumber: 3322  zipCode: 1636 town: 'Olivos'  andProvince: 'BsAs'  forCustomerWithID: '22333444' ofType: 'D'.
	self assertAddresExistsWithStreetName: 'Maipu' streetNumber: 888  zipCode: 1122 town: 'Florida'  andProvince: 'Buenos Aires'  forCustomerWithID: '22333444' ofType: 'D'.
	
	
	self assertCustomerExistsWithFirstName: 'Juan' lastName: 'Perez' identificationNumber: '23-25666777-9' ofType: 'C'  andRegisteredAddreses: 1.
	self assertAddresExistsWithStreetName: 'Alem' streetNumber: 1122 zipCode: 1001  town: 'CABA'  andProvince: 'CABA' forCustomerWithID:  '23-25666777-9' ofType: 'C'.
	
	! !


!ImportTest methodsFor: 'support' stamp: 'jgv 11/15/2023 17:39:14'!
findCustomerWithIdentification: identificationNumber  ofType:  identificationType

	| customers |
	
	customers := session select: [:aCustomer | 
		aCustomer identificationType = identificationType and: [
			aCustomer identificationNumber = identificationNumber
			]
		]  
	ofType: Customer.
	self assert: customers size equals: 1.
	^customers anyOne.! !

!ImportTest methodsFor: 'support' stamp: 'jgv 11/15/2023 17:10:46'!
importCustomers: importFileName
	(CustomerImporter importFrom: importFileName withSession: session) import! !


!ImportTest methodsFor: 'setUp' stamp: 'jgv 11/13/2023 20:30:29'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp' stamp: 'jgv 11/13/2023 20:33:03'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'jgv 11/15/2023 17:45:29'!
assertAddresExistsWithStreetName: aStreetName streetNumber: aStreetNumber zipCode: aZipCode town: aTown andProvince: aProvince forCustomerWithID: anCustomerIdentificationNumber ofType: anIdentificationType      

	| customer pepesFirstAddress |

	customer := self findCustomerWithIdentification: anCustomerIdentificationNumber ofType: anIdentificationType.
	
	pepesFirstAddress := customer addresses detect: [:anAddress | anAddress streetName = aStreetName and: [ anAddress  zipCode = aZipCode]].
	self assert: pepesFirstAddress streetName equals: aStreetName.
	self assert: pepesFirstAddress streetNumber equals: aStreetNumber.
	self assert: pepesFirstAddress town equals: aTown.
	self assert: pepesFirstAddress zipCode equals: aZipCode.
	self assert: pepesFirstAddress province equals: aProvince.! !

!ImportTest methodsFor: 'assertions' stamp: 'jgv 11/15/2023 17:40:07'!
assertCustomerExistsWithFirstName: aFirstName lastName: aLastName identificationNumber: anIdentificationNumber ofType: anIdentificationType andRegisteredAddreses: anAmountOfRegisteredAddresses

	| customer |
	
	customer := self findCustomerWithIdentification: anIdentificationNumber ofType: anIdentificationType.
	
	self assert: customer firstName equals: aFirstName.
	self assert: customer lastName equals: aLastName.
	self assert: customer identificationType equals: anIdentificationType.
	self assert: customer identificationNumber equals: anIdentificationNumber.
	self assert: customer addresses size equals: anAmountOfRegisteredAddresses.
	
	^customer! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session importFileName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'jgv 11/15/2023 17:10:46'!
initializeImportFrom: anImportFileName withSession: aSession
	session := aSession.
	importFileName := anImportFileName.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/15/2023 17:10:46'!
import

| inputStream  newCustomer line |

	inputStream := UniFileStream new open: importFileName forWrite: false.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.
			session persist: newAddress].

		line := inputStream nextLine. ].

	inputStream close.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'jgv 11/15/2023 17:10:46'!
importFrom: anImportFileName withSession: aSession
	^self new initializeImportFrom: anImportFileName withSession: aSession! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
