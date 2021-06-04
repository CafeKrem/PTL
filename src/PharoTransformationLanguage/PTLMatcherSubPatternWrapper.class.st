Class {
	#name : #PTLMatcherSubPatternWrapper,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'selector',
		'matcherModel'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #converting }
PTLMatcherSubPatternWrapper >> asSubPatternWrapper [
	^ self
]

{ #category : #'private-running' }
PTLMatcherSubPatternWrapper >> hasMatch: aValue withContext: aContext [

	| attributeTmp |
	^ selector
		  ifNil: [ 
			  (matcherModel match: aValue withContext: aContext) or: [ 
				  aValue children anySatisfy: [ :child | 
					  matcherModel match: child withContext: aContext ] ] ]
		  ifNotNil: [ 
			  attributeTmp := ([ 
			                   (aValue class slotNamed: selector) read: aValue ]
				                   on: Error
				                   do: [ aValue perform: selector ]) copy
				                  convertToCollection.
			  matcherModel match: attributeTmp withContext: aContext ]
]

{ #category : #accessor }
PTLMatcherSubPatternWrapper >> matcherModel [
	^ matcherModel
]

{ #category : #accessor }
PTLMatcherSubPatternWrapper >> matcherModel: aMatcher [
	matcherModel := aMatcher
]

{ #category : #accessor }
PTLMatcherSubPatternWrapper >> selector [
	^ selector
]

{ #category : #accessor }
PTLMatcherSubPatternWrapper >> selector: aString [
	selector := aString
]
