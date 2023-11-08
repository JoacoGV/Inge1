!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InputInterfaceTest category: 'TusLibros'!
TestCase subclass: #InputInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/6/2023 20:38:35'!
test01CanNotCreateCartWithInvalidUserCredentials

	| inputInterface | 
	
	inputInterface := InputInterface  new.
	
	self should: [
		inputInterface createCartForClient: testObjectsFactory clientId withPassword: testObjectsFactory clientPassword 	usingAuthenticator: testObjectsFactory invalidCredentialAuthenticator] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo:  [ :error | 
			self assert: error messageText equals: TestAuthenticator InvalidCredentialsErrorDescription.
			self 
		].
	
	
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/6/2023 21:38:05'!
test02CanCreateCartForValidUser

	| inputInterface cartId | 
	
	inputInterface := InputInterface  new.
	
	
	cartId := inputInterface createCartForClient: testObjectsFactory clientId withPassword: testObjectsFactory clientPassword 	usingAuthenticator: testObjectsFactory validCredentialAuthenticator.
	
	self shouldnt: [
			inputInterface listCart: cartId.
		] 
	raise: Error - MessageNotUnderstood
	
	
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/6/2023 21:09:55'!
test03CanNotAddItemWithInvalidCartId

	| inputInterface| 
	
	inputInterface := InputInterface  new.
		
	self should: [
			inputInterface addBook: testObjectsFactory itemSellByTheStore withQuantity: 3 toCart: 1
		] 
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :anError| 
			self assert: anError messageText equals: InputInterface CanNotAddItemWithInvalidCartIdForUserIdErrorDescription			
		]
	
	
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/8/2023 18:04:51'!
test04CanAddItemToValidCartId

	| inputInterface cartId | 
	
	inputInterface := InputInterface  new.	
	
	cartId := inputInterface createCartForClient: testObjectsFactory clientId withPassword: testObjectsFactory clientPassword usingAuthenticator: testObjectsFactory validCredentialAuthenticator.
	
	inputInterface addBook: testObjectsFactory itemSellByTheStore withQuantity: 3 toCart: cartId.
	
	self assert: ' ISBN: validBook | Quantity: 3 |' equals: (inputInterface listCart: cartId).
	
	
	
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/8/2023 18:05:48'!
test05CanListCartItemsWithValidCartId

	| inputInterface cartId | 
	
	inputInterface := InputInterface  new.	
	
	cartId := inputInterface createCartForClient: testObjectsFactory clientId withPassword: testObjectsFactory clientPassword usingAuthenticator: testObjectsFactory validCredentialAuthenticator.
	
	inputInterface addBook: testObjectsFactory itemSellByTheStore withQuantity: 3 toCart: cartId.
	inputInterface addBook: testObjectsFactory anotherItemSellByTheStore withQuantity: 2 toCart: cartId.
	
	self assert: ' ISBN: anotherValidBook | Quantity: 2 | ISBN: validBook | Quantity: 3 |' equals: (inputInterface listCart: cartId).
	
	
	
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/8/2023 18:24:22'!
test06CanNotLisItemsWithInvalidCartId

	| inputInterface cartId | 
	
	inputInterface := InputInterface  new.	
	
	cartId := inputInterface createCartForClient: testObjectsFactory clientId withPassword: testObjectsFactory clientPassword usingAuthenticator: testObjectsFactory validCredentialAuthenticator.
	
	inputInterface addBook: testObjectsFactory itemSellByTheStore withQuantity: 3 toCart: cartId.
	inputInterface addBook: testObjectsFactory anotherItemSellByTheStore withQuantity: 2 toCart: cartId.
	
	inputInterface checkout: cartId creditCardNumber: '12345678910111213' expirationDate: '04/2024' 	owner: 'Who And See Toe'.
	
	self
	! !

!InputInterfaceTest methodsFor: 'tests' stamp: 'JGV 11/8/2023 18:17:14'!
test07CanCheckOutWithValidCartId

	| inputInterface | 
	
	inputInterface := InputInterface  new.	
	
	self should: [inputInterface listCart: 1] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: InputInterface CanNotListItemsWithInvalidCartIdForUserIdErrorDescription 		
		].
	
	
	
	! !


!InputInterfaceTest methodsFor: 'setup' stamp: 'JGV 11/6/2023 20:17:02'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'JGV 11/8/2023 17:28:21'!
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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InputInterface category: 'TusLibros'!
Object subclass: #InputInterface
	instanceVariableNames: 'carts nextId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InputInterface methodsFor: 'initialization' stamp: 'JGV 11/6/2023 21:37:17'!
initialize
	carts := Dictionary new.
	nextId := 1.! !


