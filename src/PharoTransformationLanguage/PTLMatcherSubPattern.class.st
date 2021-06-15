"
I'm a util Object I'm used by matcherModelReference. 

I should not be use alone.


Internal Representation and Key Implementation Points.

    Instance Variables
	matcherModel:		<MatcherModelEntity> , it's contains a matcher.
	selector:		<Symbol> it's representing the name of an instanceVariable/class Variable or a method if IV or CV with selector dosn't exist.

"
Class {
	#name : #PTLMatcherSubPattern,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'selector',
		'matcherModel'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #converting }
PTLMatcherSubPattern >> asSubPatternWrapper [
	^ self
]

{ #category : #'private-running' }
PTLMatcherSubPattern >> hasMatch: aValue withContext: aContext [

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
PTLMatcherSubPattern >> matcherModel [
	^ matcherModel
]

{ #category : #accessor }
PTLMatcherSubPattern >> matcherModel: aMatcher [
	matcherModel := aMatcher
]

{ #category : #accessor }
PTLMatcherSubPattern >> selector [
	^ selector
]

{ #category : #accessor }
PTLMatcherSubPattern >> selector: aString [
	selector := aString
]
