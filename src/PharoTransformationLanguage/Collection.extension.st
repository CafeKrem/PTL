Extension { #name : #Collection }

{ #category : #'*PharoTransformationLanguage' }
Collection >> asMatcher [
	| tmp first |
	tmp := self collect: [ :each | each asMatcher ].
	first := tmp first.
	tmp allButFirst
		do: [ :each | 
			first next: each.
			each previous: first.
			first := each ].
	^ PTLListMatcher new
		matcher: tmp first;
		yourself
]

{ #category : #'*PharoTransformationLanguage' }
Collection >> asSubPatternWrapper [
	^ self collect: [ :each | each asSubPatternWrapper ]
]

{ #category : #'*PharoTransformationLanguage' }
Collection >> convertToCollection [
	^ self asOrderedCollection 
]

{ #category : #'*PharoTransformationLanguage' }
Collection >> isContained [

	^ PTLContainerMatcher elements: self
]
