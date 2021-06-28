Class {
	#name : #PTLOrMatcher,
	#superclass : #Object,
	#instVars : [
		'matchers'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #functionalAPI }
PTLOrMatcher >> => aBlockClosure [ 
	^ PTLFunctionalBlock new matching: self ; production: aBlockClosure ; yourself 
]

{ #category : #match }
PTLOrMatcher >> match: anObject [
	| result |
	matchers
		do: [ :eachMatcher | 
			result := eachMatcher match: anObject.
			result isMatch
				ifTrue: [ ^ result ] ].
	^ PTLMatcherResult new
		isMatch: false;
		yourself
]

{ #category : #accessor }
PTLOrMatcher >> matchers: aCollection [
	matchers := aCollection
]
