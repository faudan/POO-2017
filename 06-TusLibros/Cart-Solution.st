!classDefinition: #CartCatalog category: #'Cart-Solution'!
Set subclass: #CartCatalog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!CartCatalog methodsFor: 'checking' stamp: 'df 6/15/2017 20:02:27'!
checkContains: aBook

	(self includes: aBook) 
		ifFalse: [^self error: 'cant add book thats not in the catalog'].! !

!CartCatalog methodsFor: 'checking' stamp: 'pR 6/14/2017 14:34:36'!
checkFormat: aBook

	(aBook includesSubString: 'publisher')
		ifFalse: [^self error: 'invalid format of book'].! !

!CartCatalog methodsFor: 'checking' stamp: 'pR 6/14/2017 14:40:29'!
checkPublisher: aBook

	(aBook includesSubString: 'Salamanca')
		ifFalse: [^self error: 'not from publisher'].! !


!classDefinition: #TestsCart category: #'Cart-Solution'!
TestCase subclass: #TestsCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!TestsCart methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 14:23:04'!
test01CanNotAddBookNotFromAllowedPublisher

	| cart book |
	
	cart := Cart new.
	book := 'invalid format'.
	
	self
		should: [cart add: book]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: [anError messageText = 'invalid format of book'].
			self assert: cart isEmpty.	
		]! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:08:21'!
test02CanAddBookFromAllowedPublisher

	| cart book catalog |
	book := 'publisher: Salamanca'.
	catalog := CartCatalog new.
	catalog add: book.
	cart := Cart withCatalog: catalog.

	
	cart add: book.
	self deny: cart isEmpty! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:19:18'!
test03BooksFromPublisherAreInSpecificFormat

	| cart book1 book2 catalog |
	

	book1 := 'publisher: Salamanca'.
	book2 := 'publisher: otro'.
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	
	
	cart add: book1.
	self
		should: [cart add: book2]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: [anError messageText = 'not from publisher'].
		]! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:13:41'!
test04CanAddTheSameBookTwice

	| cart book1 book2 catalog |
	
	"cart := Cart new."
	book1 := 'publisher: Salamanca title: chess'.
	book2 := 'publisher: Salamanca title: tennis'.
	catalog := CartCatalog new.
	catalog add: book1.
	catalog add: book2.
	cart := Cart withCatalog: catalog.
	cart add: book1.
	cart add: book1.
	cart add: book2 amount: 5.
	
	self assert: (cart contents occurrencesOf: book1) = 2.
	self assert: (cart differentContents size = 2).
	self assert: (cart contents occurrencesOf: book2) = 5.! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:15:23'!
test05CannotModifyConentsFromOutside

	| cart book1  catalog |
	

	book1 := 'publisher: Salamanca title: chess'.
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	cart add: book1.
	cart contents remove: book1 ifAbsent: [].
	
	self deny: cart isEmpty! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:16:05'!
test06CanRemoveElements

	| cart book1  catalog |
	

	book1 := 'publisher: Salamanca title: chess'.
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	cart add: book1.
	cart remove: book1.
	
	self assert: cart isEmpty! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:16:43'!
test07CanCheckoutWithNotEmptyCart

	| cart book1 cashier aMasterCard catalog |
	
	
	book1 := 'publisher: Salamanca title: chess'.
	cashier := Cashier new.
	aMasterCard := CreditCard newExpires: DateAndTime tomorrow.
	
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	
	cart add: book1.
	
	cashier checkout: cart payingWith: aMasterCard.! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 15:16:51'!
test08CanNotCheckoutWithEmptyCart

	| cart cashier aMasterCard |
	
	cart := Cart new.
	cashier := Cashier new.
	aMasterCard := CreditCard new.
	
	self 
		should: [cashier checkout: cart payingWith: aMasterCard]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = 'cant checkout empty cart'].! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:17:13'!
