!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'jgv 11/23/2023 20:04:53'!
add: newObject

	super addCustomers: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 18:31:29'!
test01ValidSupplierDataIsImportedCorrectly
	| stream supplier |
	
	stream := ReadStream on: 'S,Supplier1,D,123'.
	SupplierImporter valueFrom: stream into: system.
	self assert: system numberOfSuppliers equals: 1.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	self assert: (supplier isNamed: 'Supplier1').
	self assert: (supplier isIdentifiedAs: 'D' withNumber: '123').
	self assert: (supplier isAddressesEmpty).
	self assert: (supplier isCustomersEmpty). ! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 19:09:02'!
test02DoesNotImportRecordsStartingWithSButMoreCharacters
	| stream |
	stream := ReadStream on: 'Supplier,Supplier1,D,123'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidRecordTypeErrorDescription.
			self assert: system numberOfSuppliers equals: 0.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 19:21:06'!
test03CanNotImportSupplierRecordWithLessThanFourFields
	| stream |
	stream := ReadStream on: 'S,Supplier1'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidSupplierRecordErrorDescription.
			self assert: system numberOfSuppliers equals: 0.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 19:24:53'!
test04CanNotImportSupplierRecordWithMoreThanFourFields
	| stream |
	stream := ReadStream on: 'S,Supplier1,D,123,Fravega'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidSupplierRecordErrorDescription.
			self assert: system numberOfSuppliers equals: 0.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:21:56'!
test05ValidSupplierWithNewCustomerDataIsImportedCorrectly
	| stream supplier customer |
	
	stream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'.

	SupplierImporter valueFrom: stream into: system.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	
	self assert: system numberOfCustomers equals: 1.
	customer := supplier customerWithIdentificationType: 'D' number: '22333444' ifNone: [self fail].
	self assert: customer firstName equals: 'Pepe'.
	self assert: customer lastName equals: 'Sanchez'.
	self assert: customer identificationType equals: 'D'.
	self assert: customer identificationNumber equals: '22333444'.
	! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:25:49'!
test06DoesNotImportRecordsStartingWithNCButMoreCharacters
	| stream supplier |
	
	stream := ReadStream on: 'S,Supplier1,D,123
NCustomer,Pepe,Sanchez,D,22333444'.

	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidRecordTypeErrorDescription.
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 0.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:31:03'!
test07CanNotImportNewCustomerRecordWithLessThanFiveFields
	| stream supplier |
	stream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 0.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:31:49'!
test08CanNotImportNewCustomerRecordWithMoreThanFiveFields
	| stream supplier |
	stream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez, D, 122333444, Alias: Pepoide'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 0.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 21:14:18'!
test09CanNotImportNewCustomerWithoutSupplier
	| stream |
	stream := ReadStream on: 'NC,Pepe,Sanchez, D, 122333444'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter cannotImportCustomerWithoutSupplier.
		].! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:49:58'!
test10ValidSupplierWithExistingCustomerDataIsImportedCorrectly
	| stream supplier customer |
	
	CustomerImporter valueFrom: self validImportData into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
EC,D,22333444'.

	SupplierImporter valueFrom: stream into: system.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	
	self assert: system numberOfCustomers equals: 2.
	customer := supplier customerWithIdentificationType: 'D' number: '22333444' ifNone: [self fail].
	self assert: customer firstName equals: 'Pepe'.
	self assert: customer lastName equals: 'Sanchez'.
	self assert: customer identificationType equals: 'D'.
	self assert: customer identificationNumber equals: '22333444'.
	! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:53:14'!
test11DoesNotImportRecordsStartingWithECButMoreCharacters
	| stream supplier |
	
	CustomerImporter valueFrom: self validImportData into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
ECustomer,D,22333444'.

	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidRecordTypeErrorDescription.
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 2.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 20:58:37'!
test12CanNotImportExistingCustomerRecordWithLessThanThreeFields
	| stream supplier |
	
	CustomerImporter valueFrom: self validImportData into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
EC,22333444'.

	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidExistingCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 2.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 21:03:37'!
