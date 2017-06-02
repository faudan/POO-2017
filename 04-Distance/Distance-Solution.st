!classDefinition: #Distancia category: #'Distance-Solution'!
Magnitude subclass: #Distancia
	instanceVariableNames: 'numberOfUnits unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distancia methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:59:13'!
initializeScaleLike: aUnit withNumberOfUnits: aNumberOfUnits

	numberOfUnits := aNumberOfUnits.
	unit := aUnit.! !

!Distancia methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:55:26'!
initializeWithMeters: aSmallInteger 
	
	^self initializeScaleLike: meter withNumberOfUnits: aSmallInteger! !


!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:01:27'!
* aSmallInteger 
	
	^Distancia initializeWithMeters: self meters * aSmallInteger! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 19:59:59'!
+ aDistancia 
	
	^Distancia initializeWithMeters: self meters + aDistancia meters! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:01:13'!
- aDistancia 
	
	^Distancia initializeWithMeters: self meters - aDistancia meters.! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:39:11'!
/ aSmallInteger 

	aSmallInteger class = Distancia ifTrue: [ ^self meters / (aSmallInteger meters) ].
	^Distancia initializeWithMeters: self meters / aSmallInteger! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:55:54'!
abs
	
	^self meters abs! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:01:32'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^Distance initializeWithMeters: (aSmallInteger perform: aSymbol with: self meters)! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 6/1/2017 20:39:36'!
negated

	^Distancia initializeWithMeters: -1 * (self meters)! !


!Distancia methodsFor: 'comparing' stamp: 'pR 6/1/2017 20:01:41'!
< aDistancia 
	
	^self meters < aDistancia meters! !

!Distancia methodsFor: 'comparing' stamp: 'pR 6/1/2017 20:31:05'!
= aDistancia 

	(aDistancia isKindOf: self class) ifFalse: [^false].
	^self meters = aDistancia meters! !


!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 20:16:33'!
amount
	
	^numberOfUnits! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:49:30'!
asMeters
	
	^numberOfUnits * unit factorToBase! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 19:49:43'!
meters
	
	^self asMeters! !

!Distancia methodsFor: 'accessing' stamp: 'pR 6/1/2017 20:17:02'!
unit
	
	^unit! !


!Distancia methodsFor: 'printing' stamp: 'pR 6/1/2017 20:15:56'!
printString
	
	numberOfUnits = 1 ifTrue: [ ^numberOfUnits asString, ' ', unit printString ].
	^numberOfUnits asString, ' ', unit printString, 's'! !


!Distancia methodsFor: 'converting' stamp: 'pR 6/1/2017 20:29:22'!
convertTo: aUnit

	^Distancia initializeScaleLike: aUnit withNumberOfUnits: self meters / aUnit factorToBase 
! !

!Distancia methodsFor: 'converting' stamp: 'pR 6/1/2017 20:37:38'!
hash

	^{'Distancia' . self meters} hash
! !


!Distancia methodsFor: 'intervalization' stamp: 'pR 6/1/2017 20:49:47'!
to: aDistancia

	^DistanciaInterval new from: self to: aDistancia! !

!Distancia methodsFor: 'intervalization' stamp: 'pR 6/1/2017 21:18:43'!
to: anEndingDistancia by: aStep

	^DistanciaInterval new from: self to: anEndingDistancia by: aStep! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Distance-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'initialization' stamp: 'pR 6/1/2017 19:56:44'!
withMeters: aSize

	^Distancia new withMeters: aSize! !


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




!classDefinition: #DistanciaInterval category: #'Distance-Solution'!
Interval subclass: #DistanciaInterval
	instanceVariableNames: 'myInterval startingDistance endingDistance step'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaInterval methodsFor: 'accessing' stamp: 'pR 6/1/2017 21:06:50'!
by

	^step! !

!DistanciaInterval methodsFor: 'accessing' stamp: 'pR 6/1/2017 21:06:21'!
from

	^startingDistance! !

!DistanciaInterval methodsFor: 'accessing' stamp: 'pR 6/1/2017 21:25:00'!
size

	^myInterval size
! !

!DistanciaInterval methodsFor: 'accessing' stamp: 'pR 6/1/2017 21:06:28'!
to

	^endingDistance! !


!DistanciaInterval methodsFor: 'private' stamp: 'pR 6/1/2017 21:17:13'!
calculateDefaultStep: aStartingDistance with: anEndingDistance
	| minUnit |
	
	(aStartingDistance unit factorToBase < anEndingDistance unit factorToBase)
		ifTrue: [ minUnit := aStartingDistance unit ] 
		ifFalse: [ minUnit := anEndingDistance unit ].

	^Distancia initializeScaleLike: minUnit withNumberOfUnits: 1
	
	! !


