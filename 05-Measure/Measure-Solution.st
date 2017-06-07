!classDefinition: #Medida category: #'Measures-Solution'!
Magnitude subclass: #Medida
	instanceVariableNames: 'numberOfUnits unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Medida methodsFor: 'accessing' stamp: 'df 6/4/2017 17:28:26'!
amount
	
	^numberOfUnits! !

!Medida methodsFor: 'accessing' stamp: 'pR 6/3/2017 14:31:55'!
asBaseUnits
	
	^numberOfUnits * unit factorToBase! !

!Medida methodsFor: 'accessing' stamp: 'pR 6/4/2017 23:03:45'!
base

	^self subclassResponsibility! !

!Medida methodsFor: 'accessing' stamp: 'pR 6/3/2017 14:54:50'!
isZero

	^numberOfUnits = 0! !

!Medida methodsFor: 'accessing' stamp: 'pR 6/3/2017 13:16:11'!
numberOfUnitsInBase

	^self subclassResponsibility! !

!Medida methodsFor: 'accessing' stamp: 'pR 6/6/2017 18:51:49'!
unit

	^unit! !


!Medida methodsFor: 'arithmetic' stamp: 'pR 6/6/2017 19:37:18'!
* aMeasure

	self class = aMeasure class ifFalse: [
		(self isNumber not and: aMeasure isNumber not) ifTrue: [^Compuesta initializeWith: self andMultiply: aMeasure]
	].
	(self class = aMeasure class) ifTrue: [^Compuesta initializeWith: self andMultiply: aMeasure].
	
	self checkIfCanBeMultipliedBy: aMeasure.
	
	^self class initializeWithAmount: self numberOfUnitsInBase * aMeasure  withUnit: self base! !

!Medida methodsFor: 'arithmetic' stamp: 'pR 6/6/2017 09:45:20'!
+ aMeasure

	"self checkIfCanBeAddedBy: aMeasure."
	
	self class = aMeasure class ifFalse: [^Compuesta initializeWith: self andSum: aMeasure].
	(self class = aMeasure class and: aMeasure class = Compuesta) ifTrue: [^Compuesta initializeWith: self andSum: aMeasure].
	
	^self class initializeWithAmount: self numberOfUnitsInBase + aMeasure numberOfUnitsInBase withUnit: self base! !

!Medida methodsFor: 'arithmetic' stamp: 'pR 6/6/2017 10:37:43'!
- aMeasure

	"self checkIfCanBeSubtractedBy: aMeasure."
	
	self class = aMeasure class ifFalse: [^Compuesta initializeWith: self andSubtract: aMeasure].
	(self class = aMeasure class and: aMeasure class = Compuesta) ifTrue: [^Compuesta initializeWith: self andSubtract: aMeasure].
	
	^self class initializeWithAmount: self numberOfUnitsInBase - aMeasure numberOfUnitsInBase withUnit: self base! !

!Medida methodsFor: 'arithmetic' stamp: 'pR 6/6/2017 21:10:18'!
/ aNumberOrMeasure

	self checkIfCanBeDividedBy: aNumberOrMeasure.
	
	(aNumberOrMeasure isNumber) ifTrue: [^self class initializeWithAmount: self numberOfUnitsInBase / aNumberOrMeasure  withUnit: self base].
	
	(self unit = aNumberOrMeasure unit)
		ifTrue: [^self numberOfUnitsInBase / aNumberOrMeasure numberOfUnitsInBase].
		
	^Compuesta initializeWith: self andDivide: aNumberOrMeasure.! !

!Medida methodsFor: 'arithmetic' stamp: 'pR 6/3/2017 16:46:58'!
abs

	^self numberOfUnitsInBase abs! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/4/2017 17:28:57'!
adaptToNumber: rcvr andSend: selector

	selector = #* ifTrue: [^self class initializeWithAmount: self amount * rcvr withUnit: self unit ]! !

!Medida methodsFor: 'arithmetic' stamp: 'df 6/4/2017 17:42:46'!
createCollectionWith: aMeasure

| aCollection |
aCollection := Bag new.

aCollection add: self.
aCollection add: aMeasure.
^aCollection.
! !

!Medida methodsFor: 'arithmetic' stamp: 'pR 6/3/2017 16:49:41'!
negated

	^self class initializeWithAmount: -1 * numberOfUnits withUnit: unit! !


!Medida methodsFor: 'initializing' stamp: 'pR 6/3/2017 13:31:47'!
initializeWithAmount: anAmount withUnit: aUnit

	numberOfUnits:= anAmount.
	unit := aUnit! !


!Medida methodsFor: 'comparing' stamp: 'pR 6/3/2017 14:39:50'!
< aMeasure

	self checkIfCanBeComparedByMinus: aMeasure.
	
	^self numberOfUnitsInBase < aMeasure numberOfUnitsInBase! !

!Medida methodsFor: 'comparing' stamp: 'pR 6/6/2017 12:47:40'!
= aMeasure
	(self class = aMeasure class or: self class = Compuesta or: aMeasure class = Compuesta)	
		ifTrue: [^self numberOfUnitsInBase = aMeasure numberOfUnitsInBase]
		ifFalse: [^self numberOfUnitsInBase = 0 and: [aMeasure numberOfUnitsInBase = 0] ].! !