test13CanNotImportExistingCustomerRecordWithMoreThanThreeFields
	| stream supplier |
	
	CustomerImporter valueFrom: self validImportData into: system.
	
	stream := ReadStream on: 'S,Supplier1,D,123
EC,Pepe,Sanchez,D,22333444'.

	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter invalidExistingCustomerRecordErrorDescription .
			self assert: system numberOfSuppliers equals: 1.
			supplier := system supplierWithIdentificationType: 'D' number: '123'.
			self assert: system numberOfCustomers equals: 2.
			self assert: supplier isCustomersEmpty.
		]! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 21:14:40'!
test14CanNotImportExistingCustomerWithoutSupplier
	| stream |
	stream := ReadStream on: 'EC,Pepe, Sanchez, D, 122333444'.
	self should: [SupplierImporter valueFrom: stream into: system]
	raise: Error
	withExceptionDo: [ :anError | 
			self assert: anError messageText equals: SupplierImporter cannotImportCustomerWithoutSupplier .
		].! !

!ImportTest methodsFor: 'tests-suppliers' stamp: 'jgv 11/23/2023 21:24:32'!
test15ValidSupplierWithAddressDataIsImportedCorrectly
	| stream supplier address |
	
	stream := ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'.

	SupplierImporter valueFrom: stream into: system.
	supplier := system supplierWithIdentificationType: 'D' number: '123'.
	
	address := supplier addressAt: 'San Martin' ifNone: [self fail].
	self assert: address streetName equals: 'San Martin'.
	self assert: address streetNumber equals: 3322.
	self assert: address town equals: 'Olivos'.
	self assert: address zipCode equals: 1636.
	self assert: address province equals: 'BsAs'.
	! !


!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'jgv 11/23/2023 18:44:17'!
setUp

	system := Environment current createERPSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'readStream system line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'initialization' stamp: 'jgv 11/23/2023 18:37:51'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!CSVImporter methodsFor: 'evaluating' stamp: 'jgv 11/23/2023 18:38:51'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 18:39:47'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 18:39:33'!
createRecord

	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 18:39:39'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 18:40:01'!
importRecord

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'importing' stamp: 'jgv 11/23/2023 18:36:38'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CSVImporter class methodsFor: 'instance creation' stamp: 'jgv 11/23/2023 18:37:15'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 20:04:53'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system addCustomers: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 19:13:38'!
importRecord

	self assertRecordNotEmpty.
	
	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:24:11'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
CSVImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'supplier' stamp: 'jgv 11/23/2023 20:40:55'!
assertValidSupplierRecord

	^ record size ~= 4 ifTrue: [self error: SupplierImporter invalidSupplierRecordErrorDescription]! !

!SupplierImporter methodsFor: 'supplier' stamp: 'jgv 11/23/2023 20:40:55'!
importSupplier

	self assertValidSupplierRecord. 
	
	newSupplier := Supplier new.
	newSupplier name: record second.
	newSupplier identificationType: record third.
	newSupplier identificationNumber: record fourth.
	system addSupplier: newSupplier! !

!SupplierImporter methodsFor: 'supplier' stamp: 'jgv 11/23/2023 20:39:55'!
isSupplierRecord

	^ record first = 'S'! !


!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 21:04:16'!
assertIsValidExistingCustomer

	^ record size ~= 3 ifTrue: [self error: SupplierImporter invalidExistingCustomerRecordErrorDescription]! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 21:02:01'!
assertIsValidNewCustomerRecord

	^ record size ~= 5 ifTrue: [self error: SupplierImporter invalidCustomerRecordErrorDescription ]! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 21:14:18'!
assertSupplierWasImported

	^ newSupplier isNil ifTrue: [self error: SupplierImporter cannotImportCustomerWithoutSupplier ]! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 21:12:39'!
importExistingCustomer
	 |existingCustomer |
	self assertSupplierWasImported.
	self assertIsValidExistingCustomer. 
	existingCustomer := system customerWithIdentificationType: record second number: record third.
	newSupplier addCustomer: existingCustomer.! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 21:02:01'!
