Class {
	#name : #PTLJokerMatcher,
	#superclass : #PTLMatcherModelEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #transformationLanguage }
PTLJokerMatcher class >> asMatcher [
	^ self new
]

{ #category : #'private-running' }
PTLJokerMatcher >> hasMatch: aValue withContext: aContext [

	aValue isCollection ifTrue: [ aValue isEmpty ifTrue: [ ^ false ] ].
	savedSelector ifNotNil: [ :selector | 
		(aContext at: selector) ifNotNil: [ :item | 
			^ item equalsToModel: (self firstElementOf: aValue) ] ].
	next
		ifNil: [ 
			previous ifNotNil: [ ^ previous jokerHasMatch: aValue ].
			^ true ]
		ifNotNil: [ 
			previous ifNotNil: [ 
				^ previous
					  jokerHasMatch: aValue
					  withNext: next
					  withContext: aContext ].
			^ true ]
]

{ #category : #testing }
PTLJokerMatcher >> isJoker [
	^ true
]

{ #category : #action }
PTLJokerMatcher >> jokerHasMatch: aValue [

	^ aValue size == 1
]

{ #category : #action }
PTLJokerMatcher >> jokerHasMatch: aValue withNext: aNext withContext: aContext [

	^ aNext hasMatch: aValue allButFirst withContext: aContext
]

{ #category : #'private-running' }
PTLJokerMatcher >> match: aValue withContext: aContext [
	^ (self hasMatch: aValue withContext: aContext)
		ifTrue: [ self save: (self pop: aValue) inContext: aContext.
			true ]
		ifFalse: [ false ]
]
