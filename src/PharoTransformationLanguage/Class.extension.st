Extension { #name : #Class }

{ #category : #'*PharoTransformationLanguage' }
Class >> asMatcher [

	^ PTLObjectMatcher
		  onClass: self
]

{ #category : #'*PharoTransformationLanguage' }
Class >> named: aString [

	^ self asMatcher
		  savedSelector: aString;
		  yourself
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: anAssociationArray [

	^ PTLObjectMatcher
		  onClass: self
		  withMatchers:
		  (anAssociationArray do: [ :entry |
					entry key: entry key asPTLPath.
			   entry value: entry value asMatcher ])
]

{ #category : #'*PharoTransformationLanguage' }
Class >> suchAs: aCollection like: aFullBlockClosure [

	^ (self suchAs: aCollection) like: aFullBlockClosure
]

{ #category : #'*PharoTransformationLanguage' }
Class >> unique [

	^ (PTLObjectMatcher onClass: self)
]