importNewCustomer

	self assertSupplierWasImported	.
	self assertIsValidNewCustomerRecord.

	newCustomer := Customer new.
	newSupplier addCustomer: newCustomer.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	system addCustomers: newCustomer.! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 20:47:21'!
isExistingCustomerRecord
	^record first = 'EC'.! !

!SupplierImporter methodsFor: 'customer' stamp: 'jgv 11/23/2023 20:40:23'!
isNewCustomerRecord

	^ record first = 'NC'! !


!SupplierImporter methodsFor: 'evaluating - private' stamp: 'jgv 11/23/2023 21:21:35'!
importRecord
	
	(self isSupplierRecord) ifTrue: [
			^self importSupplier.
		].
	(self isNewCustomerRecord) ifTrue: [
			^self importNewCustomer.
		].
	(self isExistingCustomerRecord) ifTrue: [
			^self importExistingCustomer.
		].
	(record first = 'A') ifTrue: [
			^self importAddress.
		].
	self error: SupplierImporter invalidRecordTypeErrorDescription.
	! !


!SupplierImporter methodsFor: 'address' stamp: 'jgv 11/23/2023 21:22:12'!
importAddress

	| newAddress |

	newAddress := Address new.
	newSupplier addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'error description' stamp: 'jgv 11/23/2023 21:14:18'!
cannotImportCustomerWithoutSupplier
	^'Cannot import new customer without supplier'! !

!SupplierImporter class methodsFor: 'error description' stamp: 'jgv 11/23/2023 20:29:32'!
invalidCustomerRecordErrorDescription
	^'invalid customer record'.! !

!SupplierImporter class methodsFor: 'error description' stamp: 'jgv 11/23/2023 21:11:46'!
invalidExistingCustomerRecordErrorDescription
	^'invalid existing customer record'.! !

!SupplierImporter class methodsFor: 'error description' stamp: 'jgv 11/23/2023 19:15:28'!
invalidRecordTypeErrorDescription
	^'Invalid record type'.! !

!SupplierImporter class methodsFor: 'error description' stamp: 'jgv 11/23/2023 19:20:41'!
invalidSupplierRecordErrorDescription
	^'Invalid Supplier record'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'jgv 11/23/2023 20:04:53'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table addCustomers: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #ERPSystem category: 'CustomerImporter'!
Object subclass: #ERPSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ERPSystem methodsFor: 'customers' stamp: 'jgv 11/23/2023 20:04:53'!
addCustomers: aCustomer

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!ERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!ERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentERPSystem category: 'CustomerImporter'!
ERPSystem subclass: #PersistentERPSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentERPSystem methodsFor: 'customers' stamp: 'jgv 11/23/2023 20:04:53'!
addCustomers: aCustomer

	^session persist: aCustomer ! !

!PersistentERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 11/14/2023 09:21:54'!
start

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !

!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientERPSystem category: 'CustomerImporter'!
ERPSystem subclass: #TransientERPSystem
	instanceVariableNames: 'customers suppliers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'jgv 11/23/2023 18:22:18'!
start

	customers := OrderedCollection new.
	suppliers := OrderedCollection new.! !

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:23:17'!
stop

	customers := nil! !


!TransientERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientERPSystem methodsFor: 'customers' stamp: 'jgv 11/23/2023 20:06:29'!
addCustomers: aCustomer

	customers add: aCustomer ! !

!TransientERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:22:52'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!TransientERPSystem methodsFor: 'suppliers' stamp: 'jgv 11/23/2023 20:05:56'!
addSupplier: aNewSupplier 
	suppliers add: aNewSupplier.! !

!TransientERPSystem methodsFor: 'suppliers' stamp: 'jgv 11/23/2023 18:22:49'!
numberOfSuppliers
	^suppliers size.! !

!TransientERPSystem methodsFor: 'suppliers' stamp: 'jgv 11/23/2023 18:25:59'!
supplierWithIdentificationType: anIdentificationType number: anIdentificationNumber 
		^suppliers detect: [ :aSupplier | aSupplier identificationType = anIdentificationType and: [ aSupplier identificationNumber = anIdentificationNumber ]]! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Environment methodsFor: 'customer system' stamp: 'jgv 11/23/2023 18:43:45'!
createERPSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentKey

	^ #ENV! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:46'!
environmentVariable

	^ Smalltalk at: self environmentKey! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:09'!
identifier

	self subclassResponsibility! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !

!Environment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:46:01'!
makeCurrent

	"
	Tener en cuenta que en Smalltalk se podría poner directamente la clase de environment,
	esto es DevelopmentEnvironment o IntegrationEnvironmet o hasta una instancia de ellas,
	pero se está simulando el hecho de que esto esté definido por fuera del sistema, como una
	variable del sistema operativo - Hernan"
	
	Smalltalk at: self environmentKey put: self identifier! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'jgv 11/23/2023 18:43:45'!
createERPSystem

	^TransientERPSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:42:50'!
identifier

	^ #DEV! !

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:52'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'jgv 11/23/2023 18:43:45'!
createERPSystem

	^PersistentERPSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:43:07'!
identifier

	^ #INT! !

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 11/23/2023 16:44:04'!
isCurrent

	"
	self makeCurrent
	"
	^self environmentVariable = self identifier! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'identificationNumber identificationType addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'identification' stamp: 'jgv 11/23/2023 18:53:47'!
identificationNumber

	^identificationNumber ! !

!Party methodsFor: 'identification' stamp: 'jgv 11/23/2023 18:52:07'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Party methodsFor: 'identification' stamp: 'jgv 11/23/2023 18:53:51'!
identificationType

	^identificationType ! !

!Party methodsFor: 'identification' stamp: 'jgv 11/23/2023 18:52:17'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !

!Party methodsFor: 'identification' stamp: 'jgv 11/23/2023 18:53:00'!
isIdentifiedAs: anIdentificationType withNumber: anIndentificationNumber 
	^identificationType = anIdentificationType and: [identificationNumber = anIndentificationNumber ].! !


!Party methodsFor: 'addresses' stamp: 'jgv 11/23/2023 20:19:32'!
addAddress: anAddress

	addresses add: anAddress ! !

!Party methodsFor: 'addresses' stamp: 'jgv 11/23/2023 18:55:29'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Party methodsFor: 'addresses' stamp: 'jgv 11/23/2023 18:55:32'!
addresses

	^ addresses! !

!Party methodsFor: 'addresses' stamp: 'jgv 11/23/2023 18:55:35'!
isAddressesEmpty

	^addresses isEmpty ! !


!Party methodsFor: 'initialization' stamp: 'jgv 11/23/2023 18:56:32'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'id firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

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


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'name customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'customers' stamp: 'jgv 11/23/2023 20:19:50'!
addCustomer: aNewCustomer 
	customers add: aNewCustomer.! !

!Supplier methodsFor: 'customers' stamp: 'jgv 11/23/2023 20:15:29'!
customerWithIdentificationType: anIdentificationType number: anIdentificationNumber ifNone: aNoneBlock  
	^customers detect: [:aCustomer | aCustomer identificationType = anIdentificationType and: [ aCustomer identificationNumber = anIdentificationNumber ]] ifNone: aNoneBlock.! !

!Supplier methodsFor: 'customers' stamp: 'jgv 11/23/2023 18:28:31'!
isCustomersEmpty
	^customers isEmpty.! !


!Supplier methodsFor: 'name' stamp: 'jgv 11/23/2023 18:26:42'!
isNamed: aName 
	^name = aName.! !

!Supplier methodsFor: 'name' stamp: 'jgv 11/23/2023 18:19:44'!
name: aName 
	name := aName.! !


!Supplier methodsFor: 'initialization' stamp: 'jgv 11/23/2023 18:30:28'!
initialize
	super initialize.
	customers := OrderedCollection new.! !


!Supplier methodsFor: 'addresses' stamp: 'jgv 11/23/2023 21:23:09'!
addressAt: aStreetName number: aStreetNumber ifNone: aNoneBlock 
	self shouldBeImplemented.! !