!Medida methodsFor: 'converting' stamp: 'pR 6/3/2017 15:18:14'!
convertTo: aUnit

	self checkCanConvertFrom: self unit to: aUnit.

	^self class initializeWithAmount: self numberOfUnitsInBase / aUnit factorToBase withUnit: aUnit! !

!Medida methodsFor: 'converting' stamp: 'pR 6/3/2017 14:16:46'!
hash

	^{self class asString . self numberOfUnitsInBase} hash! !


!Medida methodsFor: 'checking' stamp: 'pR 6/3/2017 15:23:01'!
checkCanConvertFrom: aUnit to: anotherUnit.

	aUnit measurableClass = anotherUnit measurableClass ifFalse: [^self error: self class canOnlyConvertBetweenUnitsOnSameMeasure]! !

!Medida methodsFor: 'checking' stamp: 'pR 6/3/2017 14:52:18'!
checkIfCanBeAddedBy: aMeasure

	((self isKindOf: aMeasure class) or: (aMeasure isKindOf: self class))
		ifFalse: [^self error: self class canNotPerformOperationWithDifferentTypes]! !

!Medida methodsFor: 'checking' stamp: 'pR 6/3/2017 14:52:14'!
checkIfCanBeComparedByMinus: aMeasure

	((self isKindOf: aMeasure class) or: (aMeasure isKindOf: self class)) 
		ifFalse: [^self error: self class canNotPerformOperationWithDifferentTypes]! !

!Medida methodsFor: 'checking' stamp: 'pR 6/6/2017 21:04:32'!
checkIfCanBeDividedBy: aNumberOrMeasure

	((aNumberOrMeasure isKindOf: Medida) or: aNumberOrMeasure isNumber) 
		ifFalse: [^self error: self class canOnlyPerfermDivisionWithNumbersOrMeasures].! !

!Medida methodsFor: 'checking' stamp: 'pR 6/3/2017 14:53:31'!
checkIfCanBeMultipliedBy: aMeasureOrNumber

	aMeasureOrNumber isNumber 
		ifTrue: [^self].
	((self isKindOf: aMeasureOrNumber class) or: (aMeasureOrNumber isKindOf: self class))
		ifFalse: [^self error: self class canNotPerformOperationWithDifferentTypes]! !

!Medida methodsFor: 'checking' stamp: 'pR 6/3/2017 14:50:04'!
checkIfCanBeSubtractedBy: aMeasure

	((self isKindOf: aMeasure class) or: (aMeasure isKindOf: self class))
		ifFalse: [^self error: self class canNotPerformOperationWithDifferentTypes]! !


!Medida methodsFor: 'printing' stamp: 'pR 6/3/2017 14:28:48'!
printString
	
	numberOfUnits = 1 ifTrue: [ ^numberOfUnits asString, ' ', unit printString ].
	^numberOfUnits asString, ' ', unit printString, 's'! !


!Medida methodsFor: 'intervalization' stamp: 'df 6/4/2017 16:25:06'!
to: aMeasure

	^MedidaInterval new from: self to: aMeasure ! !

!Medida methodsFor: 'intervalization' stamp: 'df 6/4/2017 16:25:16'!
to: aMeasure by: aStep

	^MedidaInterval new from: self to: aMeasure by: aStep! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Medida class' category: #'Measures-Solution'!
Medida class
	instanceVariableNames: ''!

!Medida class methodsFor: 'class initialization' stamp: 'pR 6/3/2017 13:41:01'!
canNotPerformOperationWithDifferentTypes

	^'no se puede realizar esta operacion con medidas de diferente tipo'! !

!Medida class methodsFor: 'class initialization' stamp: 'pR 6/3/2017 15:20:08'!
canOnlyConvertBetweenUnitsOnSameMeasure

	^'solo convertir entre unidades que miden lo mismo'! !

!Medida class methodsFor: 'class initialization' stamp: 'pR 6/3/2017 14:21:58'!
canOnlyPerfermDivisionWithNumbersOrMeasures

	^'solo se puede dividr una medida por una medida o por un numero'! !

!Medida class methodsFor: 'class initialization' stamp: 'pR 6/6/2017 19:10:09'!
initializeWithAmount: anAmount withUnit: aUnit
	^self new initializeWithAmount: anAmount withUnit: aUnit! !


!classDefinition: #Compuesta category: #'Measures-Solution'!
Medida subclass: #Compuesta
	instanceVariableNames: 'measures'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:03:58'!
base! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 21:40:28'!
initializeWith: aMeasure andDivide: anotherMeasure
	| newNumerator newDenominator newNumberOfUnits denominator2 |
	
	newNumerator := Bag new.
	newDenominator := Bag new.
	newNumberOfUnits := 1.
	
	aMeasure unit class = CompoundUnit
		ifTrue: [
			aMeasure unit unitsNumerator do: [:each | newNumerator add: each ].
			aMeasure unit unitsDenominator do: [:each | newDenominator add: each].
			]
		ifFalse: [
			newNumerator add: aMeasure unit. 
			].
		
	anotherMeasure unit class = CompoundUnit
		ifTrue: [
			anotherMeasure unit unitsNumerator do: [:each | newDenominator add: each ].
			anotherMeasure unit unitsDenominator do: [:each | newNumerator add: each].
		]
		ifFalse: [	
			newDenominator add: anotherMeasure unit.
			].
		newNumberOfUnits := aMeasure amount/ anotherMeasure amount.
		
		
		denominator2 := Bag new.
		newDenominator do: [:each | newNumerator remove: each ifAbsent: [denominator2 add: each] ].
		newDenominator  := denominator2.
		
		(newDenominator isEmpty and: newNumerator size = 1) 
			ifTrue: [unit := newNumerator asArray at: 1]
			ifFalse: [unit := CompoundUnit withNumerator: newNumerator withDenominator: newDenominator].
		
		numberOfUnits := newNumberOfUnits.
		measures := Set new.
		measures add: (Compuesta2 initializeWithAmount: newNumberOfUnits  withUnit: unit).! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 21:40:10'!
