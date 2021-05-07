Extension { #name : #Number }

{ #category : #'*PharoTransformationLanguage' }
Number >> asMatcher [
	^ PTLMatcherInteger new
		value: self;
		yourself
]

{ #category : #'*PharoTransformationLanguage' }
Number >> named: aString [
	^ self asMatcher
		savedSelector: aString;
		yourself
]
