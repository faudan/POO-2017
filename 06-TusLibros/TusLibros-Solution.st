!classDefinition: #LibroDeVentas category: #'Cart-Solution'!
Bag subclass: #LibroDeVentas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!LibroDeVentas commentStamp: '<historical>' prior: 0!
Aca se guardan las ventas que hacen los cashiers, igual que el catalogo, debe haber un unico libro para todos, seria el registro de ventas del sistema!



!classDefinition: #Cashier category: #'Cart-Solution'!
Dictionary subclass: #Cashier
	instanceVariableNames: 'cart creditCard date libroDeVentas merchantProcessor tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:03:31'!
checkIfMPIsUp
^merchantProcessor isUp! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:14:42'!
checkOut

| saleAmount |
saleAmount := cart totalPrice.
self checkIfMPIsUp ifFalse:[ ^self recordSaleRequest].

merchantProcessor debit: saleAmount from: creditCard.

self recordSaleInBook.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:32:59'!
recordSaleInBook

cart content do:[:each | libroDeVentas add: {each. cart catalog priceOf: each}].

! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:06:03'!
recordSaleRequest

cart content do:[:each | tusLibros add: {each. cart catalog priceOf: each}].

^self error: 'Merchant Processor is down. Request generated'
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:36:22'!
saleBook
^libroDeVentas copy! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 22:48:36'!
tusLibros

^tusLibros copy! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:18:34'!
withCart: aCart CreditCard: aCreditCard Date: aDate


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
tusLibros := Set new.

libroDeVentas := Set new.

merchantProcessor := MPSimulator new! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:51:40'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP.


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
libroDeVentas := Set new.

tusLibros := Set new.

merchantProcessor := anMP.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:55:32'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook.


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
libroDeVentas := aSalesBook.

tusLibros := Set new.

merchantProcessor := anMP.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:57:07'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook withLibros: aTusLibros.


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
libroDeVentas := aSalesBook.

tusLibros := aTusLibros.

merchantProcessor := anMP.! !

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

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:28:53'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP


self checkCart: aCart.
self checkExpiration: aCreditCard for: aDate.
^self new withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:55:12'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook


self checkCart: aCart.
self checkExpiration: aCreditCard for: aDate.
^self new withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook.! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:57:43'!
withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook withLibros: aTusLibros


self checkCart: aCart.
self checkExpiration: aCreditCard for: aDate.
^self new withCart: aCart aCreditCard: aCreditCard aDate: aDate aMerchProcessor: anMP withSalesBook: aSalesBook withLibros: aTusLibros.! !


!classDefinition: #CreditCard category: #'Cart-Solution'!
Dictionary subclass: #CreditCard
	instanceVariableNames: 'number owner expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:41:47'!
expirationDate
^expiration ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:36:49'!
isExpiredOn: aDate.

^expiration<aDate ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:41:24'!
number
^number
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:41:34'!
owner
^owner! !

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
!ShoppingCatalog commentStamp: '<historical>' prior: 0!
Este es el catalogo/lista de precios para el carrito, todos los carritos deben usar el mismo!


!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:41:32'!
checkIfExists: anItem

(self includesKey: anItem name) ifFalse:[^self itemNotInCatalog ].! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:19:02'!
itemNotInCatalog
^ self error:'the requested item is not in the catalog and cant be added'! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:50:57'!
priceOf: anItem

^self at:anItem name! !


!classDefinition: #TusLibros category: #'Cart-Solution'!
Set subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!TusLibros commentStamp: '<historical>' prior: 0!
Aca van a ir las ventas que no se puedan realizar cuando el merchant processor este caido, igual que el libro de ventas, debe compartirse entre Cashiers!



!classDefinition: #MarketTests category: #'Cart-Solution'!
TestCase subclass: #MarketTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/27/2017 14:44:43'!
testAddingItemsNotInCatalogShouldNotBePossibleAndRaiseAnExceptionInstead


| cart book catalog |
catalog:= ShoppingCatalog new.