!DistanciaInterval methodsFor: 'enumerating' stamp: 'pR 6/2/2017 13:57:36'!
do: aBlock

	^myInterval do: aBlock! !

!DistanciaInterval methodsFor: 'enumerating' stamp: 'pR 6/1/2017 21:08:30'!
from: aStartingDistance to: anEndingDistance

	myInterval := Interval from: aStartingDistance to: anEndingDistance.
	startingDistance := aStartingDistance.
	endingDistance := anEndingDistance.
	step := self calculateDefaultStep: aStartingDistance with: anEndingDistance! !

!DistanciaInterval methodsFor: 'enumerating' stamp: 'pR 6/2/2017 15:49:23'!
from: aStartingDistance to: anEndingDistance by: aStepDistance

	myInterval := Interval from: aStartingDistance to: anEndingDistance by: aStepDistance.
	startingDistance := aStartingDistance.
	endingDistance := anEndingDistance.
	step := aStepDistance.! !


!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaTest methodsFor: 'test initialization' stamp: 'pR 5/26/2017 14:09:47'!
test01InitializeDistanceOneMeter
	 
	self assert: (Distancia initializeWithMeters: 1) class = Distancia! !


!DistanciaTest methodsFor: 'test arithmetic operation +' stamp: 'pR 5/26/2017 14:12:13'!
test02OneMeterPlusOneMeterEqualsTwoMeters
	| oneMeter twoMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	
	self assert: (oneMeter + oneMeter) = twoMeters.! !

!DistanciaTest methodsFor: 'test arithmetic operation +' stamp: 'pR 5/26/2017 14:23:16'!
test04OneMeterPlusTwoMetersEqualThreeMeters
	| oneMeter twoMeters threeMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	threeMeters := Distancia initializeWithMeters: 3.
	
	self assert: (oneMeter + twoMeters) = threeMeters! !


!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:16:03'!
test03OneMeterDoesNotEqualTwoMeters
	| oneMeter twoMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	
	self deny: oneMeter = twoMeters.! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:48:33'!
test15OneMeterEqualsOneHundredCentimeters
	| oneMeter oneHundredCentimeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	oneHundredCentimeters := Distancia initializeWithCentimeters: 100.
	
	self assert: oneMeter = oneHundredCentimeters! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:50:34'!
test16OneAndAHalfMetersEqualsOneHundredAnfFiftyCentimeters
	| oneAndAHalfMeters oneHundredAndFiftyCentimeters |
	
	oneAndAHalfMeters := Distancia initializeWithMeters: 3 / 2.
	oneHundredAndFiftyCentimeters := Distancia initializeWithCentimeters: 150.
	
	self assert: oneAndAHalfMeters = oneHundredAndFiftyCentimeters! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:53:38'!
test17OneKilometerGreaterThanFiveHundredMeters
	| oneKilometer fiveHundredMeters |
	
	oneKilometer := Distancia initializeWithKilometers: 1.
	fiveHundredMeters := Distancia initializeWithMeters: 500.
	
	self assert: oneKilometer > fiveHundredMeters! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:57:13'!
test19OneCentimeterNotGreaterThanOneMeter
	| oneCentimeter oneMeter |
	
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self deny: oneCentimeter > oneMeter! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 14:59:09'!
test20OneCentimeterGreaterOrEqualThanOneCentimeter
	| oneCentimeter |
	
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	
	self assert: oneCentimeter >= oneCentimeter! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 15:00:47'!
test21OneCentimeterLessThanOrEqualThanOneMeter
	| oneCentimeter oneMeter |
	
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self assert: oneCentimeter <= oneMeter! !

!DistanciaTest methodsFor: 'test comparing' stamp: 'pR 5/26/2017 15:02:20'!
test22OneCentimeterLessThanOneMeter
	| oneCentimeter oneMeter |
	
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self assert: oneCentimeter < oneMeter! !


!DistanciaTest methodsFor: 'test arithmetic operation *' stamp: 'pR 5/26/2017 14:32:24'!
test07MultiplyDistance1MeterTimesNumberThreeGivesThreeMeters
	| oneMeter threeMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	threeMeters := Distancia initializeWithMeters: 3.
	
	self assert: oneMeter * 3 = threeMeters.! !

