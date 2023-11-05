!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'Joaco 11/2/2023 19:55:56'!
createCart

	^ Cart acceptingItemsOf: self validItems! !

!CashierTest methodsFor: 'support' stamp: 'jgv 11/5/2023 11:18:44'!
createCashier

	^ Cashier withPriceList: self priceList for: self createCart withCreditCard: self notExpiredCreditCard atDate: FixedGregorianDate today.! !

!CashierTest methodsFor: 'support' stamp: 'jgv 11/5/2023 11:20:01'!
expiredCreditCard
	^CreditCard number: '1234567891011121' expirationDate: FixedGregorianDate today monthOfYear previous securityCode: '123'.! !

!CashierTest methodsFor: 'support' stamp: 'jgv 11/5/2023 11:17:36'!
notExpiredCreditCard
	^CreditCard number: '1234567891011121' expirationDate: FixedGregorianDate today monthOfYear securityCode: '123'.! !

!CashierTest methodsFor: 'support' stamp: 'Joaco 11/2/2023 19:19:21'!
priceList
	|aPriceList|
	
	aPriceList := Dictionary new.
	aPriceList add: 'aValidItem' -> 100.
	aPriceList add: 'anotherValidItem' -> 50.
	
	^aPriceList.! !

!CashierTest methodsFor: 'support' stamp: 'Joaco 11/2/2023 19:44:30'!
validItems
	^Array with: 'aValidItem' with: 'anotherValidItem'! !


!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 11:12:01'!
test01CashierCantCheckoutAnEmptyCart
	
	self should: [Cashier withPriceList: self priceList for: self createCart withCreditCard: self notExpiredCreditCard atDate: FixedGregorianDate today.]
	raise: Error - MessageNotUnderstood
	 withExceptionDo: [ :anError | 
		self assert: anError messageText equals: Cashier CanNotCheckoutAnEmptyCartErrorDescription
		].! !

!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 12:55:53'!
test02CashierCanCheckoutACartWithOneBook
	
	| aCashier aCart paymentProcessor paymentRegister |
	
	aCart := self createCart.
	aCart add: 'aValidItem'.
	
	paymentProcessor := TestPaymentProcessor expectedBehaviour: [^1].
	paymentRegister := OrderedCollection new.
	
	aCashier := Cashier withPriceList: self priceList for: aCart withCreditCard: 	self notExpiredCreditCard atDate: FixedGregorianDate today processedBy: paymentProcessor toBeRegisteredIn: paymentRegister.
	
	self assert: (aCashier checkout ) equals: 100.
	self assert: (paymentRegister includes: aCashier)
! !

!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 12:56:10'!
test03CashierCanCheckoutACartWithMoreThanOneItem
	
	| aCashier aCart paymentProcessor paymentRegister |
	
	aCart := self createCart.
	aCart add: 'aValidItem' withOcurrences: 3.
	aCart add: 'anotherValidItem' withOcurrences: 1.
	
	paymentProcessor := TestPaymentProcessor expectedBehaviour: [^1].
	paymentRegister := OrderedCollection new.
	
	aCashier := Cashier withPriceList: self priceList for: aCart withCreditCard: 	self expiredCreditCard atDate: FixedGregorianDate today processedBy: paymentProcessor toBeRegisteredIn: paymentRegister .
	
	
	self assert: (aCashier checkout) equals: 350.
	self assert: (paymentRegister includes: aCashier)
! !

!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 11:19:11'!
test04CashierCannotCheckoutIfCreditCardIsExpired
	
	| aCart |
		
	aCart := self createCart.
	aCart add: 'aValidItem' withOcurrences: 3.
	aCart add: 'anotherValidItem' withOcurrences: 1.	
	
	self should:[
			Cashier withPriceList: self priceList for: aCart withCreditCard: 	self expiredCreditCard atDate: FixedGregorianDate today.
		] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Cashier CanNotCheckoutIfCreditCardIsExpiredErrorDescription . 			
		]! !

!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 12:22:54'!
test05CashierCannotCheckoutIfCreditCardIsStolen
	
	| aCart aCashier purchaseRegister merchantProcessor |
		
	purchaseRegister := OrderedCollection new.
	merchantProcessor := TestPaymentProcessor expectedBehaviour: [^TestPaymentProcessor CannotDebitFromStolenCreditCard].
	
	aCart := self createCart.
	aCart add: 'aValidItem' withOcurrences: 3.
	aCart add: 'anotherValidItem' withOcurrences: 1.	
	
	aCashier := Cashier withPriceList: self priceList for: aCart withCreditCard: 	self expiredCreditCard atDate: FixedGregorianDate today processedBy: merchantProcessor toBeRegisteredIn: purchaseRegister .
	
	self should:[
			aCashier checkout 
		] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: TestPaymentProcessor CannotDebitFromStolenCreditCard. 
			self assert: purchaseRegister isEmpty.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'jgv 11/5/2023 12:49:28'!
