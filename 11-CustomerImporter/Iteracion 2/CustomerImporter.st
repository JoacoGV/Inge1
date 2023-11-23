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


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
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
	instanceVariableNames: 'dataBaseSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:05'!
test01ImportValidDataWorksAsExpected

	CustomerImporter valueFrom: self validImportData into: dataBaseSystem.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:06'!
test02CanNotImportCustomerWithLessThanFiveFields

	

	self
		should: [CustomerImporter valueFrom: (ReadStream on: 'C,Pepe,Sanchez') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidCustomerImportValues.
				self assert: self getQuantityOfCustomers equals: 0.
			]! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:05'!
test03CanNotImportCustomerWithMoreThanFiveFields

	

	self
		should: [CustomerImporter valueFrom: (ReadStream on: 'C,Pepe,Sanchez,D,22333444,x') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidCustomerImportValues.
				self assert: self getQuantityOfCustomers equals: 0.
			]! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:06'!
test04CanNotImportAddressWithLessThanFiveFields
	self
		should: [CustomerImporter valueFrom: 
			(ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidAddressImportValues.
				self assert: self getQuantityOfAddresses equals: 0.
			].! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:05'!
test05CanNotImportAddressWithMoreThanFiveFields
	self
		should: [CustomerImporter valueFrom: 
			(ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidAddressImportValues.
				self assert: self getQuantityOfAddresses equals: 0.
			].! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:05'!
test06CanNotImportRecordWithInvalidRecordType

	self
		should: [CustomerImporter valueFrom: (ReadStream on: 'R,Pepe,Sanchez,D,22333444') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidRecordType.
				self assert: self getQuantityOfCustomers equals: 0.
			]! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:06'!
test07CanNotImportRecordWithRecordTypeFieldHavingACAndSomethingMore

	self
		should: [CustomerImporter valueFrom: (ReadStream on: 'CA,Pepe,Sanchez,D,22333444') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidRecordType.
				self assert: self getQuantityOfCustomers equals: 0.
			]! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:06'!
test08CanNotImportRecordWithRecordTypeFieldHavingAnAAndSomethingMore

	self
		should: [CustomerImporter valueFrom: (ReadStream on:
'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs') into: dataBaseSystem.]
		raise: Error
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter InvalidRecordType.
				self assert: self getQuantityOfAddresses equals: 0.
			]! !

!ImportTest methodsFor: 'tests' stamp: 'jgv 11/22/2023 20:54:05'!
test09CanNotAddAddressesWithNoCustomer

	self
		should: [CustomerImporter valueFrom: (ReadStream on:'A,San Martin,3322,Olivos,1636,BsAs') into: dataBaseSystem.]
		raise: Error 
		withExceptionDo: [:anError | 
				self assert: anError messageText equals: CustomerImporter CantImportAddressWithoutCustomer.
				self assert: self getQuantityOfAddresses equals: 0.
			].! !


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

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'jgv 11/16/2023 19:41:08'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: self getQuantityOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'jgv 11/22/2023 21:29:51'!
setUp

	dataBaseSystem :=  TransientDataBaseSystem for: (Array with: Address with: Customer).
	dataBaseSystem beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'jgv 11/22/2023 20:59:46'!
tearDown
	dataBaseSystem commit.
	dataBaseSystem close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'jgv 11/22/2023 20:54:05'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (dataBaseSystem
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'jgv 11/22/2023 20:54:05'!
getQuantityOfAddresses
	^ (dataBaseSystem selectAllOfType: Address) size! !

!ImportTest methodsFor: 'test data' stamp: 'jgv 11/22/2023 20:54:06'!
getQuantityOfCustomers

	^ (dataBaseSystem selectAllOfType: Customer) size! !

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


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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
	instanceVariableNames: 'dataBaseSystem readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'jgv 11/22/2023 21:03:38'!
initializeFrom: aReadStream into: aDataBaseSystem
	dataBaseSystem := aDataBaseSystem.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 19:36:38'!
canGetNextRecord

	line := readStream nextLine. ^line notNil.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 19:49:02'!
createRecord

	^ record := self getRecordFromLine! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 19:48:49'!
getRecordFromLine

	^ line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/21/2023 16:37:58'!
importAddress

	| newAddress |
	
	record size ~= 6 ifTrue: [self error: CustomerImporter InvalidAddressImportValues ].	
	newCustomer isNil ifTrue: [self error: CustomerImporter CantImportAddressWithoutCustomer ].
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/22/2023 21:03:30'!
importCustomer
	
	record size ~= 5 ifTrue: [self error: CustomerImporter InvalidCustomerImportValues ].
	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			dataBaseSystem persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 21:35:14'!
importRecord
	(self isCustomerRecord) ifTrue: [			^self importCustomer ].
	(self isAddressRecord) ifTrue: [ ^self importAddress ].
	self error: CustomerImporter InvalidRecordType.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 21:41:37'!
isAddressRecord

	^ record first = 'A'.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 21:40:13'!
isCustomerRecord

	^ record first = 'C'.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'jgv 11/16/2023 19:49:02'!
value

	"
	self importCustomers
	"
	 
	 
	
	[ self canGetNextRecord. ] whileTrue: [
		self createRecord.
		self importRecord.
	].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'jgv 11/22/2023 21:03:04'!
from: aReadStream into: aDataBaseSystem
	^self new initializeFrom: aReadStream into: aDataBaseSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'jgv 11/22/2023 21:04:27'!
valueFrom: aReadStream into: aDataBaseSystem

	^(self from: aReadStream into: aDataBaseSystem) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'jgv 11/21/2023 16:37:03'!
CantImportAddressWithoutCustomer
	^'No se puede importar una dirección sin un cliente asociado.'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'jgv 11/16/2023 20:18:13'!
InvalidAddressImportValues
	^'Address should have five fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'jgv 11/16/2023 19:49:56'!
InvalidCustomerImportValues
	^'Customer record should have fields'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'jgv 11/16/2023 20:12:31'!
InvalidRecordType
	^'Import only allows lines that stars with letter C or A'.! !


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


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
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


!classDefinition: #DataBaseSystem category: 'CustomerImporter'!
Object subclass: #DataBaseSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSystem methodsFor: 'initialization' stamp: 'jgv 11/22/2023 21:16:28'!
initializeForConfiguration: aConfiguration

	self subclassResponsibility! !


!DataBaseSystem methodsFor: 'persisting' stamp: 'jgv 11/22/2023 21:16:37'!
persist: aValue

	self subclassResponsibility! !


!DataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 21:16:45'!
select: aCondition ofType: aType

	self subclassResponsibility! !

!DataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 21:16:51'!
selectAllOfType: aType

	self subclassResponsibility! !


!DataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 21:16:58'!
beginTransaction

	self subclassResponsibility! !

!DataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 21:17:03'!
commit

	self subclassResponsibility! !


!DataBaseSystem methodsFor: 'closing' stamp: 'jgv 11/22/2023 21:25:29'!
close

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSystem class' category: 'CustomerImporter'!
DataBaseSystem class
	instanceVariableNames: ''!

!DataBaseSystem class methodsFor: 'instance creation' stamp: 'jgv 11/22/2023 21:12:39'!
for: aConfiguration

	self subclassResponsibility! !


!classDefinition: #PersistentDataBaseSystem category: 'CustomerImporter'!
DataBaseSystem subclass: #PersistentDataBaseSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentDataBaseSystem methodsFor: 'closing' stamp: 'jgv 11/22/2023 21:00:37'!
close
	session close.! !


!PersistentDataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 20:53:38'!
beginTransaction
	session beginTransaction.! !

!PersistentDataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 21:00:51'!
commit
	session commit.! !


!PersistentDataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 21:07:41'!
select: aCondition ofType: aType 
	^session select: aCondition  ofType: aType.! !

!PersistentDataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 20:57:19'!
selectAllOfType: aType 
	^session selectAllOfType: aType.! !


!PersistentDataBaseSystem methodsFor: 'persisting' stamp: 'jgv 11/22/2023 21:06:23'!
persist: aValue 
	session persist: aValue.! !


!PersistentDataBaseSystem methodsFor: 'initialization' stamp: 'jgv 11/22/2023 20:51:35'!
initializeForConfiguration: aConfiguration
	session := DataBaseSession for: aConfiguration.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentDataBaseSystem class' category: 'CustomerImporter'!
PersistentDataBaseSystem class
	instanceVariableNames: ''!

!PersistentDataBaseSystem class methodsFor: 'instance creation' stamp: 'jgv 11/22/2023 20:55:38'!
for: aConfiguration
	^self new initializeForConfiguration: aConfiguration.! !


!classDefinition: #TransientDataBaseSystem category: 'CustomerImporter'!
DataBaseSystem subclass: #TransientDataBaseSystem
	instanceVariableNames: 'data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientDataBaseSystem methodsFor: 'initialization' stamp: 'jgv 11/22/2023 21:18:25'!
initializeForConfiguration: aConfiguration
	data := Set new.! !


!TransientDataBaseSystem methodsFor: 'persisting' stamp: 'jgv 11/22/2023 21:19:07'!
persist: aValue

	data add: 	aValue.! !


!TransientDataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 21:23:27'!
select: aCondition ofType: aType

	^data select: [ :aValue |
			(aCondition value: aValue) and: [ aValue isKindOf: aType].			
		].! !

!TransientDataBaseSystem methodsFor: 'selecting' stamp: 'jgv 11/22/2023 21:24:17'!
selectAllOfType: aType

	^data select: [:aValue | aValue isKindOf: aType].! !


!TransientDataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 21:24:28'!
beginTransaction! !

!TransientDataBaseSystem methodsFor: 'transaction managment' stamp: 'jgv 11/22/2023 21:24:36'!
commit! !


!TransientDataBaseSystem methodsFor: 'closing' stamp: 'jgv 11/22/2023 21:27:03'!
close

	^data removeAll.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransientDataBaseSystem class' category: 'CustomerImporter'!
TransientDataBaseSystem class
	instanceVariableNames: ''!

!TransientDataBaseSystem class methodsFor: 'instance creation' stamp: 'jgv 11/22/2023 21:17:28'!
for: aConfiguration
	^self new initializeForConfiguration: aConfiguration.! !
