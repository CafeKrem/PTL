Extension { #name : #Symbol }

{ #category : #'*PharoTransformationLanguage' }
Symbol >> asMatcher [

	| first fromTo |
	first := self first.
	first = $* ifTrue: [ 
		^ self allButFirst
			  ifEmpty: [ ^ PTLMatcherString value: first ]
			  ifNotEmpty: [ :name | 
				  self second = $_ ifTrue: [ ^ PTLEllipsisMatcher new ].
					name ifNil: [ ^ PTLMatcherString value: #* ].
				  PTLEllipsisMatcher new named: name ] ].
	first = $@ ifTrue: [ 
		^ self allButFirst
			  ifEmpty: [ PTLJokerMatcher new ]
			  ifNotEmpty: [ :name | PTLJokerMatcher new named: name ] ].
	first = $_ ifTrue: [ ^ PTLJokerMatcher new ].
	(self includesSubstring: '..') ifTrue: [ 
		fromTo := (self splitOn: '..') collect: #asInteger.
		^ PTLRangeMatcher from: (fromTo at: 1) to: (fromTo at: 2) ].
	^ super asMatcher
]
