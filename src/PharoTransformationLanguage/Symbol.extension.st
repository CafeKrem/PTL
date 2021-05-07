Extension { #name : #Symbol }

{ #category : #'*PharoTransformationLanguage' }
Symbol >> asMatcher [

	| first |
	first := self first.
	first = $* ifTrue: [ 
		^ self allButFirst
			  ifEmpty: [ PTLEllipsisMatcher new ]
			  ifNotEmpty: [ :name | PTLEllipsisMatcher new named: name ] ].
	first = $@ ifTrue: [ 
		^ self allButFirst
			  ifEmpty: [ PTLJokerMatcher new ]
			  ifNotEmpty: [ :name | PTLJokerMatcher new named: name ] ].
	first = $_ ifTrue: [ ^ PTLJokerMatcher new ].
	1 halt
]
