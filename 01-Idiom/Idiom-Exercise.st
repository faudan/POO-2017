!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:48:33'!
assert: aClosure doesNotTakeMoreThan: aNumberOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: millisecondsAfterRunning-millisecondsBeforeRunning<aNumberOfMilliseconds.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:48:42'!
check: aClosure on: anError withAssertions: anOrderedCollectionOfAssertions
		
	aClosure on: anError do: [ :theError |
		anOrderedCollectionOfAssertions collect: [:anAssertion | anAssertion value: theError ] 
	].
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:48:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assert: [ customerBook addCustomerNamed: 'John Lennon' ] doesNotTakeMoreThan: 50.! !

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:49:02'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.

	self assert: [ customerBook removeCustomerNamed: paulMcCartney ] doesNotTakeMoreThan: 100.! !

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:49:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook anOrderedCollectionOfAssertions |
			
	customerBook := CustomerBook new.
	
	anOrderedCollectionOfAssertions := OrderedCollection new.
	anOrderedCollectionOfAssertions add: [ :anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage ].
	anOrderedCollectionOfAssertions add: [ :anError | self assert: customerBook isEmpty ].
	self check: [ 
		customerBook addCustomerNamed: ''.
		self fail
	] on: Error withAssertions: anOrderedCollectionOfAssertions.! !

!IdiomTest methodsFor: 'testing' stamp: 'PR 4/22/2017 11:49:20'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon anOrderedCollectionOfAssertions |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	anOrderedCollectionOfAssertions := OrderedCollection new.
	anOrderedCollectionOfAssertions add: [ :anError | self assert: customerBook numberOfCustomers = 1].
	anOrderedCollectionOfAssertions add: [ :anError | self assert: (customerBook includesCustomerNamed: johnLennon) ].
	self check: [ 
		customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail 
	] on: NotFound withAssertions: anOrderedCollectionOfAssertions.! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
