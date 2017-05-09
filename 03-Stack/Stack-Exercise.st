!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'aStackedObject'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:53:40'!
isEmpty
	^aStackedObject size = 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:57:29'!
pop
	| poppedObject |
	poppedObject := aStackedObject content.
	aStackedObject := aStackedObject previous.
	^poppedObject
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:50:09'!
push: anObject
	aStackedObject := OOPushedObject withPrevious: aStackedObject withObject: anObject
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:59:24'!
size
	^aStackedObject size
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:58:44'!
top
	^aStackedObject content
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:43:04'!
withStackedObject: aNewStackedObject
	aStackedObject := aNewStackedObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'pR 5/8/2017 20:52:58'!
new
	^super new withStackedObject: OOStackBase new! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackedObject category: #'Stack-Exercise'!
Object subclass: #OOStackedObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:30:37'!
content
	^self subclassResponsibility! !

!OOStackedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:48:18'!
isEmpty
	^self size = 0! !

!OOStackedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:32:09'!
previous
	^self subclassResponsibility! !

!OOStackedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:30:22'!
size
	^self subclassResponsibility! !


!classDefinition: #OOPushedObject category: #'Stack-Exercise'!
OOStackedObject subclass: #OOPushedObject
	instanceVariableNames: 'content previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOPushedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:32:39'!
content
	^content! !

!OOPushedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:33:08'!
previous
	^previous! !

!OOPushedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:32:54'!
size
	^1 + previous size! !

!OOPushedObject methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:45:52'!
withPrevious: aStackedObject withObject: anObject
	previous := aStackedObject.
	content := anObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOPushedObject class' category: #'Stack-Exercise'!
OOPushedObject class
	instanceVariableNames: ''!

!OOPushedObject class methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:45:26'!
withPrevious: aStackedObject withObject: anObject
	^self new withPrevious: aStackedObject withObject: anObject! !


!classDefinition: #OOStackBase category: #'Stack-Exercise'!
OOStackedObject subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 21:16:09'!
content
	^Error new signal: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 21:16:21'!
pop
	^Error new signal: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 21:16:26'!
previous
	^Error new signal: OOStack stackEmptyErrorDescription! !

!OOStackBase methodsFor: 'as yet unclassified' stamp: 'pR 5/8/2017 20:31:36'!
size
	^0! !
