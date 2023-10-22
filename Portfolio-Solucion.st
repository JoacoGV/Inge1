!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:15:30'!
test01
	| aReport anAccount |
	anAccount := ReceptiveAccount new.
	
	aReport := Report new.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: (aReport accountSummary: anAccount).! !

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:16:40'!
test02
	| aReport anAccount |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	
	aReport := Report new.
	
	self assert: (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100') equals: (aReport accountSummary: anAccount).! !

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:34:02'!
test03
	| aReport anAccount anAccountSumary anotherAccount anotherAccountSumary |
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	Transference transfer: 25 from: anAccount  to: anotherAccount. 
	
	aReport := Report new.
	
	anAccountSumary	 := OrderedCollection with: 'Depósito por 100' with: 'Extracción por 50' with: 'Salida por transferencia de 25' with: 'Balance = 25'.
	anotherAccountSumary := 	OrderedCollection with: 'Entrada por transferencia de 25' with: 'Balance = 25'.

	self assert: anAccountSumary equals: (aReport accountSummary: anAccount).
	self assert: anotherAccountSumary equals: (aReport accountSummary: anotherAccount).! !

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 19:12:35'!
test04
	| aReport anAccount |
	

	
	anAccount := ReceptiveAccount new.
	
	aReport := Report new.

	self assert: 0 equals: (aReport accountTransferNet: anAccount).
! !

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 19:14:36'!
test05
	| aReport anAccount anotherAccount|
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
	aReport := Report new.

	self assert: -100 equals: (aReport accountTransferNet: anAccount).
	self assert: 100 equals: (aReport  accountTransferNet: anotherAccount).
! !

!ReportsTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 19:20:46'!
test06
	| aReport anAccount anotherAccount|
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	Transference transfer: 150 from: anotherAccount  to: anAccount.
	Transference transfer: 50 from: anAccount to: anotherAccount.
	
	aReport := Report new.

	self assert: 0 equals: (aReport accountTransferNet: anAccount).
	self assert: 0 equals: (aReport  accountTransferNet: anotherAccount).
! !


!classDefinition: #TransferenceTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:04:53'!
test01TransferenceAffectBalanceCorrectlyInDepositantAndDepositedAccount
	|anAccount anotherAccount|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
		
	Transference transfer: 100 from: anAccount to: anotherAccount.
	
	self assert: anAccount balance equals: 0.
	self assert: anotherAccount balance equals: 100.! !

!TransferenceTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:05:36'!
test02TrasnferenceRegistersADepositInDepositedAccountAndAWithdrawInDepositantAccount
	|anAccount anotherAccount transference deposit transferenceDeposit transferenceWithdraw|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: anAccount.
		
	transference := Transference transfer: 100 from: anAccount to: anotherAccount.
		
	transferenceDeposit := transference deposit. 
	transferenceWithdraw := transference withdraw.
	
	self assert: (anAccount hasRegistered: transference withdraw).
	self assert: (anotherAccount hasRegistered: transference deposit).
	self assert: anAccount transactions equals: (OrderedCollection with: deposit with: transferenceWithdraw).
	self assert: anotherAccount transactions equals: (OrderedCollection with: transferenceDeposit ).! !

!TransferenceTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:06:16'!
test03CanMakeOverdraftTransference
	|anAccount anotherAccount|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	
	Transference transfer: 100 from: anAccount to: anotherAccount.
	
	self assert: anAccount balance equals: -100.
	self assert: anotherAccount balance equals: 100.! !

!TransferenceTest methodsFor: 'tests' stamp: 'jgv 10/22/2023 17:06:29'!
test04CanNavigateTransferenceLegsCorrectly
	|anAccount anotherAccount transference transferenceDeposit transferenceWithdraw|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.		
	
	transference := Transference transfer: 100 from: anAccount to: anotherAccount.
	
	transferenceDeposit := transference deposit.
	transferenceWithdraw := transference  withdraw.
	
	
	self assert: transferenceDeposit transference equals: transference.
	self assert: transferenceWithdraw transference equals: transference.
	self assert: transferenceDeposit transferenceWithdraw equals: transferenceWithdraw.
	self assert: transferenceWithdraw transferenceDeposit equals: transferenceDeposit.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'jgv 10/22/2023 19:44:51'!
calculateTransferNet

	| transferenceTransactions |
	
	transferenceTransactions :=  transactions select: [:transaction | (transaction isKindOf: TransferenceDeposit) or: [transaction isKindOf: TransferenceWithdraw ]].
	
	^transferenceTransactions sum: [:transaction | 
		self xxxx: transaction.
		] ifEmpty: [0].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'jgv 10/22/2023 17:58:11'!
generateSummary
	|transactionsSummary|
	
	transactionsSummary := OrderedCollection new.
		
	transactions do: [:transaction | 
		(transaction isKindOf: Deposit) ifTrue: [
				transactionsSummary add: 'Depósito por ', transaction value asString.
			].
		(transaction isKindOf: Withdraw ) ifTrue: [
				transactionsSummary add: 'Extracción por ', transaction value asString .
			].
		(transaction isKindOf: TransferenceDeposit ) ifTrue: [
				transactionsSummary add: 'Entrada por transferencia de ', transaction transference value asString.
			].
		(transaction isKindOf: TransferenceWithdraw ) ifTrue: [
				transactionsSummary add: 'Salida por transferencia de ', transaction transference value asString.
			].
		].
	transactionsSummary add: 'Balance = ', self balance asString.
	^transactionsSummary.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'jgv 10/22/2023 19:44:29'!
xxxx: aTransaction
		(aTransaction isKindOf: TransferenceDeposit ) ifTrue: [
				^aTransaction transference value.
			].
		^aTransaction transference value negated. 

! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'reports' stamp: 'jgv 10/22/2023 17:23:29'!
accountSummary: anAccount 
	^anAccount generateSummary.! !

!Report methodsFor: 'reports' stamp: 'jgv 10/22/2023 19:16:04'!
accountTransferNet: anAccount 
	^anAccount calculateTransferNet.! !


!classDefinition: #Transference category: 'Portfolio-Solucion'!
Object subclass: #Transference
	instanceVariableNames: 'transferenceWithdraw transferenceDeposit value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transference methodsFor: 'observers' stamp: 'jgv 10/22/2023 16:54:35'!
deposit
	^transferenceDeposit.! !

!Transference methodsFor: 'observers' stamp: 'jgv 10/22/2023 16:52:56'!
value
	^value.! !

!Transference methodsFor: 'observers' stamp: 'jgv 10/22/2023 16:54:21'!
withdraw
	^transferenceWithdraw.! !


!Transference methodsFor: 'initialization' stamp: 'jgv 10/22/2023 16:47:52'!
initializeWithValue: aValue from: anAccount to: anotherAccount
	value := aValue.
	transferenceWithdraw :=  TransferenceWithdraw register: aValue on: anAccount  in: self. 
	transferenceDeposit := TransferenceDeposit register: aValue on: anotherAccount in: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'Portfolio-Solucion'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'jgv 10/22/2023 16:45:20'!
transfer: aValue from: anAccount to: anotherAccount 
		
	^self new initializeWithValue: aValue from: anAccount to: anotherAccount.! !


!classDefinition: #TransferenceTransaction category: 'Portfolio-Solucion'!
Object subclass: #TransferenceTransaction
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTransaction methodsFor: 'as yet unclassified' stamp: 'jgv 10/22/2023 16:25:01'!
affectBalance: aBalance

	self subclassResponsibility.! !

!TransferenceTransaction methodsFor: 'as yet unclassified' stamp: 'jgv 10/22/2023 16:55:42'!
transference

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceTransaction class' category: 'Portfolio-Solucion'!
TransferenceTransaction class
	instanceVariableNames: ''!

!TransferenceTransaction class methodsFor: 'instance creation' stamp: 'jgv 10/22/2023 16:36:21'!
register: aValue on: anAccount in: aTransference
	|transferenceTransaction|
	
	transferenceTransaction := self for: aTransference.
	anAccount register: transferenceTransaction.
	^transferenceTransaction.! !


!classDefinition: #TransferenceDeposit category: 'Portfolio-Solucion'!
TransferenceTransaction subclass: #TransferenceDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceDeposit methodsFor: 'initialization' stamp: 'jgv 10/22/2023 16:50:12'!
initiliazeWithTransference: aTransference 
	transference := aTransference.
	! !


!TransferenceDeposit methodsFor: 'balance' stamp: 'jgv 10/22/2023 16:53:21'!
affectBalance: currentBalance 
	^currentBalance + transference value.! !


!TransferenceDeposit methodsFor: 'transference' stamp: 'jgv 10/22/2023 16:56:12'!
transference
	^transference.! !

!TransferenceDeposit methodsFor: 'transference' stamp: 'jgv 10/22/2023 16:57:36'!
transferenceWithdraw
	^transference withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceDeposit class' category: 'Portfolio-Solucion'!
TransferenceDeposit class
	instanceVariableNames: ''!

!TransferenceDeposit class methodsFor: 'instance creation' stamp: 'jgv 10/22/2023 16:37:06'!
for: aTransference
	^self new initiliazeWithTransference: aTransference.
! !


!classDefinition: #TransferenceWithdraw category: 'Portfolio-Solucion'!
TransferenceTransaction subclass: #TransferenceWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceWithdraw methodsFor: 'initialization' stamp: 'jgv 10/22/2023 16:50:06'!
initiliazeWithTransference: aTransference 
	transference := aTransference.! !


!TransferenceWithdraw methodsFor: 'balance' stamp: 'jgv 10/22/2023 16:51:10'!
affectBalance: currentBalance 
	^currentBalance - transference value.! !


!TransferenceWithdraw methodsFor: 'transference' stamp: 'jgv 10/22/2023 16:56:29'!
transference
	^transference.! !

!TransferenceWithdraw methodsFor: 'transference' stamp: 'jgv 10/22/2023 16:57:56'!
transferenceDeposit
	^transference deposit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: 'Portfolio-Solucion'!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'instance creation' stamp: 'jgv 10/22/2023 16:47:13'!
for: aTransference
	^self new initiliazeWithTransference: aTransference.! !