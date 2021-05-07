Class {
	#name : #PTLJokerMatcher,
	#superclass : #PTLMatcherModelEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #transformationLanguage }
PTLJokerMatcher class >> asMatcher [
	^ self new
]

{ #category : #'as yet unclassified' }
PTLJokerMatcher >> hasMatch: aValue withContext: aContext [

	savedSelector ifNotNil: [ :selector | 
		(aContext at: selector) ifNotNil: [ :item | 
			^ item MTLequalsTo: (self firstElementOf: aValue) ] ].
	^ next
		  ifNil: [ 
			  previous ifNotNil: [ 
				  (previous isEllipsis or: [ previous isJoker ]) ifTrue: [ 
					  aValue size == 1 ifFalse: [ ^ false ] ] ].
			  true ]
		  ifNotNil: [ 
			  previous ifNotNil: [ 
				  (previous isEllipsis or: [ previous isJoker ]) ifTrue: [ 
					  self flag: #replaceByHasNext.
					  1 haltIf: [ (aValue isKindOf: OrderedCollection) not ].
					  ^ next
						    match: ("OrderedCollection newFrom:" aValue allButFirst)
						    withContext: aContext ] ].
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