initializeWith: aMeasure andMultiply: anotherMeasure
	| newNumerator newDenominator newNumberOfUnits denominator2 |
	newNumerator := Bag new.
	newDenominator := Bag new.
	newNumberOfUnits := 1.
	
	aMeasure unit class = CompoundUnit
		ifTrue: [
			aMeasure unit unitsNumerator do: [:each | newNumerator add: each ].
			aMeasure unit unitsDenominator do: [:each | newDenominator add: each].
			aMeasure measures do: [:each | newNumberOfUnits := newNumberOfUnits * (each amount) ].
		]
		ifFalse: [
			newNumerator add: aMeasure unit. 
			newNumberOfUnits := newNumberOfUnits * aMeasure amount
		].
		
	anotherMeasure unit class = CompoundUnit
		ifTrue: [
			anotherMeasure unit unitsNumerator do: [:each | newNumerator add: each ].
			anotherMeasure unit unitsDenominator do: [:each | newDenominator add: each].
			anotherMeasure measures do: [:each | newNumberOfUnits := newNumberOfUnits * (each amount)].
		]
		ifFalse: [	
			newNumerator add: anotherMeasure unit.
			newNumberOfUnits := newNumberOfUnits * anotherMeasure amount
		].
	
	
	denominator2 := Bag new.
	newDenominator do: [:each | newNumerator remove: each ifAbsent: [denominator2 add: each] ].
	newDenominator  := denominator2 .
	
	(newDenominator isEmpty and: newNumerator size = 1) 
		ifTrue: [unit := newNumerator asOrderedCollection first]
		ifFalse: [unit := CompoundUnit withNumerator: newNumerator withDenominator: newDenominator].
	
	numberOfUnits := newNumberOfUnits.
	measures := Set new.
	measures add: (Compuesta2 initializeWithAmount: newNumberOfUnits  withUnit: unit).! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:52:18'!
initializeWith: aMeasure andSubtract: anotherMeasure
	
	numberOfUnits := 1.
	unit := CompoundUnit new.
	measures := Set new.
	
	aMeasure class = Compuesta 
		ifTrue: [aMeasure measures do: [:each | measures add: each] ]
		ifFalse: [measures add: aMeasure].
	
	anotherMeasure class = Compuesta
		ifTrue: [
			| newMeasures classesLeft classesRight|
			newMeasures := Set new.
			classesLeft := measures collect: [:each | each class].
			classesRight := anotherMeasure measures collect: [:each | each class].
			measures do: [:leftMeasure |
				anotherMeasure measures do: [:rightMeasure |
					leftMeasure class = rightMeasure class ifTrue: [
						((leftMeasure - rightMeasure) numberOfUnitsInBase = 0) not ifTrue: [ newMeasures add: leftMeasure - rightMeasure] 
					]				
				].
				(classesRight includes: leftMeasure class ) ifFalse: [newMeasures add: leftMeasure].
			].
			anotherMeasure measures do: [:rightMeasure |
				(classesLeft includes: rightMeasure class) ifFalse: [newMeasures add: -1 * rightMeasure]
			].
			measures := newMeasures.
		]
		ifFalse: [
			| newMeasures classesLeft|
			classesLeft := measures collect: [:each | each class].
			newMeasures := Set new.
			measures do: [:each | 
				each class = anotherMeasure class 
					ifTrue: [((each - anotherMeasure) numberOfUnitsInBase = 0) not ifTrue: [newMeasures add: each - anotherMeasure] ]
					ifFalse: [newMeasures add: each].
			].
			(classesLeft includes: anotherMeasure class) ifFalse: [newMeasures add: -1 * anotherMeasure].
			
			measures := newMeasures.	
		].
	
	measures size = 1 ifTrue: [^measures asArray at: 1].! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:52:22'!
initializeWith: aMeasure andSum: anotherMeasure
	
	numberOfUnits := 1.
	unit := CompoundUnit new.
	measures := Set new.
	
	aMeasure class = Compuesta
		ifTrue: [aMeasure measures do: [:each | measures add: each ] ]
		ifFalse: [measures add: aMeasure].
		
	anotherMeasure class = Compuesta 
		ifTrue: [ 
			| newMeasures classesLeft classesRight|
			newMeasures := Set new.
			classesLeft := measures collect: [:each | each class].
			classesRight := anotherMeasure measures collect: [:each | each class].
			measures do: [:leftMeasure |
				anotherMeasure measures do: [:rightMeasure |
					leftMeasure class = rightMeasure class ifTrue: [
						((leftMeasure + rightMeasure) numberOfUnitsInBase = 0) not ifTrue: [ newMeasures add: leftMeasure + rightMeasure] 
					]				
				].
				(classesRight includes: leftMeasure class ) ifFalse: [newMeasures add: leftMeasure].
			].
			anotherMeasure measures do: [:rightMeasure |
				(classesLeft includes: rightMeasure class) ifFalse: [newMeasures add: rightMeasure]
			].
			measures := newMeasures.
		]
		ifFalse: [
			| flag newMeasures |
			flag := false.
			newMeasures := Set new.
			measures do: [:each | 
				each class = anotherMeasure class 
					ifTrue: [((each + anotherMeasure) numberOfUnitsInBase = 0) not ifTrue: [newMeasures add: each + anotherMeasure. flag := true. ] ]
					ifFalse: [newMeasures add: each].
			].
			flag ifFalse: [newMeasures add: anotherMeasure].
			measures := newMeasures.
		].! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 20:11:30'!
