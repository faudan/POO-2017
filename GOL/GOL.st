!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 20:59:58'!
test06CreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'pR 5/16/2017 17:41:21'!
test07DeadCellWithMoreThanThreeAliveNeighDoesNotResurect

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: {  0@0. 1@0. 0@1. 2@0.  } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'pR 5/16/2017 17:42:34'!
test08DeadCellWithTwoAliveNeighStaysDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: {  0@0. 1@0. } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'pR 5/16/2017 17:42:24'!
test09DeadCellWithOneAliveNeighStaysDead

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: {  0@0.  } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'initialization' stamp: 'pR 5/12/2017 11:42:30'!
initializeWith: aSetOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aSetOfAliveCells.! !


!GameOfLife methodsFor: 'evaluating' stamp: 'pR 5/12/2017 10:29:07'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) >= 3! !

!GameOfLife methodsFor: 'evaluating' stamp: 'pR 5/12/2017 11:28:41'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !


!GameOfLife methodsFor: 'accessing' stamp: 'pR 5/12/2017 11:49:05'!
deadCellsBorderingAliveCells
	
	| deadCells |
	deadCells := Set new.
	aliveCells do: [:anAliveCell | deadCells := deadCells union: (self neighborsInBoundOf: anAliveCell) ].
	deadCells := deadCells select: [:eachCell | self isDeadAt: eachCell].
	^deadCells	! !

!GameOfLife methodsFor: 'accessing' stamp: 'pR 5/12/2017 10:51:54'!
isAliveAt: aCell

	^aliveCells includes: aCell! !

!GameOfLife methodsFor: 'accessing' stamp: 'pR 5/16/2017 17:31:54'!
isDeadAt: aCell

	^(self isAliveAt: aCell) not! !

!GameOfLife methodsFor: 'accessing' stamp: 'pR 5/12/2017 11:46:13'!
neighborsInBoundOf: anAliveCell
	
	^(anAliveCell eightNeighbors select: [:eachCell | self inBounds: eachCell]) ! !

!GameOfLife methodsFor: 'accessing' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !


!GameOfLife methodsFor: 'inspecting' stamp: 'pR 5/12/2017 11:28:22'!
inBounds: aCell
	^(aCell x between: 0 and: size x) and: [ aCell y between: 0 and: size y]! !


!GameOfLife methodsFor: 'stepping' stamp: 'pR 5/12/2017 11:38:06'!
nextGeneration
	
	aliveCells := (aliveCells select: [ :aCell | self hasToSurvive: aCell ]) union:
		(self deadCellsBorderingAliveCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'pR 5/12/2017 11:41:57'!
withLiveCells: aSetOfAliveCells withSize: aPoint 
	
	(aSetOfAliveCells allSatisfy: [:aCell | (aCell x between: 0 and: aPoint x) and: [ aCell y between: 0 and: aPoint y]] ) 
		ifFalse: [ self error: 'celda fuera de rango' ].

	^self new initializeWith: aSetOfAliveCells withSize: aPoint ! !
