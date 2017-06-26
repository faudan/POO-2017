!classDefinition: #Cashier category: #'Cart-Solution'!
Dictionary subclass: #Cashier
	instanceVariableNames: 'cart creditCard date libroDeVentas merchantProcessor tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:29:05'!
checkOut

| saleAmount |
saleAmount := cart totalPrice.


((merchantProcessor debit: saleAmount from: creditCard) isKindOf: ErrorMP) ifTrue:[ ^self tusLibros].


 
self recordSaleInBook.
! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:32:59'!
recordSaleInBook

cart content do:[:each | libroDeVentas add: {each. cart catalog priceOf: each}].

! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:36:22'!
saleBook
^libroDeVentas copy! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:51:26'!
tusLibros

cart content do:[:each | tusLibros add: {each. cart catalog priceOf: each}].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:51:46'!
withCart: aCart CreditCard: aCreditCard Date: aDate


cart:= aCart.
creditCard:=aCreditCard.
date:= aDate.
tusLibros := Set new.

libroDeVentas := Set new.! !

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


!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 16:37:42'!
checkIfExists: anItem

(self includesKey: anItem) ifFalse:[^self itemNotInCatalog ].! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:19:02'!
itemNotInCatalog
^ self error:'the requested item is not in the catalog and cant be added'! !

!ShoppingCatalog methodsFor: 'as yet unclassified' stamp: 'df 6/16/2017 15:31:02'!
priceOf: anItem

^self at:anItem! !


!classDefinition: #LibroDeVentas category: #'Cart-Solution'!
Set subclass: #LibroDeVentas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!LibroDeVentas commentStamp: '<historical>' prior: 0!
Aca se guardan las ventas que hacen los cashiers, igual que el catalogo, debe haber un unico libro para todos, seria el registro de ventas del sistema!



!classDefinition: #TusLibros category: #'Cart-Solution'!
Set subclass: #TusLibros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!TusLibros commentStamp: '<historical>' prior: 0!
Aca van a ir las ventas que no se puedan realizar cuando el merchan processor este caido, igual que el libro de ventas, debe compartirse entre Cashiers!



!classDefinition: #ErrorMP category: #'Cart-Solution'!
Exception subclass: #ErrorMP
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!ErrorMP commentStamp: '<historical>' prior: 0!
Es el tipo de excepcion que el MPSimulator devuelve cuando simula que el MP esta caido!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorMP class' category: #'Cart-Solution'!
ErrorMP class
	instanceVariableNames: ''!

!ErrorMP class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:29:27'!
caido
^self new! !


!classDefinition: #MarketTests category: #'Cart-Solution'!
TestCase subclass: #MarketTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:36:02'!
testAddingItemsNotInCatalogShouldNotBePossibleAndRaiseAnExceptionInstead


| cart book catalog |
catalog:= ShoppingCatalog new.


cart := MarketFactory emptyCartWithCatalog: catalog.
book := Object new.
self should:[cart add: book] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the requested item is not in the catalog and cant be added'.
			self assert: cart isEmpty.
			]! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:36:06'!
testCanAddItemsInCatalog


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:0.


cart := MarketFactory emptyCartWithCatalog: catalog.

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

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:36:10'!
testCanAddManyOfTheSameItems


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:1.
catalog at: book2 put:10.

cart := MarketFactory  emptyCartWithCatalog: catalog.

cart add: book1.
cart add: book2 amount:3.

self deny: cart isEmpty.
self assert: ((cart content occurrencesOf: book1) = 1 ).
self assert: ((cart content occurrencesOf: book2) = 3).
self assert: (cart size=4)
! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:35:55'!
testCanHaveAnEmptyCart


| cart |

cart := MarketFactory emptyCart.

self assert: cart isEmpty! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:49:29'!
testShouldNotBeAbleToAddAFractionOfAnItem


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:1.
catalog at: book2 put:10.

cart := MarketFactory  emptyCartWithCatalog: catalog.

self should:[cart add: book1 amount: 3/2] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'cant add a non integer amount of items'.
			self assert: cart isEmpty.
			].

! !

!MarketTests methodsFor: 'CartTesting' stamp: 'df 6/26/2017 15:46:52'!
testShouldNotBeAbleToAddLessThanOneItem


| cart book1 catalog book2 |
catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:1.
catalog at: book2 put:10.

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


!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/26/2017 15:38:53'!
testCanCheckOutIfMoneyInCardIsEnough

| cart credCard cashier today merchProc |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.

merchProc := MarketFactory merchProcessorSim: [].

merchProc addCard: credCard withAmount: cart totalPrice.

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.

cashier checkOut.

self assert: merchProc cardAmount = 0.
self deny: cashier saleBook isEmpty.



! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/26/2017 15:39:14'!
testCantCheckOutIfCardIsStolen

| cart credCard cashier today merchProc |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.
merchProc := MarketFactory merchProcessorSim: [InterfazMP errorStolenCard].

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

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/26/2017 15:39:19'!
testCantCheckOutIfMoneyInCardIsNotEnough

| cart credCard cashier today merchProc |
cart := MarketFactory nonEmptyCart.

credCard := MarketFactory nonExpiredCard.

today := MarketFactory today.

