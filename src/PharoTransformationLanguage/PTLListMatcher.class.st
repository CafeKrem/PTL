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
	tmpCollection := aCollection copy.
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

{ #category : #'private-running' }
PTLListMatcher >> templateMatch: aCollection withContext: aContext [
	| isMatched |
	1 halt.
	isMatched := matcher match: aCollection withContext: aContext.
	[ isMatched and: [ next hasNext ] ]
		whileTrue: [ isMatched := matcher next match: aCollection withContext: aContext.
			matcher := matcher next ].
	^ isMatched
]
