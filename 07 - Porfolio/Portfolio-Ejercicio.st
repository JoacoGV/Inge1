!classDefinition: #PorfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PorfolioTest
	instanceVariableNames: 'aPortfolio accountOne accountTwo accountThree anotherPortfolio transactionOne transactionTwo transactionThree transactionFour transactionFive'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:23:23'!
setUp
	
	aPortfolio := Portfolio new.
	
	accountOne := ReceptiveAccount new.
	
	accountTwo := ReceptiveAccount new.
	

	
	transactionOne := Deposit register: 100 on: accountOne.
	transactionTwo := Withdraw  register: 50 on: accountOne.
	
	transactionThree := Deposit register: 200 on: accountTwo.

	accountThree := ReceptiveAccount new.
		
	transactionFour := Deposit register: 500 on: accountThree.
	transactionFive := Withdraw register: 250 on: accountThree.
	
	anotherPortfolio := Portfolio new.
	
	anotherPortfolio add: accountThree.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:44:05'!
test01	
	self assert: aPortfolio balance equals: 0.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:00:24'!
test02

	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.
	
	self assert: 250 equals: aPortfolio balance.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:00:46'!
test03	.
	
	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.
	
	aPortfolio add: anotherPortfolio.
	
	self assert: 500 equals: aPortfolio balance.
	! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:57:39'!
test04.
	
	self deny: (aPortfolio hasRegistered: transactionOne).
	! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:01:31'!
test05
	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.
	
	self assert: (aPortfolio hasRegistered: transactionOne).
	self assert: (aPortfolio hasRegistered: transactionTwo).
	self assert: (aPortfolio hasRegistered: transactionThree).! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:01:44'!
test06
	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.
	
	aPortfolio add: anotherPortfolio.
	
	self assert: (aPortfolio hasRegistered: transactionOne).
	self assert: (aPortfolio hasRegistered: transactionTwo).
	self assert: (aPortfolio hasRegistered: transactionThree).
	self assert: (aPortfolio hasRegistered: transactionFour).! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:36:27'!
test07
	self assert: (OrderedCollection new) equals: aPortfolio transactions.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:10:47'!
test08

	| transactionCollection |
	transactionCollection := OrderedCollection with: transactionOne with: 	transactionTwo with: transactionThree.
	
	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.

	self assert:  transactionCollection equals: aPortfolio transactions.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/17/2023 18:23:49'!
test09

	| transactionCollection |
	transactionCollection := OrderedCollection with: transactionOne with: 	transactionTwo with: transactionThree with: transactionFour with: transactionFive.
	
	aPortfolio add: accountOne.
	aPortfolio add: accountTwo.
	
	aPortfolio add: anotherPortfolio.

	self assert:  transactionCollection equals: aPortfolio transactions.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/18/2023 17:59:11'!
test10
	aPortfolio add: accountOne. 
	
	self should: [ aPortfolio add: accountOne ]
	raise: Error
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio canNotAddFinancialServiceErrorDescription .
		]! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/18/2023 17:59:17'!
test11
	
	aPortfolio add: anotherPortfolio.
	
	self should: [ aPortfolio add: accountThree]
	raise: Error
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio canNotAddFinancialServiceErrorDescription .
		]! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/18/2023 17:59:39'!
test12

	aPortfolio add: accountOne.
	
	self should: [ aPortfolio add: aPortfolio]
	raise: Error
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio canNotAddFinancialServiceErrorDescription .
		]! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/18/2023 18:07:35'!
test13
	|aThirdPortfolio|
	
	aPortfolio add: anotherPortfolio.

	aThirdPortfolio := Portfolio new.
	aThirdPortfolio add: accountTwo.
	aThirdPortfolio add: anotherPortfolio.

	
	
	self should: [ anotherPortfolio add: accountTwo ]
	raise: Error
	withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio canNotAddFinancialServiceErrorDescription .
		]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'jgv 10/9/2023 21:27:25'!
processOn: balance 
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'jgv 10/9/2023 21:27:25'!
processOn: aBalance 
	^aBalance +  value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'jgv 10/9/2023 21:17:01'!
initializeFor: aValue

	value := aValue.! !


