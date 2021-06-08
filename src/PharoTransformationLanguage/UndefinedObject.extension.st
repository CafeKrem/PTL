Extension { #name : #UndefinedObject }

{ #category : #'*PharoTransformationLanguage' }
UndefinedObject >> jokerHasMatch: aRBLiteralValueNode [

	^ true
]

{ #category : #'*PharoTransformationLanguage' }
UndefinedObject >> jokerHasMatch: aCollection withNext: aPTLEllipsisMatcher withContext: aPTLMatcherResult [ 
	^ true
]