cart := MarketFactory emptyCartWithCatalog: catalog.
book := MarketFactory uncatalogedItem .
self should:[cart add: book] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the requested item is not in the catalog and cant be added'.
			self assert: cart isEmpty.
			]! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/27/2017 14:43:23'!
testCanAddItemsInCatalog


| cart book1 catalog book2 |
catalog := MarketFactory catalog.cart := MarketFactory emptyCartWithCatalog: catalog.book1 := MarketFactory catalogedItem.
book2 := Object new.
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

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/27/2017 14:45:53'!
testCanAddManyOfTheSameItems
| cart book1 catalog book2 |
catalog := MarketFactory catalog.book1 := MarketFactory catalogedItem .book2 := MarketFactory anotherCatalogedItem .cart := MarketFactory  emptyCartWithCatalog: catalog.
cart add: book1.cart add: book2 amount:3.
self deny: cart isEmpty.self assert: ((cart content occurrencesOf: book1) = 1 ).self assert: ((cart content occurrencesOf: book2) = 3).self assert: (cart size=4)
! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:35:55'!
testCanHaveAnEmptyCart


| cart |

cart := MarketFactory emptyCart.

self assert: cart isEmpty! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/27/2017 14:47:14'!
testShouldNotBeAbleToAddAFractionOfAnItem
| cart book1 catalog |
catalog := MarketFactory catalog.
book1 := MarketFactory catalogedItem .
cart := MarketFactory  emptyCartWithCatalog: catalog.

self should:[cart add: book1 amount: 3/2] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add a non integer amount of items'.
			self assert: cart isEmpty.
			].

! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/27/2017 14:47:41'!
testShouldNotBeAbleToAddLessThanOneItem
| book1 book2 cart catalog |
catalog := MarketFactory catalog.
book1 := MarketFactory catalogedItem .
book2 := MarketFactory anotherCatalogedItem .
cart := MarketFactory  emptyCartWithCatalog: catalog.

self should:[cart add: book1 amount: 0] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add less than one item'.
			self assert: cart isEmpty.
			].

self should:[cart add: book2 amount: -1] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add less than one item'.
			self assert: cart isEmpty.
			]
! !


!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 14:50:38'!
testCanCheckOutIfMoneyInCardIsEnough

| cart credCard cashier today merchProc |

cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.

merchProc := MarketFactory merchProcessorSimOnline: [].

merchProc addCard: credCard withAmount: cart totalPrice.

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.

cashier checkOut.

self assert: merchProc cardAmount = 0.
self deny: cashier saleBook isEmpty.



! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 14:11:43'!
testCanNotCheckOutIfCardIsStolen

| cart credCard cashier today merchProc |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.
merchProc := MarketFactory merchProcessorSimOnline: [MerchantProcessorInterface errorStolenCard].

merchProc addCard: credCard withAmount: 1000.

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.

self should:[cashier checkOut]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'card is stolen'.
			self assert: merchProc cardAmount = 1000.
			self assert: cashier saleBook isEmpty.

			].


! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 14:11:49'!
testCanNotCheckOutIfMoneyInCardIsNotEnough

| cart credCard cashier today merchProc money |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.

merchProc := MarketFactory merchProcessorSimOnline: [MerchantProcessorInterface errorInsufficientFunds].
money := cart totalPrice -1.
merchProc addCard: credCard withAmount: money.

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.

self should:[cashier checkOut]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the account doesnt have enough funds to pay'.
			self assert: merchProc cardAmount = money.
			self assert: cashier saleBook isEmpty.

			].


! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 14:11:57'!
testCanNotCreateACashierWithAnEmptyCart


