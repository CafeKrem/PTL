Extension { #name : #String }

{ #category : #'*PharoTransformationLanguage' }
String >> asMatcher [
	^ PTLMatcherString new
		value: self;
		yourself
]

{ #category : #'*PharoTransformationLanguage' }
String >> isContained [

	^ PTLContainerMatcher element: self
]

{ #category : #'*PharoTransformationLanguage' }
String >> named: aString [
	^ self asMatcher
		savedSelector: aString;
		yourself
]
