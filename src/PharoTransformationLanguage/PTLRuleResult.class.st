Class {
	#name : #PTLRuleResult,
	#superclass : #Object,
	#instVars : [
		'isMatch',
		'result'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #accessor }
PTLRuleResult >> isMatch [
	^ isMatch
]

{ #category : #accessor }
PTLRuleResult >> isMatch: aBoolean [

	isMatch := aBoolean
]

{ #category : #accessor }
PTLRuleResult >> result [
	^ result
]

{ #category : #accessor }
PTLRuleResult >> result: anObject [

	result := anObject
]
