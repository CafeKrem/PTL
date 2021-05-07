Extension { #name : #Class }

{ #category : #'*PharoTransformationLanguage' }
Class >> asMatcher [
	^ PTLMatcherModelReference
		withClass: self
		withConfiguration: PTLMatcherSubPattern new
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
				ifTrue: [ PTLMatcherSubPattern new
						subPatterns: (anObject collect: [ :each | each asMatcher ]) asSubPatternWrapper;
						yourself ]
				ifFalse: [ PTLMatcherSubPattern new
						subPatterns: {anObject asMatcher asSubPatternWrapper};
						yourself ])
]