| cart credCard cashier today |
cart := MarketFactory emptyCart.
credCard := MarketFactory nonExpiredCard.
today := MarketFactory  today.
self should:[cashier:= Cashier withCart: cart aCreditCard: credCard aDate: today]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant have a cashier for an empty cart'.
			self assert: (cashier class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 14:12:03'!
testCanNotCreateACashierWithAnExpiredCard


| cart credCard cashier today |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory expiredCard.
today := MarketFactory today.
self should:[cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant have a cashier if credit card is expired'.
			self assert: (cashier class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/27/2017 16:54:41'!
testWhenMerchantProcessorIsUnavaliableTheSaleRequestIsRecordedInstead

| cart credCard cashier today merchProc money |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.

merchProc := MarketFactory merchProcessorSimOffline.

money := cart totalPrice.
merchProc addCard: credCard withAmount: money.

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.



self should:[cashier checkOut]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'Merchant Processor is down. Request generated'.
			self assert: merchProc cardAmount = money.
			self assert: cashier saleBook isEmpty.
			self deny: cashier tusLibros isEmpty.

			].




! !


!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/26/2017 15:45:38'!
testCanCreateANonExpiredCreditCard

| credCard |

credCard := MarketFactory nonExpiredCard. 
self assert: credCard number = '1234567890123456'.
self assert: credCard owner = 'john connor'.
self deny: (credCard isExpiredOn: MarketFactory today)! !

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/26/2017 15:45:12'!
testCanCreateAnExpiredCreditCard

| credCard |

credCard := MarketFactory expiredCard. 
self assert: credCard number = '1234567890123456'.
self assert: credCard owner = 'john connor'.
self assert: (credCard isExpiredOn: MarketFactory today)! !

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/27/2017 14:11:20'!
testCanNotCreateCreditCardsWithInvalidNumber

| credCard |



self should:[credCard := CreditCard withNumber: '123456789012345' Owner: 'john connor'  Expiration: Date today.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'invalid card number'.
			self assert: (credCard class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/27/2017 14:11:32'!
testCanNotCreateCreditCardsWithNoOwner

| credCard |

self should:[credCard := CreditCard withNumber: '1234567890123456' Owner: ''  Expiration: Date today.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'invalid owner name'.
			self assert: (credCard class =UndefinedObject).
			].! !


!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 14:53:03'!
testCanAddCatalogedItemsToCart

| interface cartID itemFromCatalog cartContents |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.

itemFromCatalog := MarketFactory catalogedItem.

interface add: itemFromCatalog Amount: 3  ToCart: cartID.
cartContents := interface listCart: cartID.

self deny: cartContents isEmpty.
self assert: (cartContents includes: itemFromCatalog).
self assert: (cartContents occurrencesOf: itemFromCatalog)  = 3.
self assert: cartContents size = 3.

! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:47:29'!
testCanCheckOutACartWithAValidNonExpiredCreditCard

| interface cartID itemFromCatalog credCard |
credCard := MarketFactory nonExpiredCard.
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemFromCatalog := MarketFactory catalogedItem.
interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 1000.
interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate.

self assert: (interface isExpired: cartID).
self assert: (interface merchantProcessor) cardAmount < 1000.
self assert: (interface listPurchasesOf: 'john test' pass: '123456') isEmpty not.! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 17:11:03'!
testCanListPurchasesAfterCheckingOut

| interface cartID itemFromCatalog credCard purchases cartContent |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: (MarketFactory merchProcessorSimOnline:[]).
credCard := MarketFactory nonExpiredCard.
cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.

itemFromCatalog := MarketFactory catalogedItem.

interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 100.
interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate. 

purchases:= interface listPurchasesOf: 'john test' pass: '123456'.
cartContent :=  (interface cart: cartID) listContents.
self assert: (interface merchantProcessor) cardAmount = 90.
self assert: purchases isEmpty not.
self assert: interface incompleteSales isEmpty.

! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 13:57:48'!
testCanLogInWithAValidUserNameAndPassword

| interface |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

interface createCartfor: 'john test' autenticatedWith: '123456'.

self deny: interface carts isEmpty.
! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:53:00'!
testCanNotAddCatalogedItemsInNonPositiveIntegerAmountsToCart

| interface cartID itemFromCatalog |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: (MarketFactory merchProcessorSim).

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.

itemFromCatalog := MarketFactory catalogedItem.

self should:[interface add: itemFromCatalog Amount: -1 ToCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add less than one item'.
			self assert: (interface listCart: cartID) isEmpty.
			].
self should:[interface add: itemFromCatalog Amount: 0 ToCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add less than one item'.
			self assert: (interface listCart: cartID) isEmpty.
			].
self should:[interface add: itemFromCatalog Amount: 10/3 ToCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add a non integer amount of items'.
			self assert: (interface listCart: cartID) isEmpty.
			]! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 15:03:21'!
testCanNotAddUncatalogedItemsToCart

| interface cartID itemNotInCatalog |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemNotInCatalog := MarketFactory uncatalogedItem.

self should:[interface add: itemNotInCatalog Amount: 1 ToCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the requested item is not in the catalog and cant be added'.
			self assert: (interface listCart: cartID) isEmpty.
			]! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 17:00:12'!
testCanNotCheckOutACartWithAStolenCreditCard

| interface cartID itemFromCatalog credCard |
credCard := MarketFactory nonExpiredCard.
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: (MarketFactory merchProcessorSimOnline:[MerchantProcessorInterface errorStolenCard]).

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemFromCatalog := MarketFactory catalogedItem.
interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 500.

self should:[interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'card is stolen'.
			self assert: (interface merchantProcessor) cardAmount = 500.
			self assert: (interface listPurchasesOf: 'john test' pass: '123456') isEmpty.
			self assert: interface incompleteSales isEmpty.
			].


! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:46:44'!
testCanNotCheckOutACartWithAValidExpiredCreditCard

| interface cartID itemFromCatalog credCard |
credCard := MarketFactory expiredCard.
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemFromCatalog := MarketFactory catalogedItem.
interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 1000.

self should:[interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant have a cashier if credit card is expired'.
			self assert: (interface merchantProcessor) cardAmount = 1000.
			self assert: (interface listPurchasesOf: 'john test' pass: '123456') isEmpty.
			self assert: interface incompleteSales isEmpty.
			].



! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:59:34'!
testCanNotCheckOutACartWithInsufficientFundsOnCreditCard

| interface cartID itemFromCatalog credCard |
credCard := MarketFactory nonExpiredCard.
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: (MarketFactory merchProcessorSimOnline:[MerchantProcessorInterface errorInsufficientFunds]).

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemFromCatalog := MarketFactory catalogedItem.
interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 5.

self should:[interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the account doesnt have enough funds to pay'.
			self assert: (interface merchantProcessor) cardAmount = 5.
			self assert: (interface listPurchasesOf: 'john test' pass: '123456') isEmpty.
			self assert: interface incompleteSales isEmpty.
			].


! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 14:08:45'!
testCanNotLogInWithAnInvalidUserNameOrPassword

| interface |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

self should:[ interface createCartfor: 'hackerman' autenticatedWith: '123456'.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'user not registered'.
			self assert: interface carts isEmpty
			].
! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:49:28'!
testCanNotUseCartAfter30MinutesOfInactivity

| interface cartID itemFromCatalog |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: MarketFactory merchProcessorSim.

cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.
itemFromCatalog := MarketFactory catalogedItem.

interface expire: cartID.
self should:[interface add: itemFromCatalog Amount: 1 ToCart: cartID] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cart cant be used anymore because it was inactive for more than 30 minutes or already checked out'.
			self assert: (interface listCart: cartID) isEmpty.
			]! !

!MarketTests methodsFor: 'REST-InterfaceTesting' stamp: 'df 6/27/2017 16:56:45'!
testWhenMerchantProcessorIsDownTheSaleRequestIsRegisteredButDoesNotCheckOut

| interface cartID itemFromCatalog credCard |
interface := REST_Interface withUsers: MarketFactory usersDB Catalog: MarketFactory catalog MerchantProcessor: (MarketFactory merchProcessorSimOffline).
credCard := MarketFactory nonExpiredCard.
cartID := interface createCartfor: 'john test' autenticatedWith: '123456'.

itemFromCatalog := MarketFactory catalogedItem.

interface add: itemFromCatalog Amount: 10 ToCart: cartID.
interface merchantProcessor addCard: credCard withAmount: 100.

self should:[interface checkOut: cartID withCreditCardNumber:credCard number  creditCardOwner: credCard owner creditCardExpiration: credCard expirationDate.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'Merchant Processor is down. Request generated'.
			self assert: (interface merchantProcessor) cardAmount = 100.
			self assert: (interface listPurchasesOf: 'john test' pass: '123456') isEmpty.
			self deny: interface incompleteSales isEmpty.
			].
! !


!classDefinition: #Cart category: #'Cart-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'catalog content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:02:24'!
add: anItem

self add: anItem amount: 1.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:06:40'!
add: anItem amount: anAmount

catalog checkIfExists:anItem.anAmount < 1 ifTrue:[^self error: 'cant add less than one item'].
(anAmount isInteger) ifFalse:[^self error: 'cant add a non integer amount of items'].
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

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:59:02'!
totalPrice

| total |
total := 0.
content do: [:each | total := total + catalog priceOf: each].

^total! !

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


!classDefinition: #MarketFactory category: #'Cart-Solution'!
Object subclass: #MarketFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!MarketFactory commentStamp: '<historical>' prior: 0!
Creador de instancias controladas para los tests!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarketFactory class' category: #'Cart-Solution'!
MarketFactory class
	instanceVariableNames: ''!

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:46:09'!
anotherCatalogedItem

| book1 |
book1 := Mercancia withName:'book2'.
^book1! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:47:33'!
catalog

| book1 book2 book3 catalog |

catalog := ShoppingCatalog new.


book1 := Mercancia withName:'book1'.
book2 := Mercancia withName:'book2'.
book3 := Mercancia withName:'book3'.
catalog at:book1 name put:1.
catalog at: book2 name put:10.
catalog at: book3 name put: 15.

^catalog! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:43:52'!
catalogedItem

| book1 |
book1 := Mercancia withName:'book1'.
^book1! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:15:48'!
emptyCart
^Cart new! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:22:42'!
emptyCartWithCatalog: aCatalog

^Cart withCatalog: aCatalog.

! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:15:19'!
expiredCard

| date |
date := GregorianMonthOfYear yearNumber: 2004 monthNumber:1.

^ CreditCard withNumber: '1234567890123456' Owner: 'john connor'  Expiration: date.! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:26:46'!
incompleteSales

| incompleteSalesBook |
incompleteSalesBook := TusLibros new.

^incompleteSalesBook ! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:06:35'!
merchProcessorSim
^MPSimulator with: [] online:true! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:54:23'!
merchProcessorSimOffline
^MPSimulator with: [] online:false! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:13:14'!
merchProcessorSimOffline: aClosure 
^MPSimulator with: aClosure online:false! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:13:08'!
merchProcessorSimOnline: aClosure 
^MPSimulator with: aClosure online:true! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:48:47'!
nonEmptyCart

| book1 book2 cart catalog |

catalog := MarketFactory catalog.
book1 := MarketFactory catalogedItem .
book2 := MarketFactory anotherCatalogedItem .

cart := Cart withCatalog: catalog.

cart add: book1 amount:3.
cart add: book2 amount:2.

^cart! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:29:22'!
nonExpiredCard

| date |
date := GregorianMonthOfYear yearNumber: 3020 monthNumber:1.

^ CreditCard withNumber: '1234567890123456' Owner: 'john connor'  Expiration: date.! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:27:10'!
salesBook

| salesbook |
salesbook := LibroDeVentas new.

^salesbook! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:24:04'!
salesCatalog



| book1 book2 book3 catalog |

catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.
book3 := Object new.
catalog at:book1 put:1.
catalog at: book2 put:10.
catalog at: book3 put:15.

^catalog.! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:18:28'!
today
^ FixedGregorianDate today! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:00:21'!
uncatalogedItem

| book4 |
book4 := Mercancia withName:'noRegistrado'.
^book4! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:21:48'!
usersDB

| users |
users := Dictionary new.

users at: 'jack test' put: 'password'.
users at: 'john test' put: '123456'.
^users! !


!classDefinition: #Mercancia category: #'Cart-Solution'!
Object subclass: #Mercancia
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Mercancia methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:02:43'!
name
^name! !

!Mercancia methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:02:19'!
withName: aName
name := aName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mercancia class' category: #'Cart-Solution'!
Mercancia class
	instanceVariableNames: ''!

!Mercancia class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:39:13'!
withName: aName

^self new withName: aName! !


!classDefinition: #MerchantProcessorInterface category: #'Cart-Solution'!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: 'card amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!MerchantProcessorInterface methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:48:40'!
addCard: aCredCard withAmount: anAmount

card := aCredCard.
amount := anAmount ! !

!MerchantProcessorInterface methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:54:50'!
cardAmount
^amount! !

!MerchantProcessorInterface methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 22:46:40'!
debit: anAmount from: aCreditCard

^self subclassResponsibility! !

!MerchantProcessorInterface methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:04:04'!
isUp

^self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: #'Cart-Solution'!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 17:31:32'!
errorInsufficientFunds
^self error:'the account doesnt have enough funds to pay'! !

!MerchantProcessorInterface class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 22:51:41'!
errorMPUnavailable
 ^self error:'Merchant Processor is not available'! !

!MerchantProcessorInterface class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 17:30:38'!
errorStolenCard
 ^self error:'card is stolen'! !


!classDefinition: #MPSimulator category: #'Cart-Solution'!
MerchantProcessorInterface subclass: #MPSimulator
	instanceVariableNames: 'closure status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!MPSimulator commentStamp: '<historical>' prior: 0!
El simulador tiene que ser polimorfico con MerchProcessor!


!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:08:39'!
debit: anAmount from: aCard
closure value.
(amount >= anAmount) ifTrue:[amount := amount - anAmount.]


! !

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:09:59'!
isUp

^status! !

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:12:07'!
with: aClosure

closure := aClosure.
status := true.! !

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:12:24'!
with: aClosure  online:aBoolean

closure := aClosure.
status := aBoolean .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: #'Cart-Solution'!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:31:38'!
with: aClosure
^MPSimulator new with:aClosure ! !

!MPSimulator class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:11:17'!
with: aClosure online:aBoolean
^MPSimulator new with:aClosure online:aBoolean ! !


!classDefinition: #MerchantProcessor category: #'Cart-Solution'!
MerchantProcessorInterface subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:16:30'!
debit: anAmount from: aCreditCard
! !

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 23:16:42'!
isUp
! !


!classDefinition: #REST_Cart category: #'Cart-Solution'!
Object subclass: #REST_Cart
	instanceVariableNames: 'cart user id lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:50:34'!
add: anItem amount:anAmount
cart add: anItem amount:anAmount.
self usedLast: GregorianDateTime now.! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:35:14'!
catalog
^cart catalog! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:44:10'!
id
^id! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:58:37'!
isEmpty
^cart isEmpty.! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:11:27'!
lastUsed
^lastTimeUsed! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:21:48'!
listContents
^cart content


! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:39:51'!
shoppingCart
^cart! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:22:56'!
usedLast: aTime
lastTimeUsed := aTime! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:02:59'!
user
^user! !

!REST_Cart methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:36:34'!
withCart: aCart User: aUser ID: anId

cart := aCart.
user := aUser.
id := anId.
lastTimeUsed := Time now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'REST_Cart class' category: #'Cart-Solution'!
REST_Cart class
	instanceVariableNames: ''!

!REST_Cart class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:06:05'!
withCart: aCart User: aUser ID: anId

^self new withCart: aCart User: aUser ID: anId! !


!classDefinition: #REST_Interface category: #'Cart-Solution'!
Object subclass: #REST_Interface
	instanceVariableNames: 'usersDB catalog merchantProcessor lastUsedID carts expiredCarts usersPurchaseHistory incompleteSales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!REST_Interface commentStamp: '<historical>' prior: 0!
Esta interfaz tiene que conocer todo: las id's y passwords de los usuarios para autenticar, el catalogo para los carritos, el libro de ventas, tusLibros, al merchant processor, cuanto tiempo paso desde la ultima vez que se uso el carrito!


!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 17:12:49'!
add: anItem Amount:anAmount ToCart: aCartID

"agregar item al carrito"
self checkCanBeUsed: aCartID at: GregorianDateTime now.
(self cart: aCartID) add: anItem amount:anAmount.
^0! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:33:57'!
cart: aCartID
^carts at: aCartID ! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:58:51'!
carts
^carts copy! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:49:36'!
checkCanBeUsed: aCartID at: aTime

"deberia chequear que pasaron 30 minutos pero no se me ocurre como"
(self minutesPassedSince: (self cart: aCartID) lastUsed until: aTime)>30 ifTrue:[self expire: aCartID].
(self isExpired: aCartID) ifTrue:[^self error: 'cart cant be used anymore because it was inactive for more than 30 minutes or already checked out']
! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 17:11:58'!
checkOut: aCartID withCreditCardNumber: aCCNumber creditCardOwner: aCCOwner creditCardExpiration: aCCExpirationDate

"hacer checkout del carrito"
| cart cashier credCard userSalesBook |

self checkCanBeUsed: aCartID at: GregorianDateTime now.
cart := (self cart: aCartID).

credCard := CreditCard withNumber: aCCNumber Owner: aCCOwner Expiration: aCCExpirationDate .

userSalesBook := (usersPurchaseHistory at: cart user).

cashier:= Cashier withCart: cart shoppingCart aCreditCard: credCard  aDate: FixedGregorianDate today aMerchProcessor: merchantProcessor  withSalesBook: userSalesBook  withLibros: incompleteSales.

cashier checkOut.

self expire: aCartID.
^0! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:10:54'!
checkUser:aUserID pass: aPassword

^(usersDB includesKey: aUserID) and: [(usersDB at: aUserID) = aPassword]! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:46:49'!
createCartfor:aUserID autenticatedWith: aPassword

"necesito un registro de todos los usuarios con sus respectivas passwords"
"creo un carrito para el usuario y devuelvo el ID del carrito"

| cart |
(self checkUser:aUserID pass: aPassword) ifFalse:[^self error: 'user not registered'].

cart := REST_Cart withCart: (Cart withCatalog: catalog) User: aUserID ID: lastUsedID.

lastUsedID := lastUsedID + 1.

carts at: (cart id) put: cart.

^ cart id! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:51:20'!
expire: cartID

expiredCarts add: cartID! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:46:26'!
incompleteSales
^incompleteSales copy! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:31:20'!
isExpired: aCartID
^expiredCarts includes: aCartID
! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 14:26:40'!
listCart: aCartID

"listar contenido del carrito"
^(carts at: aCartID) listContents! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:45:20'!
listPurchasesOf:aCostumerID pass: aPassword
"listar las compras del cliente"
"para cada cliente hay que guardar un libro de ventas que tenga su historial de compras"
(self checkUser:aCostumerID pass: aPassword) ifFalse:[^self error:'not a costumer'].
^(usersPurchaseHistory at: aCostumerID) copy
! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:25:46'!
merchantProcessor
^merchantProcessor! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 15:56:19'!
minutesPassedSince: aMoment until: aEndingMoment
^0.! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:27:24'!
registerUsername:aUserName aPassword: aPass

(usersDB includesKey: aUserName) not ifFalse:[^self error: 'username already in use'].
usersDB at: aUserName put: aPass.! !

!REST_Interface methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 16:38:02'!
withUsers: aUserList Catalog: aCatalog MerchantProcessor: aMerchantP


usersDB := aUserList.
catalog:= aCatalog.
merchantProcessor := aMerchantP.

lastUsedID := 0.

usersPurchaseHistory:=Dictionary new.
usersDB keysDo:[:each | usersPurchaseHistory at: each put: LibroDeVentas new].

incompleteSales := TusLibros new.

carts := Dictionary new.

expiredCarts := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'REST_Interface class' category: #'Cart-Solution'!
REST_Interface class
	instanceVariableNames: ''!

!REST_Interface class methodsFor: 'as yet unclassified' stamp: 'df 6/27/2017 13:21:35'!
withUsers: aUserList Catalog: aCatalog MerchantProcessor: aMerchantP

^self new withUsers: aUserList Catalog: aCatalog MerchantProcessor: aMerchantP! !
