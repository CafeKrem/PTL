Extension { #name : #String }

{ #category : #'*PharoTransformationLanguage' }
String >> asMatcher [
	^ PTLMatcherString new
		value: self;
		yourself
]

{ #category : #'*PharoTransformationLanguage' }
String >> asPTLPath [

	(self includes: $>) ifTrue: [ ^ PTLSequencePath from: self ].
	^ PTLPath from: self
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
