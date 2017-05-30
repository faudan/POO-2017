!classDefinition: #DistanciaInterval category: #'Distance-Solution'!
SequenceableCollection subclass: #DistanciaInterval
	instanceVariableNames: 'start end step intervalo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaInterval methodsFor: 'as yet unclassified' stamp: 'df 5/30/2017 01:14:50'!
do: aClosure

intervalo do:[:each | aClosure value: each ].! !

!DistanciaInterval methodsFor: 'as yet unclassified' stamp: 'df 5/30/2017 01:07:03'!
from: aStart to: anEnd by: aStep
	
	intervalo := Interval from:aStart to:anEnd by:aStep.! !

!DistanciaInterval methodsFor: 'as yet unclassified' stamp: 'df 5/30/2017 01:08:11'!
includes: aDistance

	intervalo do: [ :each | aDistance = each ifTrue:[^true]].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistanciaInterval class' category: #'Distance-Solution'!
DistanciaInterval class
	instanceVariableNames: ''!

!DistanciaInterval class methodsFor: 'as yet unclassified' stamp: 'df 5/30/2017 00:59:39'!
from: aStart to: anEnd by: aStep
	
	^ self new from: aStart to: anEnd by: aStep! !


!classDefinition: #DistanciaTest category: #'Distance-Solution'!
TestCase subclass: #DistanciaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanciaTest methodsFor: 'test initialization' stamp: 'pR 5/26/2017 14:09:47'!
test01InitializeDistanceOneMeter
	 
	self assert: (Distancia initializeWithMeters: 1) class = Distancia! !

!DistanciaTest methodsFor: 'test initialization' stamp: 'pR 5/26/2017 14:27:22'!
test05DistanceCanNotBeNegativeWithMinus1
	
	self
		should: [ Distancia initializeWithMeters: -1  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: 'prohibido crear distancias negativas']! !

!DistanciaTest methodsFor: 'test initialization' stamp: 'pR 5/26/2017 14:30:12'!
test06DistanceCanNotBeNegativeWithMinus2
	
	self
		should: [ Distancia initializeWithMeters: -2  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: 'prohibido crear distancias negativas']! !


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


!DistanciaTest methodsFor: 'test interval' stamp: 'df 5/30/2017 00:45:22'!
test23IntervalBetweenMetersWithStepsInMeters
	| anInterval oneMeter fourMeters totalSum |
	
	oneMeter := Distancia initializeWithMeters: 1.
	fourMeters := Distancia initializeWithMeters: 4.
	
	anInterval := oneMeter to: fourMeters.
	
	totalSum := 0.
	anInterval do: [ :each | totalSum := totalSum + each meters ].
	
	self assert: totalSum = 10.! !

!DistanciaTest methodsFor: 'test interval' stamp: 'df 5/30/2017 01:30:40'!
test24IntervalBetweenMetersWithStepsInCentimeters
	| oneMeter twoMeters oneCentimeter totalNumbersTraversed |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	oneCentimeter := Distancia initializeWithCentimeters: 1.
	
	
	
	totalNumbersTraversed := 0.	oneMeter to: twoMeters by: oneCentimeter do: [ :each | totalNumbersTraversed := totalNumbersTraversed + 1 ].
	
	self assert: totalNumbersTraversed = 101.! !

!DistanciaTest methodsFor: 'test interval' stamp: 'df 5/30/2017 01:09:50'!
test25IntervalBetweenAMeterAndThreeMetersIncludesTwoMeters
	| anInterval oneMeter twoMeters threeMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	twoMeters := Distancia initializeWithMeters: 2.
	threeMeters := Distancia initializeWithMeters: 3.
	
	anInterval := oneMeter to: threeMeters.
	

	
	self assert: (anInterval includes: twoMeters).! !

!DistanciaTest methodsFor: 'test interval' stamp: 'df 5/30/2017 01:17:08'!
test26IntervalBetweenAMeterAndThreeMetersDoesNotIncludeOneAndAHalfMeters
	| anInterval oneMeter threeMeters oneAndAHalfMeters |
	
	oneMeter := Distancia initializeWithMeters: 1.
	oneAndAHalfMeters := Distancia initializeWithMeters: 1.5.
	threeMeters := Distancia initializeWithMeters: 3.
	
	anInterval := oneMeter to: threeMeters.
	

	
	self deny: (anInterval includes: oneAndAHalfMeters ).! !


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


!classDefinition: #Distancia category: #'Distance-Solution'!
Object subclass: #Distancia
	instanceVariableNames: 'meters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distancia methodsFor: 'initialization' stamp: 'pR 5/26/2017 15:11:36'!
initializeScaleVsMetersLike: aScale withNumberOfUnits: aNumberOfUnits

	meters := aScale * aNumberOfUnits! !

!Distancia methodsFor: 'initialization' stamp: 'pR 5/26/2017 15:12:21'!
initializeWithMeters: aSmallInteger 
	
	self initializeScaleVsMetersLike: 1 withNumberOfUnits: aSmallInteger! !