test09CashierCanMakePaymentOfCartThroughCreditCard

	| cart cashier aMasterCard book1 catalog |
	

	cashier := Cashier new.
	aMasterCard := CreditCard newExpires: DateAndTime tomorrow.
	book1 := 'publisher: Salamanca title: chess'.
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	
	cart add: book1.
	
	self assert: ((cashier checkout: cart payingWith: aMasterCard) = 0)! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:17:37'!
test10CanNotDebitFromExpiredCreditCard

	| cart cashier aMasterCard book1 catalog |
	

	cashier := Cashier new.
	aMasterCard := CreditCard newExpires: DateAndTime yesterday.
	book1 := 'publisher: Salamanca title: chess'.
	catalog := CartCatalog new.
	catalog add: book1.

	cart := Cart withCatalog: catalog.
	
	cart add: book1.
	
	self 
		should: [cashier checkout: cart payingWith: aMasterCard]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = 'credit card has expired'].! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:21:17'!
test11CanNotAddBookIfNotInCatalog

	| cart book1 |
	
	
	cart := Cart new.
	book1 := 'publisher: Salamanca title: chess'.
	
	self 
		should: [cart add: book1.]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText = 'cant add book thats not in the catalog'.
			self assert: cart isEmpty.
			].! !


!classDefinition: #Cart category: #'Cart-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cart methodsFor: 'accessing' stamp: 'pR 6/14/2017 14:48:20'!
contents
	
	^content copy! !

!Cart methodsFor: 'accessing' stamp: 'pR 6/14/2017 14:43:51'!
differentContents
	
	^self contents asSet! !

!Cart methodsFor: 'accessing' stamp: 'pR 6/14/2017 13:52:29'!
isEmpty
	
	^content isEmpty! !


!Cart methodsFor: 'initializing' stamp: 'pR 6/14/2017 14:34:04'!
initialize

	content := Bag new.
	catalog := CartCatalog new.! !


!Cart methodsFor: 'adding' stamp: 'df 6/15/2017 20:01:07'!
add: aBook

	catalog checkFormat: aBook.
	catalog checkPublisher: aBook.
	catalog checkContains: aBook.
	content add: aBook.! !


!Cart methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 15:07:01'!
add: aString amount: aSmallInteger 
	
	1 to: aSmallInteger do: [:each | content add: aString].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 14:49:23'!
remove: aString 
	
	content remove: aString ifAbsent: []! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:06:58'!
withCatalog: aCatalog

content := Bag new.
catalog := aCatalog. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Cart-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 20:06:16'!
withCatalog: aCatalog

 ^self new withCatalog: aCatalog.! !


!classDefinition: #Cashier category: #'Cart-Solution'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 15:23:34'!
calculateCartTotalPrice: aCart.
	
	^0! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 15:37:26'!
checkout: aCart payingWith: aCreditCard
	| totalPrice |
	
	aCart isEmpty ifTrue: [^self error: 'cant checkout empty cart'].
	totalPrice := self calculateCartTotalPrice: aCart.
	self debit: totalPrice from: aCreditCard.
	
	^totalPrice! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'pR 6/14/2017 15:38:11'!
debit: totalPrice from: aCreditCard.

	(aCreditCard hasExpired: DateAndTime today) 
		ifTrue: [^self error: 'credit card has expired'].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/15/2017 21:30:41'!
registrarComprasEnLibro

"crear el cajero en base al carrito, la tarjeta, la fecha etc"
"que el cajero en si sea el registro de todo el contexto de la venta"
"simular la interfaz con el merchant processor para testear el cajero, que pasa si la tarjeta esta robada etc"! !


!classDefinition: #CreditCard category: #'Cart-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!CreditCard methodsFor: 'initializing' stamp: 'pR 6/14/2017 15:39:19'!
expires: aDateAndTime
	
	expirationDate := aDateAndTime! !


!CreditCard methodsFor: 'accessing' stamp: 'pR 6/14/2017 15:35:56'!
hasExpired: aTrue 
	
	^DateAndTime today > expirationDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'Cart-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'class initialization' stamp: 'pR 6/14/2017 15:40:02'!
newExpires: aDate
	
	^self new expires: aDate! !