test06CashierCannotCheckoutIfCreditCardHasNotEnoughtCredit
	
	| aCart aCashier purchaseRegister merchantProcessor |
		
	purchaseRegister := OrderedCollection new.
	merchantProcessor := TestPaymentProcessor expectedBehaviour: [^TestPaymentProcessor CannotDebitIfCreditIsNotEnought].
	
	aCart := self createCart.
	aCart add: 'aValidItem' withOcurrences: 3.
	aCart add: 'anotherValidItem' withOcurrences: 1.	
	
	aCashier := Cashier withPriceList: self priceList for: aCart withCreditCard: 	self expiredCreditCard atDate: FixedGregorianDate today processedBy: merchantProcessor toBeRegisteredIn: purchaseRegister .
	
	self should:[
			aCashier checkout 
		] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: TestPaymentProcessor CannotDebitIfCreditIsNotEnought. 
			self assert: purchaseRegister isEmpty.
		]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'Joaco 11/2/2023 19:07:16'!
items
	^items.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'itemsPriceList renameMe1 priceList cart creditCard date purchaseRegister paymentProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'jgv 11/5/2023 12:11:40'!
checkout
	| totalAmountOfPayment |
	
	totalAmountOfPayment := 0.
	cart items do: [:aCartItem | totalAmountOfPayment := (self itemPrice: aCartItem) + totalAmountOfPayment ].
	
	paymentProcessor debit: totalAmountOfPayment from: creditCard.
	
	purchaseRegister add: self.
		
	^totalAmountOfPayment.! !


!Cashier methodsFor: 'queries' stamp: 'Joaco 11/2/2023 21:44:02'!
itemPrice: aCartItem 
	^priceList at: aCartItem.! !


!Cashier methodsFor: 'initialization' stamp: 'Joaco 11/2/2023 21:30:34'!
initializeWithPriceList: aPriceList for: aCart withCreditCard: aCreditCard 
	priceList := aPriceList.
	cart := aCart.
	creditCard := aCreditCard.! !

!Cashier methodsFor: 'initialization' stamp: 'jgv 11/5/2023 12:10:06'!
initializeWithPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate processedBy: aPaymentProcessor toBeRegisteredIn: aPurchaseRegister 
	priceList := aPriceList.
	cart := aCart.
	creditCard := aCreditCard.
	date := aDate.
	paymentProcessor := aPaymentProcessor.
	purchaseRegister := aPurchaseRegister.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'Joaco 11/2/2023 18:42:15'!
CanNotCheckoutAnEmptyCartErrorDescription
	^'No se puede realizar el checkout sobre un carrito vacio!!'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'Joaco 11/2/2023 19:41:01'!
CanNotCheckoutIfCreditCardIsExpiredErrorDescription
	^'No se puede completar el checkout con una tarjeta vencida. Vuelva a intentarlo con un método de pago valido'! !


!Cashier class methodsFor: 'instance creation' stamp: 'jgv 11/5/2023 11:11:29'!
withPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate
	self assertCartIsNotEmpty: aCart.
	self assertCreditCardIsNotExpired: aCreditCard forDate: aDate.
	^self new initializeWithPriceList: aPriceList for: aCart withCreditCard: aCreditCard ! !

!Cashier class methodsFor: 'instance creation' stamp: 'jgv 11/5/2023 12:09:52'!
withPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate processedBy: aPaymentProcessor toBeRegisteredIn: aPurchaseRegister 
	^self new initializeWithPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate processedBy: aPaymentProcessor toBeRegisteredIn: aPurchaseRegister ! !

!Cashier class methodsFor: 'instance creation' stamp: 'jgv 11/5/2023 12:01:03'!
withPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate toBeRegisteredIn: purchaseRegister 

	^self new initializeWithPriceList: aPriceList for: aCart withCreditCard: aCreditCard atDate: aDate toBeRegisteredIn: purchaseRegister ! !


