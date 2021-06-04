Extension { #name : #Association }

{ #category : #'*PharoTransformationLanguage' }
Association >> asMatcher [

	| wrapper |
	wrapper := PTLMatcherSubPattern new
		           selector: self key;
		           matcherModel: self value asMatcher;
		           yourself.

	self value = '@' ifTrue: [ wrapper matcherModel named: self key ].
	^ wrapper
]

{ #category : #'*PharoTransformationLanguage' }
Association >> named: aString [

	self value: (self value named: aString)
]

{ #category : #'*PharoTransformationLanguage' }
Association >> suchAs: aCollection [

	self value: (self value suchAs: aCollection)
]
