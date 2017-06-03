!classDefinition: #DistanceTest category: #'Distance-Exercise'!
TestCase subclass: #DistanceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Exercise'!

!DistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 15:04'!
test01ObjectsRepresentingSameDistanceShouldBeEqual

	self assert: self oneMeter = self oneMeter.
	self assert: self oneHundredCentimeters = self oneHundredCentimeters.
	

! !

!DistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 16:50'!
test02DiferentDistancesShouldNotBeEqual

	self deny: self oneMeter = self twoMeters.
	self deny: self twoMeters = self oneMeter! !

!DistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/18/2011 16:50'!
test03SameDistanceExpressWithDifferentUnitsShouldBeEqual

	self assert: self oneMeter = self oneHundredCentimeters.
	self assert: self twoMeters = self twoHundredCentimeters.

! !

!DistanceTest methodsFor: '1 - Test equality' stamp: 'HernanWilkinson 4/19/2011 10:28'!
test04EqualsShouldBeCommutative

	self assert: (self oneMeter = self oneHundredCentimeters and: [ self oneHundredCentimeters = self oneMeter ]).
	self assert: (self twoMeters = self twoHundredCentimeters and:  [ self twoHundredCentimeters = self twoMeters ]).

! !


!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:26'!
test05UnitStringRepresentationShouldBeHumanReadable

	self assert: self meter printString = 'meter'.
	self assert: self centimeter printString = 'centimeter'.
	self assert: self decimeter printString = 'decimeter'.
	self assert: self millimeter printString = 'milimeter'.
	self assert: self decameter printString = 'decameter'.
	self assert: self hectometer printString = 'hectometer'.
	self assert: self kilometer printString = 'kilometer'.	! !

!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:26'!
test06DistanceStringRepresentationShouldBeHumanReadable

	self assert: self oneMeter printString = '1 meter'.
	self assert: self twoMeter printString = '2 meters'.
	self assert: self oneHundredCentimeters printString = '100 centimeters'.
	
! !

!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:26'!
test07aDistanceAmountShouldBeTheExpectedAmount

	self assert: self oneMeter amount = 1.
	self assert: self twoMeters amount = 2.
	self assert: self oneHundredCentimeters amount = 100.
	self assert: self twoHundredCentimeters amount = 200.
! !

!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test07bDistanceUnitShouldBeTheExpectedUnit

	self assert: self oneMeter unit = self meter.
	self assert: self twoMeters unit = self meter.
	self assert: self oneHundredCentimeters unit = self centimeter.
	self assert: self twoHundredCentimeters unit = self centimeter.! !

!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HAW 4/19/2017 16:59:46'!
test07cDifferentDistanceUnitsShouldBeDifferent

	| units unitsSet |
	
	units := self distanceUnits.
	unitsSet := units asSet.
	
	self assert: units size equals: unitsSet size.
	self assert: (unitsSet includesAll: units).! !

!DistanceTest methodsFor: '2 - Converting/accesing/printing' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test07dDistancesCanBeConvertedToDifferentUnits

	"A partir de los test de igualdad, se deben haber dado cuenta que debemos poder
	convertir distancias a distintas unidades... y que ademas dos distancias de distintas unidades
	pueden ser iguales... Por lo tanto Â¿por quÃ© no hacer esta caracteristica de las distancias explicita?
	Veran que luego se torna muy util
	
	Respecto de como esta escrito el test, para no tener que escribir los assert para oneMeter y oneHundredCentimeters 
	creo un array y lo recorro... Â¿Se podria escribir menos aun en este test?
	
	Y por quÃ© se asserta sobre el amount y luego la unidad y no directametne sobre la distancia completa. ej:
	self assert: (aDistance converTo: self meter) = self oneMeter
	"
	
	(Array with: self oneMeter with: self oneHundredCentimeters) do: [ :aDistance |
		self assert: (aDistance convertTo: self meter) amount = 1.
		self assert: (aDistance convertTo: self meter) unit = self meter.
		
		self assert: (aDistance convertTo: self decimeter) amount = 10.
		self assert: (aDistance convertTo: self decimeter) unit = self decimeter.
		
		self assert: (aDistance convertTo: self centimeter) amount = 100.
		self assert: (aDistance convertTo: self centimeter) unit = self centimeter.
		
		self assert: (aDistance convertTo: self millimeter) amount = 1000.
		self assert: (aDistance convertTo: self millimeter) unit = self millimeter.
	
		self assert: (aDistance convertTo: self decameter) amount = (1/10).
		self assert: (aDistance convertTo: self decameter) unit = self decameter.
		
		self assert: (aDistance convertTo: self hectometer) amount = (1/100).
		self assert: (aDistance convertTo: self hectometer) unit = self hectometer.
	
		self assert: (aDistance convertTo: self kilometer) amount = (1/1000).
		self assert: (aDistance convertTo: self kilometer) unit = self kilometer ]! !


!DistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08aComparingDistancesWithOtherObjectsShouldReturnFalse

	"El igual no debe generar ningun tipo de error por mas que se comparen objetos
	de distintos tipos
	Fijense como se crea una instancia de Object sin ningun tipo de problema... Â¿quÃ© representa?"

	self deny: self oneMeter = Object new.
	self deny: Object new = self oneMeter! !

!DistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08bDistancesThatAreEqualShouldReturnTheSameHash

	"Debido a como funcionan los diccionarios, cuando dos objetos son iguales deben
	tener es mismo hash. La inversa no es verdad"
	
	self assert: self oneMeter hash=self oneMeter hash.
	self assert: self oneMeter hash=self oneHundredCentimeters hash.

	
	
! !

!DistanceTest methodsFor: '3 - Test equality - implementation details' stamp: 'HernanWilkinson 4/19/2011 10:27'!
test08cCopiesOfTheSameDistanceShouldBeEqual

	"Dos objetos que ocupan distintas posiciones de memoria pero representan
	la misma entidad de la realidad, deben devolver true cuando se los compara por igual, puesto
	que representan la misma entidad de la realidad.
	Por lo tanto, el mensaje #= significa 'Â¿representan el mismo ente de la realidad?'
	mientras que el mensaje #== significa Â¿ocupan la misma posicion de memoria?"

	| originalOneMeter copiedOneMeter |

	"Al objeto oneMeter lo copio para asegurarme de tener uno oneMeter en otra posicion de memoria"

	originalOneMeter := self oneMeter.
	copiedOneMeter := originalOneMeter copy.

	"Me aseguro que ocupen distinta posicion de memoria"
	self deny: originalOneMeter == copiedOneMeter.

	"Ahora me aseguro que sean iguales"
	self assert: originalOneMeter = copiedOneMeter! !


!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:34'!
test09AddingDistancesOfSameUnitShouldReturnADistanceRepresentingTheAddingDistances

	self assert: (self oneMeter + self oneMeter) = self twoMeters

! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:34'!
test10AddingDistancesOfDifferentUnitShouldReturnADistanceRepresentingTheAddingDistances

	self assert: (self oneMeter + self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneMeter + self oneHundredCentimeters) = self twoHundredCentimeters.

! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:35'!
test11AddingDistancesIsCommutative

	self assert: (self oneMeter + self twoMeters)=(self twoMeters + self oneMeter)


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:35'!
test12AddingDistancesIsAssociative

	self assert: 
		((self oneMeter + self oneMeter) + self twoMeters) = 
		(self oneMeter + (self oneMeter + self twoMeters))


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:41'!
test12aAddingDistancesKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter + oneMeter.
	
	self assert: oneMeter = self oneMeter.
	


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:36'!
test13aNegatingADistanceNegatesItsAmount

	self assert: self oneMeter negated = self minusOneMeter.
	
! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:36'!
test13bNegatingADistanceIsReflective

	self assert: self oneMeter negated negated=self oneMeter.
	
! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:38'!
test14SubtractingDistancesOfSameUnitShouldReturnADistanceRepresentingTheSubtractedDistances

	self assert: (self twoMeters - self oneMeter) = self oneMeter.
	self assert: (self oneMeter - self oneMeter) = self zeroMeters.
	self assert: (self oneMeter - self twoMeters) = self oneMeter negated
	

	! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:40'!
test15SubtractingDistancesOfDifferentUnitShouldReturnADistanceRepresentingTheSubtractedDistances

	self assert: (self twoMeters - self oneHundredCentimeters) = self oneMeter.
	self assert: (self oneMeter - self oneHundredCentimeters) = self zeroMeters.
	self assert: (self oneHundredCentimeters - self twoMeters) = self oneMeter negated
	

	! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:40'!
test16SubtractingDistancesIsAssociative

	self assert: 
		((self twoMeters - self oneMeter) - self oneMeter) = 
		(self twoMeters - (self oneMeter + self oneMeter)).

	

	! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:41'!