initializeWith: aMeasure andUnit: aUnit

	measures := Set new.
	measures add: aMeasure.
	unit := aUnit.
	numberOfUnits := 1.! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 22:45:11'!
measures

	^measures! !

!Compuesta methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 19:20:45'!
numberOfUnitsInBase

	measures size = 1 ifTrue: [^(measures asArray at: 1) numberOfUnitsInBase].
	^measures
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Compuesta class' category: #'Measures-Solution'!
Compuesta class
	instanceVariableNames: ''!

!Compuesta class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 20:47:38'!
initializeWith: aMeasure andDivide: anotherMeasure

	^self new initializeWith: aMeasure andDivide: anotherMeasure
! !

!Compuesta class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:43:35'!
initializeWith: aMeasure andMultiply: anotherMeasure

	^self new initializeWith: aMeasure andMultiply: anotherMeasure
! !

!Compuesta class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 09:33:06'!
initializeWith: aMeasure andSubtract: anotherMeasure

	^self new initializeWith: aMeasure andSubtract: anotherMeasure! !

!Compuesta class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 09:32:55'!
initializeWith: aMeasure andSum: anotherMeasure

	^self new initializeWith: aMeasure andSum: anotherMeasure! !

!Compuesta class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 20:09:55'!
initializeWith: aMeasure andUnit: aUnit

	^self new initializeWith: aMeasure andUnit: aUnit! !


!classDefinition: #Compuesta2 category: #'Measures-Solution'!
Medida subclass: #Compuesta2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Compuesta2 methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 20:35:44'!
numberOfUnitsInBase

	^numberOfUnits! !


!classDefinition: #Distancia category: #'Measures-Solution'!
Medida subclass: #Distancia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Distancia methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:59:13'!
initializeScaleLike: aUnit withNumberOfUnits: aNumberOfUnits

	numberOfUnits := aNumberOfUnits.
	unit := aUnit.! !

!Distancia methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:55:26'!
initializeWithMeters: aSmallInteger 
	
	^self initializeScaleLike: meter withNumberOfUnits: aSmallInteger! !


!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 20:16:33'!
amount
	
	^numberOfUnits! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:49:30'!
asMeters
	
	^numberOfUnits * unit factorToBase! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/3/2017 14:08:14'!
base
	
	^meter! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:49:43'!
meters
	
	^self asMeters! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/3/2017 14:32:47'!
numberOfUnitsInBase
	
	^self asBaseUnits! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 20:17:02'!
unit
	
	^unit! !


!Distancia methodsFor: 'printing' stamp: 'pR 6/1/2017 20:15:56'!
printString
	
	numberOfUnits = 1 ifTrue: [ ^numberOfUnits asString, ' ', unit printString ].
	^numberOfUnits asString, ' ', unit printString, 's'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Measures-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'class initialization' stamp: 'pR 6/1/2017 20:03:58'!
initializeScaleLike: aUnit withNumberOfUnits: aNumberOfUnits

	^self new initializeScaleLike: aUnit withNumberOfUnits: aNumberOfUnits! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 6/1/2017 19:54:28'!
initializeWithCentimeters: aSmallInteger 
	
	^self new initializeScaleLike: centimeter withNumberOfUnits: aSmallInteger
	! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 6/1/2017 19:53:46'!
initializeWithKilometers: aSmallInteger 
	
	^self new initializeScaleLike: kilometer withNumberOfUnits: aSmallInteger! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 6/1/2017 20:04:33'!
initializeWithMeters: aSmallInteger 
	
	^self new initializeScaleLike: meter withNumberOfUnits: aSmallInteger! !


!classDefinition: #Peso category: #'Measures-Solution'!
Medida subclass: #Peso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Peso methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:04:11'!
base! !

!Peso methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:40:15'!
numberOfUnitsInBase

	^numberOfUnits! !