!DistanciaTest methodsFor: 'test arithmetic operation *' stamp: 'pR 5/26/2017 14:35:20'!
test08MultiplyDistance1MeterTimesNumberTwoGivesTwoMeters
	| oneMeter twoMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	
	self assert: oneMeter * 2 = twoMeters.! !

!DistanciaTest methodsFor: 'test arithmetic operation *' stamp: 'pR 5/26/2017 14:35:45'!
test09MultiplyNumberThreeTimesDistance1MeterTimesGivesThreeMeters
	| oneMeter threeMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	threeMeters := Distancia initializeWithMeters: 3.
	
	self assert: 3 * oneMeter = threeMeters.! !

!DistanciaTest methodsFor: 'test arithmetic operation *' stamp: 'pR 5/26/2017 14:37:35'!
test10MultiplyNumberTwoTimesDistance1MeterTimesGivesTwoMeters
	| oneMeter twoMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	
	self assert: 2 * oneMeter = twoMeters.! !

!DistanciaTest methodsFor: 'test arithmetic operation *' stamp: 'pR 5/26/2017 14:55:11'!
test18OneKilometerEqualsTwoTimesFiveHundredMeters
	| oneKilometer fiveHundredMeters |
	
	oneKilometer := Distancia initializeWithKilometers: 1.
	fiveHundredMeters := Distancia initializeWithMeters: 500.
	
	self assert: (2 * fiveHundredMeters) = oneKilometer! !


!DistanciaTest methodsFor: 'test arithmetic operation /' stamp: 'pR 5/26/2017 14:40:14'!
test11FourMetersDividedByNumberTwoEqualsTwoMeters
	| fourMeters twoMeters |
	
	fourMeters := Distancia initializeWithMeters: 4.
	twoMeters := Distancia initializeWithMeters: 2.
	
	self assert: fourMeters / 2 = twoMeters! !

!DistanciaTest methodsFor: 'test arithmetic operation /' stamp: 'pR 5/26/2017 14:42:44'!
test12FourMetersDividedByNumberEightEqualsHalfAMeter
	| fourMeters halfMeter |
	
	fourMeters := Distancia initializeWithMeters: 4.
	halfMeter := Distancia initializeWithMeters: 1 / 2.
	
	self assert: fourMeters / 8 = halfMeter! !


!DistanciaTest methodsFor: 'test arithmetic operation -' stamp: 'pR 5/26/2017 14:44:37'!
test13FourMetersMinusTwoMetersEqualTwoMeters
	| fourMeters twoMeters |
	
	fourMeters := Distancia initializeWithMeters: 4.
	twoMeters := Distancia initializeWithMeters:  2.
	
	self assert: fourMeters - twoMeters = twoMeters! !

!DistanciaTest methodsFor: 'test arithmetic operation -' stamp: 'pR 5/26/2017 14:46:05'!
test14FourMetersMinusThreeMetersEqualOneMeters
	| fourMeters threeMeters oneMeter |
	
	fourMeters := Distancia initializeWithMeters: 4.
	threeMeters := Distancia initializeWithMeters:  3.
	oneMeter := Distancia initializeWithMeters: 1.
	
	self assert: fourMeters - threeMeters = oneMeter! !


!DistanciaTest methodsFor: 'test interval' stamp: 'pR 5/26/2017 15:47:57'!
test23IntervalBetweenMetersWithStepsInMeters
	| anInterval oneMeter fourMeters totalSum |
	
	oneMeter := Distancia initializeWithMeters: 1.
	fourMeters := Distancia initializeWithMeters: 4.
	
	anInterval := Interval from: oneMeter to: fourMeters by: oneMeter.
	
	totalSum := 0.
	anInterval do: [ :each | totalSum := totalSum + each meters ].
	
	self assert: totalSum = 10.! !

!DistanciaTest methodsFor: 'test interval' stamp: 'pR 5/26/2017 15:48:12'!
test24IntervalBetweenMetersWithStepsInCentimeters
	| anInterval oneMeter twoMeters oneCentimeter totalNumbersTraversed |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	
	anInterval := Interval from: oneMeter to: twoMeters by: oneCentimeter.
	
	totalNumbersTraversed := 0.
	anInterval do: [ :each | totalNumbersTraversed := totalNumbersTraversed + 1 ].
	
	self assert: totalNumbersTraversed = 101.! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

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


!classDefinition: #Unit category: #'Distance-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'factorToBase name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

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

!classDefinition: 'Unit class' category: #'Distance-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'pR 6/1/2017 19:36:41'!
withName: aString withConversionFactorToBase: aNumber

	^self new withName: aString withConversionFactorToBase: aNumber! !
