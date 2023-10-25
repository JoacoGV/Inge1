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

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:00:29'!
test01
	| anAccount |
	anAccount := ReceptiveAccount new.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: ((SummaryGenerator forAccount: anAccount) generateReport ).! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:00:36'!
test02
	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
		
	self assert: (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100') equals: ((SummaryGenerator forAccount: anAccount) generateReport ).! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:00:41'!
test03
	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	Withdraw register: 100 on: anAccount.
		
	self assert: (OrderedCollection with: 'Extracción por 100' with: 'Balance = -100') equals: ((SummaryGenerator forAccount: anAccount) generateReport ).! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:00:46'!
test04
	| anAccount anotherAcount |
	
	anAccount := ReceptiveAccount new.
	anotherAcount := ReceptiveAccount new.
	
	Transference transfer: 100 from: anAccount  to: anotherAcount.
			
	self assert: (OrderedCollection with: 'Salida por transferencia de 100' with: 'Balance = -100') equals: ((SummaryGenerator forAccount: anAccount) generateReport ).! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:00:50'!
test05
	| anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transference transfer: 100 from: anAccount  to: anotherAccount.
			
	self assert: (OrderedCollection with: 'Entrada por transferencia de 100' with: 'Balance = 100') equals: ((SummaryGenerator forAccount: anotherAccount ) generateReport ).! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:01:02'!
test06
	| anAccount anAccountSumary anotherAccount anotherAccountSumary |
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: anAccount.
	Withdraw register: 50 on: anAccount.
	
	Transference transfer: 25 from: anAccount  to: anotherAccount. 
	
	
	anAccountSumary	 := OrderedCollection with: 'Depósito por 100' with: 'Extracción por 50' with: 'Salida por transferencia de 25' with: 'Balance = 25'.
	anotherAccountSumary := 	OrderedCollection with: 'Entrada por transferencia de 25' with: 'Balance = 25'.

	self assert: anAccountSumary equals: (SummaryGenerator forAccount: anAccount) generateReport .
	self assert: anotherAccountSumary equals: (SummaryGenerator forAccount: anotherAccount ) generateReport .! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:15:05'!
test07
	| anAccount |
	

	
	anAccount := ReceptiveAccount new.
	

	self assert: 0 equals: (TransferNetGenerator forAccount: anAccount) generateReport .
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:16:00'!
test08
	| anAccount |
	

	
	anAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: 	anAccount.
		
	self assert: 0 equals:  (TransferNetGenerator forAccount: anAccount) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:16:05'!
test09
	| anAccount |
	

	
	anAccount := ReceptiveAccount new.
	
	Withdraw register: 100 on: 	anAccount.
		
	self assert: 0 equals: (TransferNetGenerator forAccount: anAccount) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:16:10'!
test10
	| anAccount anotherAccount|
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
	self assert: -100 equals: (TransferNetGenerator forAccount: anAccount) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:16:15'!
test11
	| anAccount anotherAccount|
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
	self assert: -100 equals:  (TransferNetGenerator forAccount: anAccount) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 20:16:23'!
test12
	| anAccount anotherAccount|
	

	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	
	Deposit  register: 100 on: anAccount.	
	Withdraw register: 100 on: 	anAccount.
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
	self assert: 100 equals:  (TransferNetGenerator forAccount: anotherAccount ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:01:15'!
test13
	| aPortfolio |
	
	aPortfolio :=	 Portfolio new.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals:  (SummaryGenerator forAccount:aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:01:21'!
test14
	| aPortfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	
	aPortfolio :=	 Portfolio with: anAccount.
	
	Deposit  register: 100 on: anAccount.	
	
	
	self assert:  (OrderedCollection with: 'Depósito por 100' with: 'Balance = 100')  equals:  (SummaryGenerator forAccount: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:07:45'!
test15
	| aPortfolio anAccount anotherAccount|
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio :=	 Portfolio with: anAccount with: anotherAccount.

	Deposit  register: 100 on: anAccount.	
	Withdraw register: 100 on: 	anAccount.

	self assert:  (OrderedCollection with: 'Depósito por 100' with:'Extracción por 100'with: 'Balance = 0')  equals:  (SummaryGenerator forAccount: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:09:32'!
test16
	| aPortfolio |
	
	aPortfolio :=	 Portfolio new.
	
	self assert: 0 equals:  (TransferNetGenerator forAccount:aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:13:50'!
test17
	| aPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio :=	 Portfolio with: anAccount.
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
	
	self assert:  -100 equals:  (TransferNetGenerator forAccount: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'AB 10/24/2023 21:14:18'!
test18
	| aPortfolio anAccount anotherAccount |
	
	anAccount := ReceptiveAccount new.
	
	
	anAccount := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.
	aPortfolio :=	 Portfolio with: anAccount with:anotherAccount .
	Transference transfer: 100  from: anAccount  to: anotherAccount.
	
		
	self assert:  0 equals:  (TransferNetGenerator forAccount: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'Joaco 10/25/2023 17:55:20'!
test19

	| aPortfolio |
	
	aPortfolio :=	 Portfolio named: 'Portfolio de la familia'.
	
	self assert: (OrderedCollection with: 'Portfolio de la familia') equals:  (PortfolioStructureInfo forPortfolio: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'Joaco 10/25/2023 18:27:10'!
test20
	| aPortfolio vinDieselAccount paulWalkerAccount|
	
	vinDieselAccount := ReceptiveAccount named: 'Cuenta de Vin Diesel'.
	paulWalkerAccount  := ReceptiveAccount named: 'Cuenta de Paul Walker'.
	
	aPortfolio :=	 Portfolio named: 'Portfolio de la familia' with: vinDieselAccount with: paulWalkerAccount.

	self assert:  (OrderedCollection with: 'Portfolio de la familia' with: String tab, 'Cuenta de Vin Diesel' with: String tab, 'Cuenta de Paul Walker')
		equals:  (PortfolioStructureInfo forPortfolio: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'Joaco 10/25/2023 18:45:38'!
test21
	| aPortfolio vinDieselAccount anotherPortfolio|
	
	
	
	vinDieselAccount := ReceptiveAccount named: 'Cuenta de Vin Diesel'.
	
	anotherPortfolio := Portfolio named: 'Portfolio de hijos'.
	
	aPortfolio :=	 Portfolio named: 'Portfolio de la familia' with: vinDieselAccount with: anotherPortfolio.

	self assert:  (OrderedCollection with: 'Portfolio de la familia' with: String tab, 'Cuenta de Vin Diesel' with: String tab, 'Portfolio de hijos')
		equals:  (PortfolioStructureInfo forPortfolio: aPortfolio ) generateReport.
! !

!ReportsTest methodsFor: 'tests' stamp: 'Joaco 10/25/2023 18:52:31'!
test22
	| aPortfolio vinDieselAccount jordanaBrewsterAccount anotherPortfolio|
	
	
	
	vinDieselAccount := ReceptiveAccount named: 'Cuenta de Vin Diesel'.
	jordanaBrewsterAccount := ReceptiveAccount named: 'Cuenta de Jordana Brewster'.
	
	anotherPortfolio := Portfolio named: 'Portfolio de hijos' with: jordanaBrewsterAccount.
	
	aPortfolio :=	 Portfolio named: 'Portfolio de la familia' with: vinDieselAccount with: anotherPortfolio.

	self assert:  (OrderedCollection with: 'Portfolio de la familia' with: String tab, 'Cuenta de Vin Diesel' with: String tab, 'Portfolio de hijos' with: String tab, String tab, 'Cuenta de Jordana Brewster')
		equals:  (PortfolioStructureInfo forPortfolio: aPortfolio ) generateReport.
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
	instanceVariableNames: 'accounts parents portfolioName'
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

!Portfolio methodsFor: 'initialization' stamp: 'Joaco 10/25/2023 18:00:59'!
initializeNamed: aPortfolioName 
	portfolioName := aPortfolioName.! !

!Portfolio methodsFor: 'initialization' stamp: 'Joaco 10/25/2023 18:14:34'!
initializeNamed: aPortfolioName with: anAccount
	portfolioName := aPortfolioName.
	accounts := OrderedCollection with: anAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'Joaco 10/25/2023 18:29:01'!
initializeNamed: aPortfolioName with: anAccount with: anotherAccount
	portfolioName := aPortfolioName.
	accounts := OrderedCollection with: anAccount with: anotherAccount.	
! !


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


!Portfolio methodsFor: 'getters' stamp: 'Joaco 10/25/2023 18:04:39'!
name
	^portfolioName.! !

!Portfolio methodsFor: 'getters' stamp: 'Joaco 10/25/2023 18:04:58'!
portfolioName
	^portfolioName.! !

!Portfolio methodsFor: 'getters' stamp: 'Joaco 10/25/2023 18:04:54'!
portfolioname
	^portfolioName.! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'AB 10/24/2023 20:58:07'!
generateTransactionsReportValuesForAReport: aReportGenerator

	accounts do: [:account | 
				account generateTransactionsReportValuesForAReport: aReportGenerator.
		].! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'Joaco 10/25/2023 18:44:33'!
generateStructureInfo
	|structureInfo|
	
	structureInfo := OrderedCollection with: portfolioName.
	
	accounts do: [: account |
			(account isKindOf: ReceptiveAccount ) ifTrue: [			structureInfo add: String tab, account receptiveAccountName].
			(account isKindOf: Portfolio) ifTrue: [ structureInfo add: String tab, account portfolioName]. 
		].
	
	^structureInfo.! !

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


!Portfolio class methodsFor: 'instance creation' stamp: 'Joaco 10/25/2023 18:00:24'!
named: aPortfolioName 

	^self new initializeNamed: aPortfolioName.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'Joaco 10/25/2023 18:12:38'!
named: aPortfolioName with: anAccount 
	^self new initializeNamed: aPortfolioName with: anAccount.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'Joaco 10/25/2023 18:28:06'!
named: aPortfolioName with: anAccount with: anotherAccount 
	^self new initializeNamed: aPortfolioName with: anAccount with: anotherAccount.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions receptiveAccountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Joaco 10/25/2023 18:12:08'!
initializeNamed: aReceptiveAccountName 
	receptiveAccountName := aReceptiveAccountName.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

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


!ReceptiveAccount methodsFor: 'getters' stamp: 'Joaco 10/25/2023 18:24:06'!
receptiveAccountName
	^receptiveAccountName. ! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'jgv 10/24/2023 18:56:30'!
generateTransactionsReportValuesForAReport: aReportGenerator

	transactions do: [:transaction | 
				transaction generateValueForReportGenerator: aReportGenerator.
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'Joaco 10/25/2023 18:11:57'!
named: aReceptiveAccountName 
	^self new initializeNamed: aReceptiveAccountName ! !


!classDefinition: #BankTransaction category: 'Portfolio-Solucion'!
Object subclass: #BankTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!BankTransaction methodsFor: 'balance' stamp: 'jgv 10/24/2023 16:48:32'!
affectBalance: aBalance

	self subclassResponsibility! !


!BankTransaction methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:49:45'!
generateValueForReportGenerator: aReportGenerator

	self subclassResponsibility! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
BankTransaction subclass: #AccountTransaction
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


!AccountTransaction methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:50:04'!
generateValueForReportGenerator: aReportGenerator

	self subclassResponsibility! !

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


!Deposit methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:50:48'!
generateValueForReportGenerator: aReportGenerator
	^aReportGenerator generateReportValueForADeposit: self.! !

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


!Withdraw methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 17:27:51'!
generateStringForSummary: anAccountSumaryGenerator.
	^anAccountSumaryGenerator generateSummaryStringForWithdraw: self.! !


!Withdraw methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:52:14'!
generateValueForReportGenerator: aReportGenerator
	^aReportGenerator generateReportValueForAWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceTransaction category: 'Portfolio-Solucion'!
BankTransaction subclass: #TransferenceTransaction
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferenceTransaction methodsFor: 'transference' stamp: 'jgv 10/22/2023 16:55:42'!
transference

	self subclassResponsibility.! !


!TransferenceTransaction methodsFor: 'summaryString' stamp: 'jgv 10/23/2023 22:00:25'!
generateStringForSummary

	self subclassResponsibility! !

!TransferenceTransaction methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 17:04:10'!
generateValueForTransferNet

	self subclassResponsibility! !


!TransferenceTransaction methodsFor: 'balance' stamp: 'jgv 10/22/2023 16:25:01'!
affectBalance: aBalance

	self subclassResponsibility.! !


!TransferenceTransaction methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:55:27'!
generateValueForReportGenerator: aReportGenerator

	self subclassResponsibility! !

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


!TransferenceDeposit methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 16:59:39'!
generateStringForSummary
		^ 'Entrada por transferencia de ', transference value asString.! !

!TransferenceDeposit methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 17:39:43'!
generateValueForTransferNet: aTranferNetGenerator
	^aTranferNetGenerator generateTransferValueForTransferenceDeposit: self.! !


!TransferenceDeposit methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:56:35'!
generateValueForReportGenerator: aReportGenerator
	^aReportGenerator generateReportValueForATransferenceDeposit: self.! !

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


!TransferenceWithdraw methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 17:00:14'!
generateStringForSummary
	^'Salida por transferencia de ', transference value asString.! !

!TransferenceWithdraw methodsFor: 'summaryString' stamp: 'jgv 10/24/2023 17:38:18'!
generateValueForTransferNet: aTranferNetGenerator
	^aTranferNetGenerator generateTransferValueForTransferenceWithdraw: self.! !


!TransferenceWithdraw methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:57:09'!
generateValueForReportGenerator: aReportGenerator
	^aReportGenerator generateReportValueForATransferenceWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceWithdraw class' category: 'Portfolio-Solucion'!
TransferenceWithdraw class
	instanceVariableNames: ''!

!TransferenceWithdraw class methodsFor: 'instance creation' stamp: 'jgv 10/22/2023 16:47:13'!
for: aTransference
	^self new initiliazeWithTransference: aTransference.! !


!classDefinition: #PortfolioStructureInfo category: 'Portfolio-Solucion'!
Object subclass: #PortfolioStructureInfo
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioStructureInfo methodsFor: 'initialization' stamp: 'Joaco 10/25/2023 18:01:44'!
initializeForPortfolio: aPortfolio 
	portfolio := aPortfolio.! !


!PortfolioStructureInfo methodsFor: 'report generation' stamp: 'Joaco 10/25/2023 18:19:31'!
generateReport
	^portfolio generateStructureInfo.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioStructureInfo class' category: 'Portfolio-Solucion'!
PortfolioStructureInfo class
	instanceVariableNames: ''!

!PortfolioStructureInfo class methodsFor: 'instance creation' stamp: 'Joaco 10/25/2023 18:01:20'!
forPortfolio: aPortfolio 
	^self new initializeForPortfolio: aPortfolio.! !


!classDefinition: #ReportGenerator category: 'Portfolio-Solucion'!
Object subclass: #ReportGenerator
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportGenerator methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:46:00'!
generateReport
	self subclassResponsibility.! !

!ReportGenerator methodsFor: 'report generation' stamp: 'jgv 10/24/2023 18:00:03'!
generateReportValueForADeposit: aDeposit

	self subclassResponsibility! !

!ReportGenerator methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:59:57'!
generateReportValueForATransferenceDeposit: aTransferenceDeposit

	self subclassResponsibility! !

!ReportGenerator methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:59:53'!
generateReportValueForATransferenceWithdraw: aTransferenceWithdraw

	self subclassResponsibility! !

!ReportGenerator methodsFor: 'report generation' stamp: 'jgv 10/24/2023 17:59:44'!
generateReportValueForAWithdraw: aWithdraw

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReportGenerator class' category: 'Portfolio-Solucion'!
ReportGenerator class
	instanceVariableNames: ''!

!ReportGenerator class methodsFor: 'instance creation' stamp: 'jgv 10/24/2023 18:46:28'!
forAccount: anAccount
	^self new initializeWithAnAccount: anAccount. ! !


!classDefinition: #SummaryGenerator category: 'Portfolio-Solucion'!
ReportGenerator subclass: #SummaryGenerator
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:59:08'!
generateReport

	account generateTransactionsReportValuesForAReport: self.
	
	summary 	add: 'Balance = ', account balance asString.
	
	^summary.
	
	! !

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:59:36'!
generateReportValueForADeposit: aDeposit
	summary add: 'Depósito por ', aDeposit value asString.! !

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:59:51'!
generateReportValueForATransferenceDeposit: aTransferenceDeposit
	summary add: 'Entrada por transferencia de ', aTransferenceDeposit transference value asString.! !

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 21:00:00'!
generateReportValueForATransferenceWithdraw: aTransferenceWithdraw
	summary add: 'Salida por transferencia de ', aTransferenceWithdraw transference value asString.! !

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 21:00:11'!
generateReportValueForAWithdraw: aWithdraw
	summary add: 'Extracción por ', aWithdraw value asString.! !

!SummaryGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 21:04:28'!
initializeWithAnAccount: anAccount
account :=anAccount .
summary :=OrderedCollection new.! !


!classDefinition: #TransferNetGenerator category: 'Portfolio-Solucion'!
ReportGenerator subclass: #TransferNetGenerator
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetGenerator methodsFor: 'initialization' stamp: 'jgv 10/24/2023 19:00:36'!
initializeWithAnAccount: anAccount
	account := anAccount.
	net := 0.! !


!TransferNetGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:15:48'!
generateReport
	
	account generateTransactionsReportValuesForAReport: self.
	
	^net.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:21:16'!
generateReportValueForADeposit: aDeposit
	net:=net + 0.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:21:20'!
generateReportValueForATransferenceDeposit: aTransferenceDeposit
	net:=net + aTransferenceDeposit transference value.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:21:24'!
generateReportValueForATransferenceWithdraw: aTransferenceWithdraw
	net:=net - aTransferenceWithdraw transference value.! !

!TransferNetGenerator methodsFor: 'report generation' stamp: 'AB 10/24/2023 20:21:27'!
generateReportValueForAWithdraw: aWithdraw
	net:=net + 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetGenerator class' category: 'Portfolio-Solucion'!
TransferNetGenerator class
	instanceVariableNames: ''!

!TransferNetGenerator class methodsFor: 'instance creation' stamp: 'jgv 10/24/2023 17:32:00'!
transactions: aTransactions
	^self new initializeTransactions: aTransactions! !


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
