Class {
	#name : #PTLMatcherResult,
	#superclass : #Object,
	#instVars : [
		'context',
		'isMatch'
	],
	#category : #'PharoTransformationLanguage-matcher'
}

{ #category : #accessing }
PTLMatcherResult >> at: aKey [
	^ [ context at: aKey ]
		on: Error
		do: [ nil ]
]

{ #category : #accessing }
PTLMatcherResult >> at: key put: aValue [
	context at: key put: aValue
]

{ #category : #accessor }
PTLMatcherResult >> context [
	^ context
]

{ #category : #initialization }
PTLMatcherResult >> initialize [
	super initialize.
	context := Dictionary new.
	isMatch := false
]

{ #category : #test }
PTLMatcherResult >> isMatch [
	^ isMatch
]

{ #category : #accessor }
PTLMatcherResult >> isMatch: aBoolean [ 
	isMatch := aBoolean
]

{ #category : #test }
PTLMatcherResult >> isPartialMatch [
	^ isMatch not and: [ context isNotEmpty ]
]

{ #category : #accessor }
PTLMatcherResult >> printString [
	^ '{1} ({2}, {3})'
		format:
			{super printString.
			isMatch asString.
			context asString}
]
