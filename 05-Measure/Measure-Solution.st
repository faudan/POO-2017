!classDefinition: #Medida category: #'Medidas-Solution'!
Magnitude subclass: #Medida
	instanceVariableNames: 'numberOfUnits unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas-Solution'!

!Medida methodsFor: 'as yet unclassified' stamp: 'df 6/2/2017 23:41:39'!
canNotPerformOperationWithDifferentTypes
^'no se puede realizar esta operacion con medidas de diferente tipo'! !

!Medida methodsFor: 'as yet unclassified' stamp: 'df 6/2/2017 23:42:58'!
checkIfOperationCanBePerformedWith: aMeasure

self class = aMeasure class ifFalse:[^'no se pueden sumar, son distintos tipos de medida']! !


!Medida methodsFor: 'accessing' stamp: 'df 6/2/2017 23:27:36'!
size
^ numberOfUnits! !

!Medida methodsFor: 'accessing' stamp: 'df 6/2/2017 23:27:42'!
unit
^unit! !


!Medida methodsFor: 'arithmetic' stamp: 'df 6/2/2017 23:39:20'!
* aNumber

^ self class initializeWithAmount: self size * aNumber  Unit: self unit! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/2/2017 23:43:09'!
+ aMeasure

self checkIfOperationCanBePerformedWith: aMeasure.
^ self class initializeWithAmount: self size + aMeasure size Unit: self unit! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/2/2017 23:43:48'!
- aMeasure

self checkIfOperationCanBePerformedWith: aMeasure.
^ self class initializeWithAmount: self size - aMeasure size Unit: self unit! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/2/2017 23:39:28'!
/ aNumber

^ self class initializeWithAmount: self size / aNumber  Unit: self unit! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/3/2017 00:15:59'!
adaptToNumber: rcvr andSend: selector

	selector = #* ifTrue: [^self class initializeWithAmount: self size * rcvr Unit: self unit ]! !


!Medida methodsFor: 'initializing' stamp: 'df 6/2/2017 23:22:15'!
initializeWithAmount: anAmount Unit: aUnit

numberOfUnits:= anAmount.
unit := aUnit! !


!Medida methodsFor: 'comparing' stamp: 'df 6/2/2017 23:45:02'!
< aMeasure

self checkIfOperationCanBePerformedWith: aMeasure.
^ self size < aMeasure size! !

!Medida methodsFor: 'comparing' stamp: 'df 6/2/2017 23:38:16'!
= aMeasure

self class = aMeasure class ifTrue:[^ self size = aMeasure size] ifFalse:[^self size = 0 and:[aMeasure size = 0]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Medida class' category: #'Medidas-Solution'!
Medida class
	instanceVariableNames: ''!

!Medida class methodsFor: 'class initialization' stamp: 'df 6/2/2017 23:22:09'!
initializeWithAmount: anAmount Unit: aUnit

^ self new initializeWithAmount: anAmount Unit: aUnit! !


!classDefinition: #Distancia category: #'Medidas-Solution'!
Medida subclass: #Distancia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Medidas-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'as yet unclassified' stamp: 'df 6/2/2017 23:53:39'!
initializeWithMeters: aDistance


^self new initializeWithAmount: aDistance Unit: meter! !


!classDefinition: #Volumen category: #'Medidas-Solution'!
Medida subclass: #Volumen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Volumen class' category: #'Medidas-Solution'!
Volumen class
	instanceVariableNames: ''!

!Volumen class methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:14:33'!
initializeWithLiters: aVolume

^self new initializeWithAmount: aVolume Unit: liter! !


!classDefinition: #MedidaTest category: #'Medidas-Solution'!
TestCase subclass: #MedidaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas-Solution'!

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:19:37'!
test01medidasDeDistintoTipoSonDistintasAMenosQueRepresentenElCero

| unLitro unMetro otroLitro ceroLitros ceroMetros |
unMetro :=  Distancia initializeWithMeters: 1.
unLitro := Volumen initializeWithLiters: 1.
otroLitro := Volumen initializeWithLiters: 1.
ceroMetros :=  Distancia initializeWithMeters: 0.
ceroLitros := Volumen initializeWithLiters: 0.

self deny: unMetro = unLitro.
self assert: unLitro = otroLitro.
self assert: ceroMetros = ceroLitros! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:09:42'!
test02puedoSumarMedidasDelMismoTipo

| unLitro dosLitros |

unLitro := Volumen initializeWithLiters: 1.
dosLitros := Volumen initializeWithLiters:2.

self assert: unLitro + unLitro = dosLitros.
self assert: unLitro + dosLitros = (dosLitros + unLitro )! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:06:47'!
test03puedoRestarMedidasDelMismoTipo

| unLitro dosLitros |

unLitro := Volumen initializeWithLiters: 1.
dosLitros := Volumen initializeWithLiters:2.
self assert:dosLitros - unLitro = unLitro! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:10:10'!
test04puedoMultiplicarUnNumeroPorUnaMedida

| unLitro dosLitros |

unLitro := Volumen initializeWithLiters: 1.
dosLitros := Volumen initializeWithLiters:2.
self assert:dosLitros  = (unLitro * 2).
self assert: unLitro * 2 = (2*unLitro)! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:17:04'!
test05puedoDividirUnaMedidaPorUnNumero

| unLitro dosLitros |

unLitro := Volumen initializeWithLiters: 1.
dosLitros := Volumen initializeWithLiters:2.

self assert: unLitro = (dosLitros/2)! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/3/2017 00:17:24'!
test06puedoCompararMedidas

| unLitro dosLitros |

unLitro := Volumen initializeWithLiters: 1.
dosLitros := Volumen initializeWithLiters:2.

self assert: unLitro = (dosLitros/2)! !


!classDefinition: #Unit category: #'Medidas-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'factorToBase name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Medidas-Solution'!

!Unit methodsFor: 'printing' stamp: 'pR 6/1/2017 19:43:06'!
printString

	^name! !


!Unit methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:45:26'!
factorToBase

	^factorToBase! !


!Unit methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:43:22'!
withName: aString withConversionFactorToBase: aNumber

	name := aString.
	factorToBase := aNumber
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Medidas-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'class initialization' stamp: 'df 6/2/2017 23:53:26'!
setUp

Smalltalk at:#meter put: (Unit withName:'meter'  withConversionFactorToBase: 1).
Smalltalk at:#liter put: (Unit withName:'liter'  withConversionFactorToBase: 1).
Smalltalk at:#gram put: (Unit withName:'gram'  withConversionFactorToBase: 1).
! !

!Unit class methodsFor: 'class initialization' stamp: 'pR 6/1/2017 19:36:41'!
withName: aString withConversionFactorToBase: aNumber

	^self new withName: aString withConversionFactorToBase: aNumber! !
