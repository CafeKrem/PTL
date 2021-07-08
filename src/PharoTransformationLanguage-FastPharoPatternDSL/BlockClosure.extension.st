Extension { #name : #BlockClosure }

{ #category : #'*PharoTransformationLanguage-FastPharoPatternDSL' }
BlockClosure >> asFASTPharoMatcher [

	^ self sourceNode asFASTPharoMatcher
]
