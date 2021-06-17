Extension { #name : #Association }

{ #category : #'*PharoTransformationLanguage' }
Association >> asMatcher [

	| path |
	path := self key asPTLPath.
	path matcherModel: self value asMatcher.

	self value = '@' ifTrue: [ path matcherModel named: self key ].
	^ path
]

{ #category : #'*PharoTransformationLanguage' }
Association >> named: aString [

	self value: (self value named: aString)
]

{ #category : #'*PharoTransformationLanguage' }
Association >> suchAs: aCollection [

	self value: (self value suchAs: aCollection)
]
