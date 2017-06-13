!classDefinition: #TestsCarrito category: #'Carrito-Solution'!
TestCase subclass: #TestsCarrito
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Carrito-Solution'!

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 17:40:23'!
test01CrearCarritoVacio
	| carrito |
	
	carrito := Carrito withProducts: {}.
	
	self assert: carrito isEmpty! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:31:18'!
test02AgregarUnLibroAUnCarritoVacio
	| carrito unLibro |
	
	carrito := Carrito withProducts: {} using: {'libro1'}.
	unLibro := LibroParaCarrito withName: 'libro1'.
	carrito insert: unLibro.
	
	self deny: carrito isEmpty! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:18:51'!
test03ProhibidoAgregarUnNoLibroAUnCarrito
	| carrito unNoLibro |
	
	carrito := Carrito withProducts: {} using: {}.
	unNoLibro := 'noLibro'.
	
	self 
		should: [ carrito insert: unNoLibro ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: 'prohibido agregar no libros a un carrito']! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:19:02'!
test04AgregarDosLibrosAUnCarritoVacio
	| carrito unLibro otroLibro |
	
	carrito := Carrito withProducts: {} using: {'libro1' . 'libro2'}.
	unLibro := LibroParaCarrito withName: 'libro1'.
	otroLibro := LibroParaCarrito withName: 'libro2'.
	carrito insert: unLibro.
	carrito insert: otroLibro.
	
	self deny: carrito isEmpty.
	self assert: carrito numberOfUnits = 2.! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:33:37'!
test05AgregarUnidadesDelMismoProductoAUnCarritoVacio
	| carrito unLibro otroLibro tercerLibro|
	
	carrito := Carrito withProducts: {} using: {'libro1' . 'libro1' . 'libro2'}.
	unLibro := LibroParaCarrito withName: 'libro1'.
	otroLibro := LibroParaCarrito withName: 'libro1'.
	tercerLibro := LibroParaCarrito withName: 'libro2'.
	carrito insert: unLibro.
	carrito insert: otroLibro.
	carrito insert: tercerLibro.
	
	self assert: ((carrito numberOfUnitsWithName: 'libro1') = 2).
	self assert: ((carrito numberOfUnitsWithName: 'libro2') = 1).
	self assert: ((carrito numberOfUnits) = 3).! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:14:53'!
test06ProhibidoAgregarUnProductoSiNoHayStock
	| carrito unLibroSinStock unLibroConStock aBagOfProducts|
	
	aBagOfProducts := Bag new.
	aBagOfProducts add: 'libro1'.
	
	carrito := Carrito withProducts: {} using: aBagOfProducts.
	unLibroSinStock := LibroParaCarrito withName: 'librox'.
	unLibroConStock := LibroParaCarrito withName: 'libro1'.
	carrito insert: unLibroConStock.
	
	self
		should: [ carrito insert: unLibroSinStock ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: 'prohibido agregar libros si no hay stock']! !

!TestsCarrito methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:21:00'!
test07BajarStockAlAgregarLibroAUnCarrito
	| carrito unLibro aBagOfProducts|
	
	aBagOfProducts := Bag new.
	aBagOfProducts add: 'libro1'.
	aBagOfProducts add: 'libro1'.
	
	carrito := Carrito withProducts: {} using: aBagOfProducts.
	unLibro := LibroParaCarrito withName: 'libro1'.
	carrito insert: unLibro.
	carrito insert: unLibro.
	
	self
		should: [ carrito insert: unLibro ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: 'prohibido agregar libros si no hay stock']! !


!classDefinition: #Carrito category: #'Carrito-Solution'!
Object subclass: #Carrito
	instanceVariableNames: 'productos stock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Carrito-Solution'!

!Carrito methodsFor: 'accessing' stamp: 'pR 6/12/2017 18:13:28'!
countOf: aLibroParaCarrito 
	|x ans|
	
	ans := 0.
	x := productos select: [:each | each name = aLibroParaCarrito name].
	x do: [:each | ans := ans + (productos occurrencesOf: each)].
	
	^ans! !

!Carrito methodsFor: 'accessing' stamp: 'pR 6/12/2017 17:39:49'!
isEmpty
	
	^productos isEmpty! !

!Carrito methodsFor: 'accessing' stamp: 'pR 6/12/2017 18:00:28'!
numberOfDifferentBooks
	
	^productos asSet size! !

!Carrito methodsFor: 'accessing' stamp: 'pR 6/12/2017 18:59:52'!
numberOfUnits
	
	^productos size! !

!Carrito methodsFor: 'accessing' stamp: 'pR 6/12/2017 19:02:19'!
numberOfUnitsWithName: aString 
	
	^(productos select: [:each | each name = aString]) size! !


!Carrito methodsFor: 'inserting' stamp: 'pR 6/12/2017 19:22:11'!
insert: aLibroParaCarrito 
	
	aLibroParaCarrito class = LibroParaCarrito ifFalse: [^self error: 'prohibido agregar no libros a un carrito'].
	(stock includes: aLibroParaCarrito name) ifFalse: [^self error: 'prohibido agregar libros si no hay stock'].
	
	productos add: aLibroParaCarrito.
	stock remove: aLibroParaCarrito name ifAbsent: [].! !


!Carrito methodsFor: 'initializing' stamp: 'pR 6/12/2017 17:50:27'!
withProducts: aSetOfProducts
	
	productos := aSetOfProducts asBag.! !

!Carrito methodsFor: 'initializing' stamp: 'pR 6/12/2017 19:15:36'!
withProducts: aSetOfProducts using: aBagOfProducts
	
	productos := aSetOfProducts asBag.
	stock := aBagOfProducts.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Carrito class' category: #'Carrito-Solution'!
Carrito class
	instanceVariableNames: ''!

!Carrito class methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:31:35'!
withProducts: aSetOfProducts

	^self new withProducts: aSetOfProducts asBag! !

!Carrito class methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 19:32:50'!
withProducts: aBagOfRequiredProducts using: aBagOfStockProducts

	^self new withProducts: aBagOfRequiredProducts asBag using: aBagOfStockProducts asBag! !


!classDefinition: #LibroParaCarrito category: #'Carrito-Solution'!
Object subclass: #LibroParaCarrito
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Carrito-Solution'!

!LibroParaCarrito methodsFor: 'initializing' stamp: 'pR 6/12/2017 18:13:03'!
= otroLibro
	
	^name = (otroLibro name)! !

!LibroParaCarrito methodsFor: 'initializing' stamp: 'pR 6/12/2017 18:06:29'!
name
	
	^name! !

!LibroParaCarrito methodsFor: 'initializing' stamp: 'pR 6/12/2017 18:03:36'!
withName: aString 
	
	name := aString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LibroParaCarrito class' category: #'Carrito-Solution'!
LibroParaCarrito class
	instanceVariableNames: ''!

!LibroParaCarrito class methodsFor: 'as yet unclassified' stamp: 'pR 6/12/2017 18:03:16'!
withName: aString 
	
	^self new withName: aString! !
