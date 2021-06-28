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
	^ matchers detect: [ :eachMatcher |(eachMatcher match: anObject) isMatch ]
]

{ #category : #accessor }
PTLOrMatcher >> matchers: aCollection [
	matchers := aCollection
]
