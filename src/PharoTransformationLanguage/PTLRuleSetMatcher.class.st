Class {
	#name : #PTLRuleSetMatcher,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#category : #PharoTransformationLanguage
}

{ #category : #API }
PTLRuleSetMatcher >> evaluate: anObject [

	| result |
	rules do: [ :eachRule | 
		result := eachRule evaluate: anObject.
		result isMatch ifTrue: [ ^ result result ] ].
	Error signal: 'no rule executed.'
]

{ #category : #accessor }
PTLRuleSetMatcher >> rules: aCollection [

	rules := aCollection
]
