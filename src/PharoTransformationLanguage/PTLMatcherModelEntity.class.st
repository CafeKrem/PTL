"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

I'm an abstract class , I define commun behavior for pattern. and I defined an API.


For the Collaborators Part: State my main collaborators and one line about how I interact with them. 


my private API's are:

* #match:withContext: , I'm returning a boolean if I can match my input.
* #hasMatch:withContext:  , I'm abtract my subclasses have to define a method , I'm returning a boolean if I can match my input with eating my input.
* #save:inContext: , I responsible of eating my input. 

my public API are: 

* named: , I'm putting a selector in order to save at this selector with the context if I match.
* like: 
* match: , I'm the entry point for matching.
 
for examples see my subclasses documentations or look at tests.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	nacBlock:		<Block>
	next:		<Matcher>
	previous:		<Matcher>
	savedSelector:		<Symbol>


    Implementation Points
"
Class {
	#name : #PTLMatcherModelEntity,
	#superclass : #Object,
	#instVars : [
		'next',
		'savedSelector',
		'previous',
		'nacBlock'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #testing }
PTLMatcherModelEntity class >> isAbstract [

	^ self = PTLMatcherModelEntity
]

{ #category : #visitor }
PTLMatcherModelEntity >> accept: aVisitor [

	^ aVisitor visitSubPattern: self
]

{ #category : #visiting }
PTLMatcherModelEntity >> acceptVisitor: aVisitor [
	^ self subclassResponsibility
]

{ #category : #converting }
PTLMatcherModelEntity >> asMatcher [
	^ self
]

{ #category : #converting }
PTLMatcherModelEntity >> asSubPatternWrapper [
	^ PTLMatcherSubPattern new
		matcherModel: self;
		yourself
]

{ #category : #util }
PTLMatcherModelEntity >> firstElementOf: aValue [
	aValue isString
		ifTrue: [^ aValue ].
	aValue isCollection
		ifTrue: [ 
			aValue isEmpty ifTrue: [ ^ {  } ].
			aValue first isCharacter
				ifTrue: [ ^ aValue ]
				ifFalse: [ ^ aValue first ] ].
	^ aValue
]

{ #category : #'private-running' }
PTLMatcherModelEntity >> hasMatch: aValue withContext: aContext [
	"return boolean , true if I can match with my argument aValue else false."
	^ self subclassResponsibility.
]

{ #category : #'private-running' }
PTLMatcherModelEntity >> hasNext [
	^ next isNotNil
]

{ #category : #hook }
PTLMatcherModelEntity >> hookSaveAction: aValue withContext: aContext [

	"you can overide me to add specific verification. for saving in context your matched value."

	self save: (self pop: aValue) inContext: aContext
]

{ #category : #testing }
PTLMatcherModelEntity >> isEllipsis [
	^ false
]

{ #category : #testing }
PTLMatcherModelEntity >> isJoker [
	^ false
]

{ #category : #action }
PTLMatcherModelEntity >> jokerHasMatch: aValue [

	^ true
]

{ #category : #testing }
PTLMatcherModelEntity >> jokerHasMatch: aValue withNext: aNext withContext: aContext [

	^ true
]

{ #category : #transformationLanguage }
PTLMatcherModelEntity >> like: aFullBlockClosure [ 
	nacBlock := aFullBlockClosure
]

{ #category : #'API-matchRuning' }
PTLMatcherModelEntity >> match: aValue [

	| matcherResult |
	matcherResult := PTLMatcherResult new.
	matcherResult isMatch: (self
			 match: aValue asOrderedCollection
			 withContext: matcherResult).
	^ matcherResult
]

{ #category : #'private-running' }
PTLMatcherModelEntity >> match: aCollection withContext: aContext [

	"I'm defining a commun behavior for every matcher"

	| value |
	aCollection isCollection ifTrue: [ aCollection ifEmpty: [ ^ false ] ].
	value := self firstElementOf: aCollection.
	^ (self hasMatch: value withContext: aContext)
		  ifTrue: [ 
			  self hookSaveAction: aCollection withContext: aContext.
			  true ]
		  ifFalse: [ false ]
]

{ #category : #'API-patternDSL' }
PTLMatcherModelEntity >> named: aString [ 
	self savedSelector: aString 
]

{ #category : #accessing }
PTLMatcherModelEntity >> next [
	^ next
]

{ #category : #accessing }
PTLMatcherModelEntity >> next: aMatcher [
	next := aMatcher
]

{ #category : #util }
PTLMatcherModelEntity >> pop: aValue [
	aValue isString
		ifTrue: [ ^ aValue ].
	aValue isCollection
		ifTrue: [ aValue first isCharacter
				ifTrue: [ ^ aValue ]
				ifFalse: [ ^ aValue removeFirst ] ].
	^ aValue
]

{ #category : #accessing }
PTLMatcherModelEntity >> previous: aMatcher [
	previous := aMatcher
]

{ #category : #'private-running' }
PTLMatcherModelEntity >> save: aValue inContext: aContext [
	savedSelector
		ifNotNil: [ aValue isCollection
				ifTrue: [ aValue first isCharacter
						ifTrue: [ ^ aContext at: savedSelector put: ('' join: aValue) ] ].
			^ aContext at: savedSelector put: aValue ]
]

{ #category : #accessing }
PTLMatcherModelEntity >> savedSelector: aSymbol [
	savedSelector := aSymbol
]
