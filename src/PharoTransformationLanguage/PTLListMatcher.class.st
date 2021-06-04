Class {
	#name : #PTLListMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'matcher'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLListMatcher >> match: aValue withContext: aContext [

	| isMatched matcherTmp tmpValue |
	tmpValue := aValue copy asOrderedCollection.
	matcherTmp := matcher.
	isMatched := matcherTmp match: tmpValue withContext: aContext.
	[ isMatched and: [ matcherTmp hasNext ] ] whileTrue: [ 
		isMatched := matcherTmp next
			             match: tmpValue
			             withContext: aContext.
		matcherTmp := matcherTmp next ].
	^ isMatched
]

{ #category : #accessor }
PTLListMatcher >> matcher: aMatcher [
	matcher := aMatcher
]