test16aSubtractingDistancesKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter - oneMeter.
	
	self assert: oneMeter = self oneMeter.
	


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:45'!
test17aDistancesCanBeMultiplyByAnInteger

	self assert: self oneMeter * 1 = self oneMeter.
	self assert: self oneMeter * 2 = self twoMeters.
	self assert: self oneMeter * 0 = self zeroMeters.
! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:46'!
test17bDistancesCanBeMultiplyByAFraction

	self assert: (self oneMeter * (2/3)) amount = (2/3).
	self assert: (self twoMeter * (2/3)) amount = (2 * (2/3)).
! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:46'!
test17cDistancesCanBeMultiplyByAFloat

	self assert: (self oneMeter * 2.5) amount = 2.5.
	self assert: (self twoMeter * 2.5) amount = (2 * 2.5).
! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:47'!
test18MultiplicationKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter * 2.
	
	self assert: oneMeter = self oneMeter.
	


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:48'!
test19aDistancesCanBeDividedByAnInteger

	self assert: (self oneMeter / 1) = self oneMeter.
	self assert: (self twoMeters / 2) = self oneMeter.


! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/21/2011 17:24'!
test19bDistancesCanBeDividedByAFraction

	self assert: (self twoMeters / (1/3)) amount = 6.




! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:49'!
test19cDistancesCanBeDividedByAFloat

	self assert: (self twoMeters / 2.5) amount = (2/2.5).




! !

!DistanceTest methodsFor: '4 - Test arithmetic operations' stamp: 'HernanWilkinson 4/18/2011 15:49'!
test20DivisionKeepsDistanceInmutability

	| oneMeter |
	
	oneMeter := self oneMeter.
	oneMeter / 2.
	
	self assert: oneMeter = self oneMeter.
	


! !


!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:11'!
test21DistancesProvideATotalOrder

	self assert: (self distancesExamples allSatisfy: [ :aDistance | aDistance < (aDistance + self oneMeter)])

! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:11'!
test22DistancesCanBeComparedWithGreaterThan

	self assert: (self distancesExamples allSatisfy: [ :aDistance | (aDistance + self oneMeter) > aDistance ])
! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:12'!
test23DistancesCanBeComparedWithLessThanOrEqual

	self assert: (self distancesExamples allSatisfy: [ :aDistance | aDistance <= aDistance and: [aDistance <= (aDistance + self oneMeter)]])

	
! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:13'!
test24DistancesCanBeComparedWithGreaterThanOrEqual

	self assert: (self distancesExamples allSatisfy: [ :aDistance | aDistance >= aDistance and: [(aDistance + self oneMeter) >= aDistance]])
! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:13'!
test25MaxReturnsTheMaximumBetweenTwoDistances

	self assert: (self twoMeters max: self oneMeter) = self twoMeters.
	self assert: (self oneMeter max: self twoMeters) = self twoMeters.

	self assert: (self twoMeters max: self oneHundredCentimeters) = self twoMeters.
	self assert: (self oneHundredCentimeters max: self twoMeters) = self twoMeters.

	
! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:14'!
test26MinReturnsTheMinimumBetweenTwoDistances

	self assert: (self twoMeters min: self oneMeter) = self oneMeter.
	self assert: (self oneMeter min: self twoMeters) = self oneMeter.

	self assert: (self twoMeters min: self oneHundredCentimeters) = self oneHundredCentimeters.
	self assert: (self oneHundredCentimeters min: self twoMeters) = self oneHundredCentimeters.

	
! !

!DistanceTest methodsFor: '5 - Test magnitude protocol' stamp: 'HernanWilkinson 4/18/2011 16:14'!
test27BetweenAndReturnsTrueIfADistanceIsBetweenOtherTwoDistances

	self assert: (self oneMeter between: self zeroMeters and: self twoMeters).
	self assert: (self oneHundredCentimeters between: self zeroMeters and: self twoMeters).
	
	self deny: (self twoMeters between: self zeroMeters and: self oneMeter).
	self deny: (self twoHundredCentimeters between: self zeroMeters and: self oneMeter).

! !


!DistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:16'!
test28IntervalOfDistancesCanBeCreatedBecauseTheyDefineATotalOrder

	self assert: (self oneMeter to: self twoMeters) from=self oneMeter.
	self assert: (self oneMeter to: self twoMeters) to=self twoMeters.
	self assert: (self oneMeter to: self twoMeters) by=self oneMeter.	

	self assert: (self oneHundredCentimeters to: self twoMeters) from=self oneMeter.
	self assert: (self oneHundredCentimeters to: self twoMeters) to=self twoMeters.
	self assert: (self oneHundredCentimeters to: self twoMeters) by=self oneCentimeter.	
	! !

!DistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:16'!
test29DistanceIntervalStepCanBeAnyDistance

	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) from=self zeroMeters.
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) to=(self twoMeters * 2).
	self assert: (self zeroMeters to: (self twoMeters * 2) by: self twoMeters) by=self twoMeters.

	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) from=(self twoMeters * 2).
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) to=self zeroMeters.
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self twoMeters negated) by=self twoMeters negated

	! !

!DistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:17'!
test30DistanceIntervalSizeReturnsTheNumberOfDistancesOfTheInterval

	self assert: (self zeroMeters to: (self twoMeters * 2) ) size =5.
	self assert: ((self twoMeters * 2) to: self zeroMeters by: self oneMeter negated) size =5.
! !

!DistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:19'!
test31DistanceIntervalCanBeEnumeratedUsingDo

	| value |
	
	value := 1.
	(self oneMeter to: (self oneMeter * 10)) do: [ :aDistance |
		self assert: aDistance amount = value.
		value := value + 1 ].
	
	self assert: value = 11
! !

!DistanceTest methodsFor: '6 - Test interval protocol' stamp: 'HernanWilkinson 4/18/2011 16:27'!
test32DistanceIntervalCanBeEnumeratedWithSpecificStep

	| value initialDistance byDistance finalDistance |
	
	initialDistance := self oneMeter.
	byDistance := self twoMeters.
	finalDistance := initialDistance * 9.
	value := initialDistance amount.
		
	(initialDistance to: finalDistance by:  byDistance) do: [ :aDistance |
		self assert: aDistance amount = value.
		value := value + byDistance amount ].
	
	self assert:  value = (finalDistance amount + byDistance amount)
! !


!DistanceTest methodsFor: 'distance units'!
centimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia centimetro'! !

!DistanceTest methodsFor: 'distance units'!
decameter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia decametro'! !

!DistanceTest methodsFor: 'distance units'!
decimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia decimetro'! !

!DistanceTest methodsFor: 'distance units' stamp: 'HAW 4/19/2017 16:46:07'!
distanceUnits 

	"¿Quién se anima a explicar cómo funciona este método? 
	¿Por qué está hecho así? "
		
	| unitsCategory unitsMessageNames |
	
	unitsCategory := self class organization categoryOfElement: thisContext method selector.
	unitsMessageNames := (self class organization listAtCategoryNamed:  unitsCategory) reject: [ :aMessageName | aMessageName = thisContext method selector ].
	
	 ^ unitsMessageNames collect: [ :aMessageName | self perform: aMessageName ]
	
! !

!DistanceTest methodsFor: 'distance units'!
hectometer
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia hectometro'! !

!DistanceTest methodsFor: 'distance units'!
kilometer
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia kilometro'! !

!DistanceTest methodsFor: 'distance units'!
meter

	self error: 'Este metodo debe devolver el objeto que la unidad de distancia metro'! !

!DistanceTest methodsFor: 'distance units'!
millimeter
	
	self error: 'Este metodo debe devolver el objeto que la unidad de distancia millimetro'! !


!DistanceTest methodsFor: 'distance measures' stamp: 'HernanWilkinson 4/18/2011 15:54'!
minusOneMeter 
	
	self error: 'Este metodo debe devolver un objeto que represente un metro'! !

!DistanceTest methodsFor: 'distance measures'!
oneCentimeter
	
	self error: 'Este metodo debe devolver un objeto que represente un centimetro'! !

!DistanceTest methodsFor: 'distance measures'!
oneHundredCentimeters
	
	self error: 'Este metodo debe devolver un objeto que represente cien centimetros'! !

!DistanceTest methodsFor: 'distance measures'!
oneMeter
	
	self error: 'Este metodo debe devolver un objeto que represente un metro'! !

!DistanceTest methodsFor: 'distance measures'!
twoHundredCentimeters
	
	self error: 'Este metodo debe devolver un objeto que represente doscientos centimetros'! !

!DistanceTest methodsFor: 'distance measures'!
twoMeters
	
	self error: 'Este metodo debe devolver un objeto que represente dos metros'! !

!DistanceTest methodsFor: 'distance measures'!
zeroMeters

	self error: 'Este metodo debe devolver un objeto que represente cero metros'! !