merchProc := MarketFactory merchProcessorSim: [InterfazMP errorInsufficientFunds].
merchProc addCard: credCard withAmount: (cart totalPrice -1).

cashier:= Cashier withCart: cart aCreditCard: credCard  aDate: today aMerchProcessor: merchProc.

self should:[cashier checkOut]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'the account doesnt have enough funds to pay'.
			self assert: merchProc cardAmount = (cart totalPrice -1).
			self assert: cashier saleBook isEmpty.

			].


! !

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/26/2017 15:38:25'!
testCantCreateACashierWithAnEmptyCart


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

!MarketTests methodsFor: 'CashierTesting' stamp: 'df 6/26/2017 15:38:40'!
testCantCreateACashierWithAnExpiredCard


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

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/26/2017 15:37:49'!
testCantCreateCreditCardsWithInvalidNumber

| credCard |



self should:[credCard := CreditCard withNumber: '123456789012345' Owner: 'john connor'  Expiration: Date today.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [
			:anError |
			self assert: anError messageText equals: 'invalid card number'.
			self assert: (credCard class =UndefinedObject).
			].
! !

!MarketTests methodsFor: 'CreditCardTesting' stamp: 'df 6/26/2017 15:38:00'!
testCantCreateCreditCardsWithNoOwner

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

!Cart methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 15:48:39'!
add: anItem amount: anAmount

catalog checkIfExists:anItem.anAmount < 1 ifTrue:[self error: 'cant add less than one item'].
(anAmount isInteger) ifFalse:[self error: 'cant add a non integer amount of items'].
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


!classDefinition: #InterfazMP category: #'Cart-Solution'!
Object subclass: #InterfazMP
	instanceVariableNames: 'card amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!

!InterfazMP methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:48:40'!
addCard: aCredCard withAmount: anAmount

card := aCredCard.
amount := anAmount ! !

!InterfazMP methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:54:50'!
cardAmount
^amount! !

!InterfazMP methodsFor: 'as yet unclassified' stamp: 'df 6/22/2017 19:51:36'!
debit: anAmount from: aCreditCard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfazMP class' category: #'Cart-Solution'!
InterfazMP class
	instanceVariableNames: ''!

!InterfazMP class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 17:31:32'!
errorInsufficientFunds
^self error:'the account doesnt have enough funds to pay'! !

!InterfazMP class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 17:30:38'!
errorStolenCard
 ^self error:'card is stolen'! !


!classDefinition: #MPSimulator category: #'Cart-Solution'!
InterfazMP subclass: #MPSimulator
	instanceVariableNames: 'closure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!MPSimulator commentStamp: '<historical>' prior: 0!
El simulador tiene que ser polimorfico con MerchProcessor!


!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:23:52'!
debit: anAmount from: aCard
closure value.
(amount >= anAmount) ifTrue:[amount := amount - anAmount. ^1.]


! !

!MPSimulator methodsFor: 'as yet unclassified' stamp: 'df 6/22/2017 20:00:21'!
with: aClosure

closure := aClosure! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MPSimulator class' category: #'Cart-Solution'!
MPSimulator class
	instanceVariableNames: ''!

!MPSimulator class methodsFor: 'as yet unclassified' stamp: 'df 6/26/2017 16:01:44'!
errorMPUnavailable
 ^ErrorMP caido! !

!MPSimulator class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:31:38'!
with: aClosure
^MPSimulator new with:aClosure ! !


!classDefinition: #MerchProcessor category: #'Cart-Solution'!
InterfazMP subclass: #MerchProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!


!classDefinition: #InterfazREST category: #'Cart-Solution'!
Object subclass: #InterfazREST
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cart-Solution'!
!InterfazREST commentStamp: '<historical>' prior: 0!
Esta interfaz tiene que conocer todo: las id's y passwords de los usuarios para autenticar, el catalogo para los carritos, el libro de ventas, tusLibros, al merchant processor, cuanto tiempo paso desde la ultima vez que se uso el carrito!


!InterfazREST methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:36:51'!
addToCart: anItem

"agregar al carrito"! !

!InterfazREST methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:36:43'!
checkOut

"hacer checkout"! !

!InterfazREST methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:36:11'!
createCartfor:anID autenticatedWith: aPassword

"necesito un registro de todos los usuarios con sus respectivas passwords"! !

!InterfazREST methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:36:25'!
listCart

"listar todos los carritos"! !

!InterfazREST methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 18:36:34'!
listPurchases
"listar las compras"! !


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

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:34:44'!
merchProcessorSim: aClosure
^MPSimulator with: aClosure! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:16:15'!
nonEmptyCart

| book1 book2 cart catalog |

catalog := ShoppingCatalog new.


book1 := Object new.
book2 := Object new.

catalog at:book1 put:1.
catalog at: book2 put:10.

cart := Cart withCatalog: catalog.

cart add: book1.
cart add: book2 amount:3.

^cart! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:15:02'!
nonExpiredCard

| date |
date := GregorianMonthOfYear yearNumber: 2020 monthNumber:1.

^ CreditCard withNumber: '1234567890123456' Owner: 'john connor'  Expiration: date.! !

!MarketFactory class methodsFor: 'as yet unclassified' stamp: 'df 6/24/2017 16:18:28'!
today
^ FixedGregorianDate today! !
