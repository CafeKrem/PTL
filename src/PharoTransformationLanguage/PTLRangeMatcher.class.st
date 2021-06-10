Class {
	#name : #PTLRangeMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'from',
		'to'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #accessor }
PTLRangeMatcher class >> from: lower to: upper [
	^ self new
		from: lower asMatcher;
		to: upper asMatcher;
		yourself
]

{ #category : #accessor }
PTLRangeMatcher >> from: anInteger [ 
	from := anInteger
]

{ #category : #'private-running' }
PTLRangeMatcher >> hasMatch: anInteger withContext: aContext [
	| value |
	value := self firstElementOf: anInteger.
	^ (from rangeMatch: value withContext: aContext) <= value
		and: [ value <= (to rangeMatch: value withContext: aContext) ]
]

{ #category : #accessor }
PTLRangeMatcher >> to: anInteger [ 
	to := anInteger
]