!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 5/26/2017 14:33:59'!
* aSmallInteger 
	
	^Distancia initializeWithMeters: meters * aSmallInteger! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 5/26/2017 14:23:50'!
+ aDistancia 
	
	^Distancia initializeWithMeters: meters + aDistancia meters! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 5/26/2017 14:46:44'!
- aDistancia 
	
	^Distancia initializeWithMeters: meters - aDistancia meters.! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 5/26/2017 15:37:52'!
/ aSmallInteger 
	aSmallInteger class = Distancia ifTrue: [ ^meters / (aSmallInteger meters) ].
	^Distancia initializeWithMeters: meters / aSmallInteger! !

!Distancia methodsFor: 'arithmetic operations' stamp: 'pR 5/26/2017 14:37:57'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	
	^Distance initializeWithMeters: (aSmallInteger perform: aSymbol with: meters)! !


!Distancia methodsFor: 'comparing' stamp: 'pR 5/26/2017 15:02:03'!
< aDistancia 
	
	^meters < aDistancia meters! !

!Distancia methodsFor: 'comparing' stamp: 'pR 5/26/2017 15:01:26'!
<= aDistancia 
	
	^meters <= aDistancia meters! !

!Distancia methodsFor: 'comparing' stamp: 'pR 5/26/2017 14:17:40'!
= aDistancia

	^meters = aDistancia meters! !

!Distancia methodsFor: 'comparing' stamp: 'pR 5/26/2017 14:57:28'!
> aDistancia 
	
	^meters > aDistancia meters! !

!Distancia methodsFor: 'comparing' stamp: 'pR 5/26/2017 14:58:56'!
>= aDistancia 
	
	^meters >= aDistancia meters! !


!Distancia methodsFor: 'accessing' stamp: 'pR 5/26/2017 15:25:43'!
abs
	
	^meters! !

!Distancia methodsFor: 'accessing' stamp: 'pR 5/26/2017 15:28:14'!
isZero
	
	^meters = 0! !

!Distancia methodsFor: 'accessing' stamp: 'pR 5/26/2017 14:17:08'!
meters
	
	^meters! !


!Distancia methodsFor: 'intervalization' stamp: 'df 5/30/2017 01:47:30'!
to: aDistance

| unMetro |
unMetro := Distancia initializeWithMeters: 1.
^self to: aDistance by: unMetro.! !

!Distancia methodsFor: 'intervalization' stamp: 'df 5/30/2017 01:05:24'!
to: aDistance by: aStep

^DistanciaInterval from: self to: aDistance by: aStep.! !

!Distancia methodsFor: 'intervalization' stamp: 'df 5/30/2017 01:29:55'!
to: aDistance by: aStep do: aClosure

| anInterval |
anInterval := DistanciaInterval from: self to: aDistance by: aStep.

anInterval do: aClosure.! !

!Distancia methodsFor: 'intervalization' stamp: 'df 5/30/2017 01:33:25'!
to: aDistance do: aClosure

| unMetro |
unMetro := Distancia initializeWithMeters: 1.
self to: aDistance by: unMetro do: aClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distancia class' category: #'Distance-Solution'!
Distancia class
	instanceVariableNames: ''!

!Distancia class methodsFor: 'initialization' stamp: 'df 5/27/2017 21:17:08'!
withMeters: aSize
	^Distancia new withMeters: aSize! !


!Distancia class methodsFor: 'class initialization' stamp: 'pR 5/26/2017 15:15:01'!
initializeScaleVsMetersLike: aScale withNumberOfUnits: aNumberOfUnits

	self checkIsNotNegative: aNumberOfUnits.
	^self new initializeScaleVsMetersLike: aScale withNumberOfUnits: aNumberOfUnits! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 5/26/2017 15:14:26'!
initializeWithCentimeters: aSmallInteger 
	
	^self new initializeScaleVsMetersLike: 0.01 withNumberOfUnits: aSmallInteger
	! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 5/26/2017 15:16:39'!
initializeWithKilometers: aSmallInteger 
	
	^self new initializeScaleVsMetersLike: 1000 withNumberOfUnits: aSmallInteger! !

!Distancia class methodsFor: 'class initialization' stamp: 'pR 5/26/2017 15:14:53'!
initializeWithMeters: aSmallInteger 
	
	self checkIsNotNegative: aSmallInteger.
	^self new initializeScaleVsMetersLike: 1 withNumberOfUnits: aSmallInteger! !


!Distancia class methodsFor: 'error messages' stamp: 'pR 5/26/2017 14:29:45'!
canNotCreateNegativeDistanceErrorMessage
	
	^'prohibido crear distancias negativas'! !


!Distancia class methodsFor: 'checking' stamp: 'pR 5/26/2017 15:08:00'!
checkIsNotNegative: aSmallInteger

	aSmallInteger < 0 ifTrue: [^self error: self canNotCreateNegativeDistanceErrorMessage]! !
