Class {
	#name : #PTLFunctionalBlock,
	#superclass : #Object,
	#instVars : [
		'matching',
		'prduction'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #running }
PTLFunctionalBlock >> evaluate: anObject [ 
	| result |
	result := matching match: anObject.
	result isMatch ifFalse: [ ^ false ].
	prduction valueWithDict: (result context)
]

{ #category : #accessor }
PTLFunctionalBlock >> matching: aMatcher [
	matching := aMatcher
]

{ #category : #acessor }
PTLFunctionalBlock >> production: aBlockClosure [ 
	prduction := aBlockClosure
]