!Cashier class methodsFor: 'assertions' stamp: 'Joaco 11/2/2023 21:38:07'!
assertCartIsNotEmpty: aCart 
	aCart isEmpty ifTrue: [ self error: Cashier CanNotCheckoutAnEmptyCartErrorDescription].! !

!Cashier class methodsFor: 'assertions' stamp: 'jgv 11/5/2023 11:13:45'!
assertCreditCardIsNotExpired: aCreditCard forDate: aDate
	(aCreditCard isExpired: aDate monthOfYear ) ifTrue: [self error: Cashier CanNotCheckoutIfCreditCardIsExpiredErrorDescription]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber creditCardExpirationDate creditCardSecurityCode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'Joaco 11/2/2023 19:28:11'!
initializeWithNumber: aCreditCardNumber expirationDate: aCreditCardExpirationDate securityCode: aCreditCardSecurityCode 
	creditCardNumber := aCreditCardNumber.
	creditCardExpirationDate := aCreditCardExpirationDate.
	creditCardSecurityCode := aCreditCardSecurityCode.! !


!CreditCard methodsFor: 'queries' stamp: 'jgv 11/5/2023 11:22:33'!
isExpired: aMonthOfYear
	^aMonthOfYear > creditCardExpirationDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Joaco 11/2/2023 21:48:40'!
number: aCreditCardNumber expirationDate: aCreditCardExpirationDate securityCode: aCreditCardSecurityCode
	self assertCreditCardNumberIsValid: aCreditCardNumber .
	self assertSecurityCodeIsValid: aCreditCardSecurityCode .
	^self new initializeWithNumber: aCreditCardNumber expirationDate: aCreditCardExpirationDate securityCode: aCreditCardSecurityCode ! !


!CreditCard class methodsFor: 'assertions' stamp: 'Joaco 11/2/2023 21:48:23'!
assertCreditCardNumberIsValid
	self shouldBeImplemented.! !

!CreditCard class methodsFor: 'assertions' stamp: 'Joaco 11/2/2023 21:50:34'!
assertCreditCardNumberIsValid: aCreditCardNumber 
	(aCreditCardNumber size = 16) ifFalse: [self error: CreditCard CantCreateACreditCardWithInvalidCardNumberErrorDescription] ! !

!CreditCard class methodsFor: 'assertions' stamp: 'Joaco 11/2/2023 21:53:22'!
assertSecurityCodeIsValid: aCreditCardSecurityCode 
	aCreditCardSecurityCode size = 3 ifFalse: [self error: CreditCard CanCreateCreditCardWithInvalidSecurityCodeErrorDescription ]! !


!CreditCard class methodsFor: 'error messages' stamp: 'Joaco 11/2/2023 21:51:49'!
CantCreateACreditCardWithInvalidCardNumberErrorDescription
	^'Cant create a credit card with an invalid credit card number. Please check the number lenght is 16 digits'! !


!classDefinition: #PaymentProcessor category: 'TusLibros'!
Object subclass: #PaymentProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #TestPaymentProcessor category: 'TusLibros'!
Object subclass: #TestPaymentProcessor
	instanceVariableNames: 'block testBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestPaymentProcessor methodsFor: 'initialization' stamp: 'jgv 11/5/2023 12:17:24'!
initializeExpectedBehaviour: aBlock 
	testBehaviour := aBlock.! !


!TestPaymentProcessor methodsFor: 'debit' stamp: 'jgv 11/5/2023 12:18:24'!
debit: totalAmountOfPayment from: aCreditCard 
	testBehaviour value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestPaymentProcessor class' category: 'TusLibros'!
TestPaymentProcessor class
	instanceVariableNames: ''!

!TestPaymentProcessor class methodsFor: 'instance creation' stamp: 'jgv 11/5/2023 12:17:05'!
expectedBehaviour: aBlock 

	^self new initializeExpectedBehaviour: aBlock ! !

!TestPaymentProcessor class methodsFor: 'instance creation' stamp: 'jgv 11/5/2023 12:14:15'!
forStolenCreditCardTest
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	self shouldBeImplemented.
	^self new initializeForStolenCreditCardTest! !


!TestPaymentProcessor class methodsFor: 'error description' stamp: 'jgv 11/5/2023 12:43:31'!
CannotDebitFromStolenCreditCard
	^'Can not process payment with stolen credit card!! We calling the police >:('! !

!TestPaymentProcessor class methodsFor: 'error description' stamp: 'jgv 11/5/2023 12:52:04'!
CannotDebitIfCreditIsNotEnought
	^'Credit in credit card is not enought to complete purchase!!'! !
