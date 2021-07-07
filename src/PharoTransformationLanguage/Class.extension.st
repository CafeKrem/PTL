Extension { #name : #Class }

{ #category : #'*PharoTransformationLanguage' }
Class >> asMatcher [

	^ PTLMatcherModelReference
		  withClass: self
		  withConfiguration: OrderedCollection new
]

{ #category : #'*PharoTransformationLanguage' }
Class >> named: aString [

	^ self asMatcher
		  savedSelector: aString;
		  yourself
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: anObject [

	^ PTLMatcherModelReference
		  withClass: self
		  withConfiguration:
			  ((anObject isCollection and: [ anObject isString not ])
				   ifTrue: [ 
				   (anObject collect: [ :each | each asMatcher ])
					   asSubPatternWrapper ]
				   ifFalse: [ { anObject asMatcher asSubPatternWrapper } ])
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: aCollection like: aFullBlockClosure [

	^ (self suchAs: aCollection) like: aFullBlockClosure
]

{ #category : #'*PharoTransformationLanguage' }
Class >> unique [

	^ (PTLMatcherModelReference withClass: self withConfiguration: {  })
		  matchOnlyThisClass: true;
		  yourself
]
