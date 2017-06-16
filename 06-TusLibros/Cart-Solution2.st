!classDefinition: #Cashier category: #'Cart-Solution'!
Dictionary subclass: #Cashier
	instanceVariableNames: 'cart creditCard date libroDeVentas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:26:43'!
checkOut

| saleAmount |
saleAmount := cart totalPrice.
self debit: saleAmount.
self recordSaleInBook.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:26:26'!
debit: anAmount.

! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:32:59'!
recordSaleInBook

cart content do:[:each | libroDeVentas add: {each. cart catalog priceOf: each}].

! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:36:22'!
saleBook
^libroDeVentas copy! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:38:40'!
withCart: aCart CreditCard: aCreditCard Date: aDate


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
libroDeVentas := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'Cart-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:17:11'!
checkCart: aCart

aCart isEmpty ifTrue:[^self error:'cant have a cashier for an empty cart'].! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:18:18'!
checkExpiration: aCreditCard for: aDate
(aCreditCard isExpiredOn:aDate) ifTrue:[^self error: 'cant have a cashier if credit card is expired']! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:18:30'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate


self checkCart: aCart.
self checkExpiration: aCreditCard for: aDate.
^self new withCart: aCart aCreditCard: aCreditCard aDate: aDate.! !


!classDefinition: #CreditCard category: #'Cart-Solution'!
Dictionary subclass: #CreditCard
	instanceVariableNames: 'number owner expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:36:49'!
isExpiredOn: aDate.

^expiration<aDate ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:35:45'!
withNumber: aNumber Owner:anOwner Expiration: anExpirationDate

number:= aNumber.
owner := anOwner.
expiration := anExpirationDate .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'Cart-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:07:12'!
checkValidNumber:aNumber.
(aNumber size = 16) ifFalse:[^ self error: 'invalid card number']! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:07:01'!
checkValidOwner: anOwner.
anOwner isEmpty ifTrue:[^self error: 'invalid owner name']
! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:04:14'!
withNumber: aNumber Owner:anOwner Expiration: anExpirationDate

self checkValidNumber:aNumber.
self checkValidOwner: anOwner.
^self new withNumber: aNumber Owner:anOwner Expiration: anExpirationDate
! !


!classDefinition: #ShoppingCatalog category: #'Cart-Solution'!
Dictionary subclass: #ShoppingCatalog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:37:42'!
checkIfExists: anItem

(self includesKey: anItem) ifFalse:[^self itemNotInCatalog ].! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:19:02'!
itemNotInCatalog
^ self error:'the requested item is not in the catalog and cant be added'! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:31:02'!
priceOf: anItem

^self at:anItem! !


!classDefinition: #MarketTests category: #'Cart-Solution'!
TestCase subclass: #MarketTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/16/2017 15:06:31'!
test01CanHaveAnEmptyCart


| cart |

cart := Cart new.

self assert: cart isEmpty! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/16/2017 15:30:03'!
test02AddingItemsNotInCatalogShouldNotBePossibleAndRaiseAnExceptionInstead


| cart book |

cart := Cart new.
book := Object new.
self should:[cart add: book] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the requested item is not in the catalog and cant be added'.
			self assert: cart isEmpty.
			]! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/16/2017 15:28:03'!
test03CanAddItemsInCatalog


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:0.


cart := Cart withCatalog: catalog.

cart add: book1.

self deny: cart isEmpty.
self assert: (cart content includes: book1 ).

self should:[cart add: book2] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the requested item is not in the catalog and cant be added'.
			self deny: (cart content includes: book2).
			]! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/16/2017 15:32:20'!
test04CanAddManyOfTheSameItems


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:1.
catalog at: book2 put:10.

cart := Cart withCatalog: catalog.

cart add: book1.
cart add: book2 amount:3.

self deny: cart isEmpty.
self assert: ((cart content occurrencesOf: book1) = 1 ).
self assert: ((cart content occurrencesOf: book2) = 3).
self assert: (cart size=4)
! !


!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/16/2017 16:21:29'!
test07cantCreateACashierWithAnEmptyCart


| cart credCard cashier |
cart := Cart new.
credCard := CreditCard withNumber: '1234567890123456' Owner: 'john connor'  Expiration: Date today.

self should:[cashier:= Cashier withCart: cart aCreditCard: credCard aDate: DateAndTime today]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant have a cashier for an empty cart'.
			self assert: (cashier class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/16/2017 16:23:07'!
test08cantCreateACashierWithAnExpiredCard


| cart credCard cashier book1 catalog |

catalog := ShoppingCatalog new.


book1 := Object new.


catalog at:book1 put:10.


cart := Cart withCatalog: catalog.

cart add: book1.

credCard := CreditCard withNumber: '1234567890123456' Owner: 'john connor'  Expiration: Date yesterday.

self should:[cashier:= Cashier withCart: cart aCreditCard: credCard aDate: Date today]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant have a cashier if credit card is expired'.
			self assert: (cashier class =UndefinedObject).
			].
! !


!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/16/2017 16:14:40'!
test05cantCreateCreditCardsWithInvalidNumber

| credCard |



self should:[credCard := CreditCard withNumber: '123456789012345' Owner: 'john connor'  Expiration: Date today.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'invalid card number'.
			self assert: (credCard class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/16/2017 16:14:23'!
test06cantCreateCreditCardsWithNoOwner

| credCard |

self should:[credCard := CreditCard withNumber: '1234567890123456' Owner: ''  Expiration: Date today.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'invalid owner name'.
			self assert: (credCard class =UndefinedObject).
			].! !


!classDefinition: #Cart category: #'Cart-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:02:24'!
add: anItem

self add: anItem amount: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:37:34'!
add: anItem amount: anAmount

catalog checkIfExists:anItem.
content add: anItem withOccurrences: anAmount
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:32:01'!
catalog
^catalog copy
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:04:52'!
content
^content copy
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:00:20'!
initialize


content := Bag new.
catalog := ShoppingCatalog new! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:06:24'!
isEmpty

^content isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:31:50'!
size
^content size
! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:46:48'!
totalPrice

| total |
total := 0.
content do: [:each | total := total + catalog priceOf: each].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:01:05'!
withCatalog: aCatalog

content := Bag new.
catalog := aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'Cart-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:22:21'!
withCatalog: aCatalog

^self new withCatalog: aCatalog .! !
