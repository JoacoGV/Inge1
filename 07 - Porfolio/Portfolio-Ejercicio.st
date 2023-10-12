!classDefinition: #PorfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PorfolioTest
	instanceVariableNames: 'aPortfolio accountOne accountTwo accountThree anotherPortfolio transactionOne transactionTwo transactionThree transactionFour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:26:56'!
setUp
	
	aPortfolio := Portfolio new.
	
	accountOne := ReceptiveAccount new.
	
	accountTwo := ReceptiveAccount new.
	

	
	transactionOne := Deposit register: 100 on: accountOne.
	transactionTwo := Withdraw  register: 50 on: accountOne.
	
	transactionThree := Deposit register: 200 on: accountTwo.

	accountThree := ReceptiveAccount new.
		
	transactionFour := Deposit register: 500 on: accountThree.
	Withdraw register: 250 on: accountThree.
	
	anotherPortfolio := Portfolio new.
	
	anotherPortfolio addAccount: accountThree.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:44:05'!
test01	
	self assert: aPortfolio balance equals: 0.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:50:57'!
test02

	aPortfolio addAccount: accountOne.
	aPortfolio addAccount: accountTwo.
	
	self assert: 250 equals: aPortfolio balance.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:51:09'!
test03	.
	
	aPortfolio addAccount: accountOne.
	aPortfolio addAccount: accountTwo.
	
	aPortfolio addPortfolio: anotherPortfolio.
	
	self assert: 500 equals: aPortfolio balance.
	! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/11/2023 18:57:39'!
test04.
	
	self deny: (aPortfolio hasRegistered: transactionOne).
	! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:24:10'!
test05
	aPortfolio addAccount: accountOne.
	aPortfolio addAccount: accountTwo.
	
	self assert: (aPortfolio hasRegistered: transactionOne).
	self assert: (aPortfolio hasRegistered: transactionTwo).
	self assert: (aPortfolio hasRegistered: transactionThree).! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:26:31'!
test06
	aPortfolio addAccount: accountOne.
	aPortfolio addAccount: accountTwo.
	
	aPortfolio addPortfolio: anotherPortfolio.
	
	self assert: (aPortfolio hasRegistered: transactionOne).
	self assert: (aPortfolio hasRegistered: transactionTwo).
	self assert: (aPortfolio hasRegistered: transactionThree).
	self assert: (aPortfolio hasRegistered: transactionFour).! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:36:27'!
test07
	self assert: (OrderedCollection new) equals: aPortfolio transactions.! !

!PorfolioTest methodsFor: 'tests' stamp: 'jgv 10/12/2023 16:41:36'!
test08

	| transactionCollection |
	transactionCollection := OrderedCollection with: transactionOne with: 	transactionTwo with: transactionThree.
	
	aPortfolio addAccount: accountOne.
	aPortfolio addAccount: accountTwo.


	self assert:  transactionCollection equals: aPortfolio transactions.! !


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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'balance accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'jgv 10/11/2023 18:53:08'!
balance
	^ (accounts sum:  [:anAccount | anAccount balance ] ifEmpty: [0]) + (portfolios sum: [:aPortfolio | aPortfolio balance] ifEmpty: [0]).! !


!Portfolio methodsFor: 'initialization' stamp: 'jgv 10/11/2023 18:49:26'!
initialize
	accounts := OrderedCollection new.
	portfolios  := OrderedCollection new.! !


!Portfolio methodsFor: 'accounts' stamp: 'jgv 10/11/2023 18:36:12'!
addAccount: anAccount 
	accounts add: anAccount. ! !


!Portfolio methodsFor: 'portfolios' stamp: 'jgv 10/11/2023 18:49:09'!
addPortfolio: aPortfolio
	portfolios add: aPortfolio.! !


!Portfolio methodsFor: 'transactions' stamp: 'jgv 10/12/2023 16:29:23'!
hasRegistered: aTransaction 
	^(accounts anySatisfy: [
		:anAccount | anAccount hasRegistered: aTransaction 
		]
	) 
	or: [
		 portfolios anySatisfy: [
			:aPortfolio | aPortfolio hasRegistered: aTransaction
			 ]
		].! !

!Portfolio methodsFor: 'transactions' stamp: 'jgv 10/12/2023 16:47:00'!
transactions
	^ accounts inject: OrderedCollection new into:[:transactionCollection :anAccount | transactionCollection . anAccount transactions] .! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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
