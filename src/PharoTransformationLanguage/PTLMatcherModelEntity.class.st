Class {
	#name : #PTLMatcherModelEntity,
	#superclass : #Object,
	#instVars : [
		'next',
		'matchedNodes',
		'savedSelector',
		'previous'
	],
	#category : #'PharoTransformationLanguage-model'
}

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
	^ PTLMatcherSubPatternWrapper new
		matcherModel: self;
		yourself
]

{ #category : #util }
PTLMatcherModelEntity >> firstElementOf: aCollection [
	aCollection isString
		ifTrue: [ ^ aCollection ].
	aCollection isCollection
		ifTrue: [ aCollection first isCharacter
				ifTrue: [ ^ aCollection ]
				ifFalse: [ ^ aCollection first ] ].
	^ aCollection
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

{ #category : #testing }
PTLMatcherModelEntity >> isEllipsis [
	^ false
]

{ #category : #testing }
PTLMatcherModelEntity >> isJoker [
	^ false
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
	| aValue |
	aValue := self firstElementOf: aCollection.
	^ (self hasMatch: aValue withContext: aContext)
		ifTrue: [ aCollection isCollection
				ifTrue: [ aCollection first isCharacter
						ifTrue: [ aCollection removeAll: self value.
							self flag: #moveIt ]
						ifFalse: [ self save: (self pop: aCollection) inContext: aContext ] ]
				ifFalse: [ self save: (self pop: aCollection) inContext: aContext ].
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

{ #category : #accessor }
PTLMatcherModelEntity >> next: aMatcher [
	next := aMatcher
]

{ #category : #util }
PTLMatcherModelEntity >> pop: aCollection [
	^ aCollection isCollection
		ifTrue: [ aCollection removeFirst ]
		ifFalse: [ aCollection ]
]

{ #category : #accessor }
PTLMatcherModelEntity >> previous: aMatcher [
	previous := aMatcher
]

{ #category : #'private-running' }
PTLMatcherModelEntity >> save: aCollection inContext: aContext [
	^ savedSelector ifNotNil: [ 
		  aContext at: savedSelector put: aCollection ]
]

{ #category : #accessor }
PTLMatcherModelEntity >> savedSelector: aString [
	savedSelector := aString
]
