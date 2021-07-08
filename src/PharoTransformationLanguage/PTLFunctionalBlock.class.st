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
	result isMatch ifFalse: [ 
		^ PTLRuleResult new
			  isMatch: false;
			  yourself ].

	^ PTLRuleResult new
		  isMatch: true;
		  result: (prduction valueWithDict: result context);
		  yourself
]

{ #category : #accessor }
PTLFunctionalBlock >> matching: aMatcher [
	matching := aMatcher
]

{ #category : #acessor }
PTLFunctionalBlock >> production: aBlockClosure [ 
	prduction := aBlockClosure
]
