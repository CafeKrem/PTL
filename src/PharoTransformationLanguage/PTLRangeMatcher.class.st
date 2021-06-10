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
		from: lower;
		to: upper;
		yourself
]

{ #category : #accessor }
PTLRangeMatcher >> from: anInteger [ 
	from := anInteger
]

{ #category : #'private-running' }
PTLRangeMatcher >> hasMatch: anInteger withContext: aPTLMatcherResult [
	^ from <= anInteger and: [ anInteger <= to ]
]

{ #category : #accessor }
PTLRangeMatcher >> to: anInteger [ 
	to := anInteger
]
