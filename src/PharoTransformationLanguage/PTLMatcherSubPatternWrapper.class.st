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

{ #category : #actions }
PTLMatcherSubPatternWrapper >> convert: attributeTmp [

	attributeTmp isString ifTrue: [ 
		attributeTmp size == 1
			ifTrue: [ ^ OrderedCollection newFrom: attributeTmp ]
			ifFalse: [ ^ attributeTmp ] ].
	attributeTmp isCollection not
		ifTrue: [ ^ attributeTmp ]
		ifFalse: [ ^ OrderedCollection newFrom: attributeTmp ]
	"(attributeTmp isString or: [ attributeTmp isCollection not ])
		ifTrue: [ 
			attributeTmp size == 1
				ifTrue: [ ^ OrderedCollection newFrom: attributeTmp ]
				ifFalse: [ ^ attributeTmp ] ]
		ifFalse: [ ^ OrderedCollection newFrom: attributeTmp ]"
]

{ #category : #'private-running' }
PTLMatcherSubPatternWrapper >> hasMatch: aValue withContext: aContext [

	| attributeTmp |
	self flag: #warning.
	^ selector
		  ifNil: [ 
			  (matcherModel match: aValue withContext: aContext) or: [ 
				  aValue children anySatisfy: [ :child | 
					  matcherModel match: child withContext: aContext ] ] ]
		  ifNotNil: [ 
			  attributeTmp := [ 
			                  (aValue class slotNamed: selector) read: aValue ]
				                  on: Error
				                  do: [ aValue perform: selector ] copy.
			  self flag: #toClean.
			  attributeTmp := self convert: attributeTmp.

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
