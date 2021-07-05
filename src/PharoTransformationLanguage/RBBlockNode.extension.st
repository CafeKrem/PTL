Extension { #name : #RBBlockNode }

{ #category : #'*PharoTransformationLanguage' }
RBBlockNode >> asFASTPharoMatcher [

	^ self body acceptVisitor: PTLFastPharoPatternDSL new
]