!InputInterface methodsFor: 'cart' stamp: 'JGV 11/8/2023 17:56:08'!
addBook: anISBN withQuantity: aQuantity toCart: aCartId
	| cart |
	cart := carts at: aCartId ifAbsent: [ self error: InputInterface CanNotAddItemWithInvalidCartIdForUserIdErrorDescription ].
	cart add: aQuantity of: anISBN.
	
	
	
	! !

!InputInterface methodsFor: 'cart' stamp: 'JGV 11/8/2023 17:23:56'!
catalog
	^ Dictionary new
		at: 'validBook' put: 10;
		at: 'anotherValidBook' put: 5;
		yourself ! !

!InputInterface methodsFor: 'cart' stamp: 'JGV 11/6/2023 21:35:26'!
createCartForClient: aClientId withPassword: aClientPassword usingAuthenticator: anAuthenticator 
	| cartId |
	
	anAuthenticator userId: aClientId password: aClientPassword.
	
	cartId := self nextId. 
	carts at: cartId put: (Cart acceptingItemsOf: self catalog).
	
	^cartId.! !

!InputInterface methodsFor: 'cart' stamp: 'JGV 11/8/2023 18:16:42'!
listCart: aCartId 
	
	| cartItems list |
	
	list:= ''.
	
	cartItems := (carts at: aCartId ifAbsent: [self error: InputInterface CanNotListItemsWithInvalidCartIdForUserIdErrorDescription]) items.
	self catalog keysDo: [:item |
			(cartItems occurrencesOf: item) > 0 ifTrue: [
					list := list, ' ISBN: ', item, ' | Quantity: ', (cartItems occurrencesOf: item) asString, ' |'
				] 
		].
	
	^list
	! !

!InputInterface methodsFor: 'cart' stamp: 'JGV 11/6/2023 21:36:53'!
nextId
	| id |
	id := nextId.
	nextId := nextId+1.
	^id.  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputInterface class' category: 'TusLibros'!
InputInterface class
	instanceVariableNames: ''!

!InputInterface class methodsFor: 'error descriptions' stamp: 'JGV 11/6/2023 21:11:43'!
CanNotAddItemWithInvalidCartIdForUserIdErrorDescription
	^'Can not add item to cart, invalid cart id!!'! !

!InputInterface class methodsFor: 'error descriptions' stamp: 'JGV 11/8/2023 18:15:18'!
CanNotListItemsWithInvalidCartIdForUserIdErrorDescription
	^'No se encuentra ningun carrito para el id especificado.'! !

!InputInterface class methodsFor: 'error descriptions' stamp: 'JGV 11/6/2023 20:17:53'!
InvalidUserCredentialsErrorDescription
	^'The provided user credentials are invalid. Please check them and try again'! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JGV 11/8/2023 17:24:06'!
anotherItemSellByTheStore
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JGV 11/8/2023 17:23:03'!
anotherItemSellByTheStorePrice
	^5! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'JGV 11/8/2023 17:22:41'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JGV 11/6/2023 20:14:43'!
clientId
	^'clientId'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JGV 11/6/2023 20:14:54'!
clientPassword
	^'clientPassword'! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JGV 11/6/2023 20:39:22'!
invalidCredentialAuthenticator
	^TestAuthenticator withBehaviour: [self error: TestAuthenticator InvalidCredentialsErrorDescription].! !

!StoreTestObjectsFactory methodsFor: 'users' stamp: 'JGV 11/6/2023 20:56:51'!
validCredentialAuthenticator
	^TestAuthenticator withBehaviour: ['Authentication successfull'].! !


!classDefinition: #TestAuthenticator category: 'TusLibros'!
Object subclass: #TestAuthenticator
	instanceVariableNames: 'testBehaviour testBehaviourBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestAuthenticator methodsFor: 'initialization' stamp: 'JGV 11/6/2023 20:34:05'!
initializeWithBehaviour: aBlock 
	testBehaviour := aBlock.! !


!TestAuthenticator methodsFor: 'auth' stamp: 'JGV 11/6/2023 20:36:02'!
userId: aClientId password: aClientPassword 
	^testBehaviour value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestAuthenticator class' category: 'TusLibros'!
TestAuthenticator class
	instanceVariableNames: ''!

!TestAuthenticator class methodsFor: 'instance creation' stamp: 'JGV 11/6/2023 20:33:24'!
withBehaviour: aTestBehaviourBlock 
	^self new initializeWithBehaviour: aTestBehaviourBlock ! !


!TestAuthenticator class methodsFor: 'error descriptions' stamp: 'JGV 11/6/2023 20:36:34'!
InvalidCredentialsErrorDescription
	^'Credentials for user authentication are invalid'! !
