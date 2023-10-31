!classDefinition: #CartTest category: 'MisLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MisLibros'!

!CartTest methodsFor: 'tests' stamp: 'jgv 10/30/2023 21:14:45'!
test01CartStartsEmpty
	|cart validBooks|
	
	validBooks := OrderedCollection with: '123456789'.	
	
	cart := Cart validBooks: validBooks.
	
	self assert: cart isEmptyCart! !

!CartTest methodsFor: 'tests' stamp: 'jgv 10/30/2023 21:15:31'!
test02ACartWithBooksInItIsNotEmpty
	|cart  validBooks ISBN|
	
	validBooks := OrderedCollection with: '123456789'.
	
	cart := Cart validBooks: validBooks.
	ISBN := '123456789'.
	
	cart addBook: ISBN.
	
	self deny: cart isEmptyCart.! !

!CartTest methodsFor: 'tests' stamp: 'jgv 10/30/2023 21:16:32'!
test03ACartCanListItsContent

	|cart validBooks anISBN anotherISBN|
	

	anISBN := '123456789'.
	anotherISBN := '789456123'.
	
	validBooks := OrderedCollection with: anISBN with: anotherISBN.
	cart := Cart validBooks: validBooks.
		
	cart addBook: anISBN.
	cart addBook: anotherISBN.	

	self assert: (cart listContent) equals: (OrderedCollection with: 'ISBN: 123456789 | quantity: 1' with: 'ISBN: 789456123 | quantity: 1').	
	
	
	
	! !

!CartTest methodsFor: 'tests' stamp: 'jgv 10/30/2023 21:17:34'!
test04AddingTheSameItemMultipleTimesIncreasesItsQuantity

	|cart validBooks anISBN|
	
	anISBN := '123456789'.		
	validBooks :=OrderedCollection with: anISBN.
	
	cart := Cart validBooks: validBooks.
	cart addBook: anISBN.
	
	self assert: (cart listContent) equals: (OrderedCollection with: 'ISBN: 123456789 | quantity: 1' ).
	
	cart addBook: anISBN .

	self assert: (cart listContent) equals: (OrderedCollection with: 'ISBN: 123456789 | quantity: 2' ).	
	
	
	
	
	! !

!CartTest methodsFor: 'tests' stamp: 'jgv 10/30/2023 21:10:36'!
test05CanNotAddAnInvalidBookToCart

	|cart anInvalidISBN validISBNs|
	
	validISBNs := OrderedCollection with: '123456789' with: '789456123'.
	
	cart := Cart validBooks: validISBNs.
	
	anInvalidISBN := '456789123'.	
	
	self should: [cart addBook: anInvalidISBN ] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Cart cannotAddInvalidBookErrorDescription.
			self assert: cart isEmptyCart.
		]
	
	
	
	
	! !


!classDefinition: #Cart category: 'MisLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books validISBNs_CHANGE_ME validBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MisLibros'!

!Cart methodsFor: 'testing' stamp: 'jgv 10/30/2023 19:26:42'!
isEmptyCart
	^books isEmpty.! !


!Cart methodsFor: 'initialization' stamp: 'jgv 10/30/2023 19:51:20'!
initialize
	books := Dictionary new.! !

!Cart methodsFor: 'initialization' stamp: 'jgv 10/30/2023 20:52:28'!
initializeWithValidBooks: validISBNs 
	validBooks := validISBNs.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'jgv 10/30/2023 21:13:34'!
addBook: anISBN 
	(validBooks includes: anISBN) ifFalse: [self error: Cart cannotAddInvalidBookErrorDescription].
	 books at: anISBN put: (books at: anISBN ifAbsent: [0]) + 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'jgv 10/30/2023 20:04:21'!
listContent
	|contentList|
	
	contentList := OrderedCollection new.
	
	books keysDo: [:ISBN |
			contentList add: 'ISBN: ', ISBN, ' | quantity: ', ((books at: ISBN) asString). 			
		].
	
	^contentList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'MisLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'jgv 10/30/2023 20:49:40'!
validBooks: validISBNs 
	^self new initializeWithValidBooks: validISBNs ! !


!Cart class methodsFor: 'error descriptions' stamp: 'jgv 10/30/2023 21:10:16'!
cannotAddInvalidBookErrorDescription
	^'Cannot add a book that is not selled by this publisher'! !
