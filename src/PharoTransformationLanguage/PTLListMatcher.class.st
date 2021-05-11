Class {
	#name : #PTLListMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'matcher'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLListMatcher >> match: aCollection withContext: aContext [

	| isMatched matcherTmp tmpCollection |
	tmpCollection := aCollection copy asOrderedCollection.
	matcherTmp := matcher.
	isMatched := matcherTmp match: tmpCollection withContext: aContext.
	[ isMatched and: [ matcherTmp hasNext ] ] whileTrue: [ 
		isMatched := matcherTmp next
			             match: tmpCollection
			             withContext: aContext.
		matcherTmp := matcherTmp next ].
	^ isMatched
]

{ #category : #accessor }
PTLListMatcher >> matcher: aMatcher [
	matcher := aMatcher
]