!classDefinition: #Temperatura category: #'Measures-Solution'!
Medida subclass: #Temperatura
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Temperatura methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 19:30:10'!
+ aTemperature

	self class = aTemperature class ifFalse: [^super + aTemperature].
	
	(unit = kelvin and: aTemperature unit = kelvin) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	(unit = kelvin and: aTemperature unit = celsius) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	(unit = kelvin and: aTemperature unit = fahrenheit) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	
	(unit = celsius and: aTemperature unit = celsius) ifTrue: [^self class withCelsius: (self asCelsius + aTemperature asCelsius)].
	(unit = celsius and: aTemperature unit = kelvin) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	(unit = celsius and: aTemperature unit = fahrenheit) ifTrue: [ ^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	
	(unit = fahrenheit and: aTemperature unit = kelvin) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	(unit = fahrenheit and: aTemperature unit = celsius) ifTrue: [^self class withKelvin: (self asKelvin + aTemperature asKelvin)].
	(unit = fahrenheit and: aTemperature unit = fahrenheit) ifTrue: [^self class withKelvin: (self asFahrenheit + aTemperature asFahrenheit)].! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:54:18'!
asCelsius
self unit = kelvin ifTrue:[^ (self amount - 273)].
self unit = fahrenheit ifTrue:[^(self amount -32)*5/9].
^self amount.! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:54:38'!
asFahrenheit

self unit = kelvin ifTrue:[^(self amount *9/5)-459.67].
self unit = celsius ifTrue:[^(self amount*9/5)+32].
^self amount.! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 17:48:09'!
asKelvin

	self unit = celsius ifTrue:[^ self amount + 273].
	self unit = fahrenheit ifTrue:[^(self amount + 459.67)*5/9].
	
	^ self amount! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 22:47:39'!
base

	^kelvin! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 16:12:47'!
convertTo: aUnit

	self checkCanConvertFrom: self unit to: aUnit.

	aUnit = kelvin ifTrue:[^self convertToKelvin].
	aUnit = celsius ifTrue:[^self convertToCelsius].
	aUnit = fahrenheit ifTrue:[^self convertToFahrenheit].! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:52:23'!
convertToCelsius

^Temperatura withCelsius: self asCelsius.
! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:52:48'!
convertToFahrenheit

	^Temperatura withFahrenheit: self asFahrenheit
! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:52:34'!
convertToKelvin

	^ Temperatura withKelvin: self asKelvin! !

!Temperatura methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 17:43:31'!
numberOfUnitsInBase

	^ self convertToKelvin asKelvin! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Temperatura class' category: #'Measures-Solution'!
Temperatura class
	instanceVariableNames: ''!

!Temperatura class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 17:29:02'!
withCelsius: aTemperature

	^Temperatura new initializeWithAmount: aTemperature withUnit: celsius! !

!Temperatura class methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 15:53:59'!
withFahrenheit: aTemperature

^Temperatura new initializeWithAmount: aTemperature withUnit: fahrenheit! !

!Temperatura class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 17:28:45'!
withKelvin: aTemperature

	aTemperature < 0 ifTrue:[^ self error: 'No se puede tener una temperatura negativa en kelvins'].
	
	^Temperatura new initializeWithAmount: aTemperature withUnit: kelvin! !


!classDefinition: #Tiempo category: #'Measures-Solution'!
Medida subclass: #Tiempo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Tiempo methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:04:19'!
base
	
	^second! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tiempo class' category: #'Measures-Solution'!
Tiempo class
	instanceVariableNames: ''!

!Tiempo class methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:40:55'!
initializeWithSeconds: aNumberOfSeconds

	^self new initializeWithAmount: aNumberOfSeconds withUnit: second! !


!classDefinition: #Volumen category: #'Measures-Solution'!
Medida subclass: #Volumen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Volumen methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:21:57'!
asLiters

	^numberOfUnits * unit factorToBase! !

!Volumen methodsFor: 'as yet unclassified' stamp: 'pR 6/4/2017 23:04:27'!
base

	^liter! !

!Volumen methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:21:16'!
numberOfUnitsInBase

	^self asLiters! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Volumen class' category: #'Measures-Solution'!
Volumen class
	instanceVariableNames: ''!

!Volumen class methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:30:40'!
initializeWithLiters: aVolume

	^self new initializeWithAmount: aVolume withUnit: liter! !


!classDefinition: #MedidaInterval category: #'Measures-Solution'!
Interval subclass: #MedidaInterval
	instanceVariableNames: 'myInterval step startingMeasure endingMeasure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!MedidaInterval methodsFor: 'accessing' stamp: 'pR 6/1/2017 21:06:50'!
by

	^step! !

!MedidaInterval methodsFor: 'accessing' stamp: 'pR 6/4/2017 22:40:56'!
do: aBlock

	^myInterval do: aBlock
! !

!MedidaInterval methodsFor: 'accessing' stamp: 'df 6/4/2017 16:25:46'!
from

	^startingMeasure! !

!MedidaInterval methodsFor: 'accessing' stamp: 'pR 6/4/2017 22:37:17'!
size

	^myInterval size 
! !

!MedidaInterval methodsFor: 'accessing' stamp: 'df 6/4/2017 16:25:58'!
to

	^endingMeasure! !


!MedidaInterval methodsFor: 'private' stamp: 'pR 6/4/2017 23:10:40'!
calculateDefaultStep: aStartingMeasure with: anEndingMeasure
	| minUnit |
	(aStartingMeasure unit factorToBase < anEndingMeasure unit factorToBase)
		ifTrue: [ minUnit := aStartingMeasure unit ] 
		ifFalse: [ minUnit := anEndingMeasure unit ].
	^Distancia initializeScaleLike: minUnit withNumberOfUnits: 1
	! !


!MedidaInterval methodsFor: 'enumerating' stamp: 'pR 6/4/2017 22:38:18'!
from: aStartingMeasure to: anEndingMeasure

	myInterval := Interval from: aStartingMeasure to: anEndingMeasure .
	startingMeasure := aStartingMeasure .
	endingMeasure := anEndingMeasure .
	step := self calculateDefaultStep: aStartingMeasure with: anEndingMeasure .! !

!MedidaInterval methodsFor: 'enumerating' stamp: 'pR 6/4/2017 22:38:25'!
from: aStartingMeasure to: anEndingMeasure by: aStepMeasure

	myInterval := Interval from: aStartingMeasure to: anEndingMeasure by: aStepMeasure .
	startingMeasure := aStartingMeasure .
	endingMeasure := anEndingMeasure .
	step := aStepMeasure .! !


!classDefinition: #MedidaTest category: #'Measures-Solution'!
TestCase subclass: #MedidaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:16:58'!
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

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:23:30'!
test02puedoSumarMedidasDelMismoTipo
	| unLitro dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	dosLitros := Volumen initializeWithLiters:2.

	self assert: unLitro + unLitro = dosLitros.
	self assert: unLitro + dosLitros = (dosLitros + unLitro )! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:24:10'!
test03puedoRestarMedidasDelMismoTipo
	| unLitro dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	dosLitros := Volumen initializeWithLiters:2.
	
	self assert:dosLitros - unLitro = unLitro! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:36:21'!
test04puedoMultiplicarUnNumeroPorUnaMedida
	| unLitro dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	dosLitros := Volumen initializeWithLiters:2.
	
	self assert: dosLitros  = (unLitro * 2).
	self assert: (2 * unLitro) = dosLitros.
	self assert: unLitro * 2 = (2*unLitro)! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:23:53'!
test05puedoDividirUnaMedidaPorUnNumero
	| unLitro dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	dosLitros := Volumen initializeWithLiters:2.

	self assert: unLitro = (dosLitros/2)! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:42:19'!
test06puedoCompararMedidasDeIgualTipo

	| unLitro dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	dosLitros := Volumen initializeWithLiters:2.

	self assert: unLitro = (dosLitros/2)! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 13:43:25'!
test07puedoCompararMedidasDeDistintoTipo

	| unLitro dosMetros |

	unLitro := Volumen initializeWithLiters: 1.
	dosMetros := Distancia initializeWithMeters:2.

	self deny: unLitro = dosMetros! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 15:03:41'!
test09soloPuedoDividirUnaMedidaPorNumerosOMedidas
	| unLitro |

	unLitro := Volumen initializeWithLiters: 1.
	
	self
		should: [ unLitro / 'algoQueNoEsUnaMedida' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: unLitro class canOnlyPerfermDivisionWithNumbersOrMeasures]! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 15:15:08'!
test10puedoConvertirEntreUnidadesQueMidenElMismoTipoDeMedida
	| unLitro cienCentilitros |

	unLitro := Volumen initializeWithAmount: 1 withUnit: liter.
	cienCentilitros := Volumen initializeWithAmount: 100 withUnit: centiliter.
	
	self assert: (unLitro convertTo: centiliter) = cienCentilitros.! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 15:26:09'!
test11soloPuedoConvertirEntreUnidadesQueMidenElMismoTipoDeMedida
	| unLitro |

	unLitro := Volumen initializeWithLiters: 1.
	
	self
		should: [ unLitro convertTo: meter ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: unLitro class canOnlyConvertBetweenUnitsOnSameMeasure]! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/3/2017 15:29:20'!
test12UnLitroEsDistintoQueUnMetro
	| unLitro unMetro |

	unLitro := Volumen initializeWithLiters: 1.
	unMetro := Distancia initializeWithMeters: 1.
	
	self deny: unLitro = unMetro.! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 16:33:43'!
test13puedoHacerUnIntervaloDeMedidas
	| unLitro diezLitros intervalLitro |

	unLitro := Volumen initializeWithLiters: 1.	diezLitros  := unLitro *10.
		intervalLitro :=unLitro to: diezLitros.
	
	self assert: intervalLitro size = 10
	
	! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'df 6/4/2017 17:35:35'!
test14puedoHacerUnIntervaloDeMedidasQueHagaAlgo
	| unLitro diezLitros intervalLitro totalSum |

	unLitro := Volumen initializeWithLiters: 1.	diezLitros  := unLitro *10.
		intervalLitro :=unLitro to: diezLitros.
	totalSum := 0.
	intervalLitro do: [ :each | totalSum := totalSum + each amount ].

	self assert: totalSum = 55.
	
	! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 09:46:52'!
test15puedoSumarMedidasDeDistintoTipo
	| unLitro unMetro |
	
	unLitro := Volumen initializeWithLiters: 1.
	unMetro := Distancia initializeWithMeters: 1.
	
	self assert: unLitro + unMetro = (unMetro + unLitro).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 19:08:51'!
test16puedoSumarMasDeDosMedidasDeDistintoTipo
	| unLitro unMetro unGradoCelsius |

	unLitro := Volumen initializeWithLiters: 1.
	unMetro := Distancia initializeWithMeters: 1.
	
	unGradoCelsius := Temperatura withCelsius: 1.
	
	self assert: unLitro + unMetro + unGradoCelsius = (unMetro + unLitro + unGradoCelsius).
	self assert: unLitro + unMetro + unGradoCelsius = (unMetro + unGradoCelsius + unLitro).
	self assert: unLitro + unMetro + unGradoCelsius = (unLitro + unMetro + unGradoCelsius).
	self assert: unLitro + unMetro + unGradoCelsius = (unLitro + unGradoCelsius + unMetro).
	self assert: unLitro + unMetro + unGradoCelsius = (unGradoCelsius + unMetro + unLitro).
	self assert: unLitro + unMetro + unGradoCelsius = (unGradoCelsius + unMetro + unLitro).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 09:58:25'!
test17medidasCompuestasEstanNormalizadas
	| unLitro unMetro dosLitros |

	unMetro := Distancia initializeWithMeters: 1.
	dosLitros := Volumen initializeWithLiters: 2.
	unLitro := Volumen initializeWithLiters: 1.
	
	self assert: unLitro + unMetro + unLitro = (dosLitros + unMetro).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 19:21:43'!
test18puedoRestarMasDeDosMedidasDeDistintoTipo
	| unLitro unMetro unGradoCelsius ceroLitros dosLitros |

	unLitro := Volumen initializeWithLiters: 1.
	ceroLitros := Volumen initializeWithLiters: 0.
	unMetro := Distancia initializeWithMeters: 1.
	unGradoCelsius := Temperatura withCelsius: 1.
	dosLitros := Volumen initializeWithLiters: 2.
	
	self assert: unLitro - unLitro = ceroLitros.
	self assert: dosLitros + unMetro = (unLitro + unLitro + unMetro).
	self assert: dosLitros + unMetro - unLitro = (unLitro + unMetro).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 19:21:58'!
test19puedoSumarYRestarCompuestas
	| unLitro unMetro unGradoCelsius dosLitros dosGradosCelsius |

	unLitro := Volumen initializeWithLiters: 1.
	unMetro := Distancia initializeWithMeters: 1.
	dosLitros := Volumen initializeWithLiters: 2.
	unGradoCelsius := Temperatura withCelsius: 1.
	dosGradosCelsius := Temperatura withCelsius: 2.
	
	self assert: unLitro + (unMetro + unLitro) = (dosLitros + unMetro).
	self assert: unMetro + unLitro - unMetro = unLitro.
	self assert: unLitro + (unMetro + unLitro - unMetro) = dosLitros.
	self assert: dosLitros - (unMetro + unLitro) = (unLitro - unMetro).
	self assert: dosLitros - (unMetro - unGradoCelsius) = (dosLitros - unMetro + unGradoCelsius).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:10:18'!
test20temperaturasDeDistintosTiposSeSumanYRestanOK
	| unLitro unMetro unGradoCelsius dosLitros dosGradosCelsius unGradoKelvin dosGradosKelvin |

	unLitro := Volumen initializeWithLiters: 1.
	unMetro := Distancia initializeWithMeters: 1.
	dosLitros := Volumen initializeWithLiters: 2.
	unGradoCelsius := Temperatura withCelsius: 1.
	dosGradosCelsius := Temperatura withCelsius: 2.
	unGradoKelvin := Temperatura withKelvin: 1.
	dosGradosKelvin := Temperatura withKelvin: 2.
	
	self assert: unGradoKelvin + unGradoKelvin = dosGradosKelvin.
	self assert: dosLitros - (unMetro + unLitro - unGradoCelsius) + unGradoCelsius = (unLitro - unMetro + dosGradosCelsius).! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 20:37:05'!
test21InicializacionDeMedidasConProducto
	| oneSecond tenMeters oneMeter |
	
	oneSecond := Tiempo initializeWithSeconds: 1.
	tenMeters := Distancia initializeWithMeters: 10.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self assert: (tenMeters * oneSecond) unit = (oneMeter * oneSecond) unit.
	self assert: (tenMeters * tenMeters * oneSecond) unit = (oneSecond * tenMeters * tenMeters) unit.
	
	self deny: (tenMeters * oneMeter) unit = (oneSecond * oneMeter) unit.
	self assert: (tenMeters * oneSecond) = (oneSecond * tenMeters).
! !

!MedidaTest methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 21:12:01'!
test22InicializacionDeMedidasConDivision
	| oneSecond tenMeters oneMeter |
	
	oneSecond := Tiempo initializeWithSeconds: 1.
	tenMeters := Distancia initializeWithMeters: 10.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self assert: (tenMeters / oneSecond * oneSecond) unit = (oneMeter) unit.
	self assert: (oneMeter * oneMeter / (oneSecond * oneMeter)) unit = (oneMeter * oneMeter / (oneMeter * oneSecond)) unit.
	self assert: (oneMeter * oneMeter / (oneSecond * oneMeter)) = (oneMeter * oneMeter / (oneMeter * oneSecond)).
	
	self assert: ((oneMeter / oneSecond) / (oneSecond / oneMeter)) unit = ((oneMeter * oneMeter) / (oneSecond * oneSecond)) unit.
	self assert: ((oneMeter / oneSecond) / (oneSecond / oneMeter)) = ((oneMeter * oneMeter) / (oneSecond * oneSecond)).! !


!classDefinition: #CompoundUnit category: #'Measures-Solution'!
Object subclass: #CompoundUnit
	instanceVariableNames: 'unitsNumerator unitsDenominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:55:43'!
= aCompoundUnit

	self class = aCompoundUnit class ifFalse: [^false].
	^unitsNumerator = aCompoundUnit unitsNumerator and: unitsDenominator = aCompoundUnit unitsDenominator! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:56:08'!
unitsDenominator

	^unitsDenominator! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:55:56'!
unitsNumerator

	^unitsNumerator! !

!CompoundUnit methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:49:19'!
withNumerator: aCompoundUnit withDenominator: anotherCompoundUnit

	unitsNumerator := aCompoundUnit.
	unitsDenominator := anotherCompoundUnit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measures-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'as yet unclassified' stamp: 'pR 6/6/2017 18:49:36'!
withNumerator: aCompoundUnit withDenominator: anotherCompoundUnit

	^self new withNumerator: aCompoundUnit withDenominator: anotherCompoundUnit! !


!classDefinition: #DistanceFactory category: #'Measures-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:02:35'!
minusOneMeter
	
	^Distancia initializeWithMeters: -1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:02:29'!
oneCentimeter
	
	^Distancia initializeWithCentimeters: 1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:02:24'!
oneHundredCentimeters
	
	^Distancia initializeWithCentimeters: 100! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:02:18'!
oneMeter
	
	^Distancia initializeWithMeters: 1! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:02:56'!
twoHundredCentimeters
	
	^Distancia initializeWithCentimeters: 200! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:03:15'!
twoMeters
	
	^Distancia initializeWithMeters: 2! !

!DistanceFactory methodsFor: 'as yet unclassified' stamp: 'pR 5/26/2017 21:03:26'!
zeroMeters
	
	^Distancia initializeWithMeters: 0! !


!classDefinition: #Unit category: #'Measures-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'factorToBase name measurableClass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measures-Solution'!

!Unit methodsFor: 'printing' stamp: 'pR 6/1/2017 19:43:06'!
printString

	^name! !


!Unit methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:45:26'!
factorToBase

	^factorToBase! !

!Unit methodsFor: 'accessing' stamp: 'pR 6/3/2017 15:23:29'!
measurableClass
	
	^measurableClass! !


!Unit methodsFor: 'initialization' stamp: 'pR 6/4/2017 22:49:26'!
withName: aString withConversionFactorToBase: aNumber withMeasurableClass: aClass
	name := aString.
	factorToBase := aNumber.
	measurableClass := aClass
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measures-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'class initialization' stamp: 'df 6/4/2017 16:55:48'!
setUp

	Smalltalk at:#gram put: (Unit withName:'gram'  withConversionFactorToBase: 1 withMeasurableClass: Peso).

	Smalltalk at:#meter put: (Unit withName:'meter'  withConversionFactorToBase: 1 withMeasurableClass: Distancia). 
	Smalltalk at:#decimeter put: (Unit withName:'decimeter'  withConversionFactorToBase: 1 / 10 withMeasurableClass: Distancia). 
	Smalltalk at:#centimeter put: (Unit withName:'centimeter'  withConversionFactorToBase: 1 / 100 withMeasurableClass: Distancia). 
	Smalltalk at:#milimeter put: (Unit withName:'milimeter'  withConversionFactorToBase: 1 / 1000 withMeasurableClass: Distancia).
	Smalltalk at:#decameter put: (Unit withName:'decameter'  withConversionFactorToBase: 10 withMeasurableClass: Distancia). 
	Smalltalk at:#hectometer put: (Unit withName:'hectometer'  withConversionFactorToBase: 100 withMeasurableClass: Distancia). 
	Smalltalk at:#kilometer put: (Unit withName:'kilometer'  withConversionFactorToBase: 1000 withMeasurableClass: Distancia).	

	Smalltalk at:#liter put: (Unit withName: 'liter'  withConversionFactorToBase: 1 withMeasurableClass: Volumen). 
	Smalltalk at:#deciliter put: (Unit withName:'deciliter'  withConversionFactorToBase: 1 / 10 withMeasurableClass: Volumen). 
	Smalltalk at:#centiliter put: (Unit withName:'centiliter'  withConversionFactorToBase: 1 / 100 withMeasurableClass: Volumen). 
	Smalltalk at:#mililiter put: (Unit withName:'mililiter'  withConversionFactorToBase: 1 / 1000 withMeasurableClass: Volumen).

	Smalltalk at:#decaliter put: (Unit withName:'decaliter'  withConversionFactorToBase: 10 withMeasurableClass: Volumen). 
	Smalltalk at:#hectoliter put: (Unit withName:'hectoliter'  withConversionFactorToBase: 100 withMeasurableClass: Volumen). 
	Smalltalk at:#kiloliter put: (Unit withName:'kiloliter'  withConversionFactorToBase: 1000 withMeasurableClass: Volumen).
	Smalltalk at:#second put: (Unit withName:'second'  withConversionFactorToBase: 1 withMeasurableClass: Tiempo).
	Smalltalk at:#minute put: (Unit withName:'minute'  withConversionFactorToBase: 60 withMeasurableClass: Tiempo).
	Smalltalk at:#hour put: (Unit withName:'hour'  withConversionFactorToBase: 60*60 withMeasurableClass: Tiempo).
	Smalltalk at:#day put: (Unit withName:'day'  withConversionFactorToBase: 60*60*24 withMeasurableClass: Tiempo).
	
	Smalltalk at:#kelvin put: (Unit withName:'kelvin'  withConversionFactorToBase: 1 withMeasurableClass: Temperatura).
	Smalltalk at:#celsius put: (Unit withName:'celsius'  withConversionFactorToBase: 1 withMeasurableClass: Temperatura).
	Smalltalk at:#fahrenheit put: (Unit withName:'fahrenheit'  withConversionFactorToBase: 1 withMeasurableClass: Temperatura).! !

!Unit class methodsFor: 'class initialization' stamp: 'pR 6/3/2017 15:24:35'!
withName: aString withConversionFactorToBase: aNumber withMeasurableClass: aClass

	^self new withName: aString withConversionFactorToBase: aNumber withMeasurableClass: aClass! !
