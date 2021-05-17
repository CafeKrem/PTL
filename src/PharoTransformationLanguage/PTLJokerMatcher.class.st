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
	^ next
		  ifNil: [ 
			  previous ifNotNil: [ 
				  (previous isEllipsis or: [ previous isJoker ]) ifTrue: [ 
					  aValue size == 1 ifFalse: [ ^ false ] ] ].
			  true ]
		  ifNotNil: [ 
			  previous ifNotNil: [ 
				  (previous isEllipsis or: [ previous isJoker ]) ifTrue: [ 
					  ^ next hasMatch: aValue allButFirst withContext: aContext ] ].
			  true ]
]

{ #category : #testing }
PTLJokerMatcher >> isJoker [
	^ true
]

{ #category : #'private-running' }
PTLJokerMatcher >> match: aCollection withContext: aContext [
	^ (self hasMatch: aCollection withContext: aContext)
		ifTrue: [ self save: (self pop: aCollection) inContext: aContext.
			true ]
		ifFalse: [ false ]
]