!Withdraw methodsFor: 'value' stamp: 'jgv 10/9/2023 21:17:20'!
value

	^ value.! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'jgv 10/9/2023 21:27:25'!
processOn: aBalance 
	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialService category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialService methodsFor: 'balance' stamp: 'jgv 10/17/2023 17:45:42'!
balance

	self subclassResponsibility! !


!FinancialService methodsFor: 'transactions' stamp: 'jgv 10/17/2023 17:46:31'!
hasRegistered: aTransaction

	self subclassResponsibility! !

!FinancialService methodsFor: 'transactions' stamp: 'jgv 10/17/2023 17:46:47'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialService subclass: #Portfolio
	instanceVariableNames: 'financialServices includedInPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'jgv 10/17/2023 18:00:08'!
balance
	^ financialServices sum: [:aFinancialService | aFinancialService balance] ifEmpty: [0].! !


!Portfolio methodsFor: 'initialization' stamp: 'jgv 10/18/2023 18:08:59'!
initialize
	financialServices := OrderedCollection new.
	includedInPortfolios := OrderedCollection new.
! !


!Portfolio methodsFor: 'transactions' stamp: 'jgv 10/17/2023 18:01:22'!
hasRegistered: aTransaction 
	^financialServices anySatisfy: [
		:aFinancialService | aFinancialService hasRegistered: aTransaction 
		].! !

!Portfolio methodsFor: 'transactions' stamp: 'jgv 10/17/2023 18:22:01'!
transactions
	^ financialServices inject: OrderedCollection new into:[:transactionCollection :aFinancialService | transactionCollection , aFinancialService transactions] .! !


!Portfolio methodsFor: 'financialServices' stamp: 'jgv 10/18/2023 18:35:05'!
add: aFinancialService
	(self canNotAddFinancialService: aFinancialService) ifTrue: [ self error: Portfolio canNotAddFinancialServiceErrorDescription ].	.
	aFinancialService addTo: self.! !


!Portfolio methodsFor: 'financialServices-private' stamp: 'jgv 10/18/2023 18:12:42'!
addFinancialService: aFinancialService
	financialServices add: aFinancialService.! !

!Portfolio methodsFor: 'financialServices-private' stamp: 'jgv 10/18/2023 18:11:50'!
addTo: aPorfolio
	includedInPortfolios add: aPorfolio.
	aPorfolio addFinancialService: self.! !

!Portfolio methodsFor: 'financialServices-private' stamp: 'jgv 10/18/2023 18:35:05'!
canNotAddFinancialService: aFinancialService
	includedInPortfolios isEmpty ifFalse: [
				^includedInPortfolios anySatisfy: [:parentPorfolio |
						parentPorfolio 			canNotAddFinancialService: aFinancialService
					].				
			].
	includedInPortfolios isEmpty ifTrue: [
			^(aFinancialService includedIn: self)
		].
	! !

!Portfolio methodsFor: 'financialServices-private' stamp: 'jgv 10/18/2023 17:58:09'!
includedIn: aPortfolio
	^ financialServices anySatisfy: [:registeredFinancialService |
					aPortfolio includes: registeredFinancialService 
				]! !

!Portfolio methodsFor: 'financialServices-private' stamp: 'jgv 10/18/2023 17:32:45'!
includes: aFinancialService
	^ financialServices anySatisfy: [:registeredFinancialService | registeredFinancialService includes: aFinancialService]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errorDescriptions' stamp: 'jgv 10/18/2023 17:55:26'!
canNotAddFinancialServiceErrorDescription
	^'Cannot add financial service to this portfolio'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialService subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jgv 10/11/2023 18:31:53'!
balance
	
	|balance| 
	
	balance := 0.
	
	transactions do: [ :aTransaction | 
		balance := aTransaction processOn: balance.
		] .
	
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'jgv 10/18/2023 18:10:49'!
addTo: aPortfolio
	aPortfolio addFinancialService: self.
! !

!ReceptiveAccount methodsFor: 'private' stamp: 'jgv 10/18/2023 17:58:55'!
includedIn: aPortfolio.
	^aPortfolio includes: self.
! !

!ReceptiveAccount methodsFor: 'private' stamp: 'jgv 10/18/2023 17:33:27'!
includes: aFinancialService
	^self = aFinancialService.! !
