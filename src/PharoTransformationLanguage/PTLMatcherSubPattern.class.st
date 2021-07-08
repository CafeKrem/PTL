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
		'matcherModel',
		'selectors'
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
	^ selectors
		  ifEmpty: [ 
			  (matcherModel match: aValue withContext: aContext) or: [ 
				  aValue children anySatisfy: [ :child | 
					  matcherModel match: child withContext: aContext ] ] ]
		  ifNotEmpty: [ 
			  attributeTmp := aValue.
			  selectors do: [ :eachSelector | 
				  attributeTmp := ([ 
				                   (attributeTmp class slotNamed:
					                    eachSelector asSymbol) read: attributeTmp ]
					                   on: Error
					                   do: [ 
						                   [ 
						                   attributeTmp perform: eachSelector asSymbol ]
							                   on: Error
							                   do: [ 
								                   ^ PTLSelectorNotDefined signal:
									                     'class ' , attributeTmp class name
									                     , 'don''t understand the message '
									                     , eachSelector , '.' , String cr
									                     ,
									                     'please look at your pattern maybe there is an error' ] ])
					                  copy convertToCollection ].

			  matcherModel match: attributeTmp withContext: aContext ]
]

{ #category : #initialization }
PTLMatcherSubPattern >> initialize [ 
	selectors := OrderedCollection new
]

{ #category : #PTL }
PTLMatcherSubPattern >> inspectPTLAction [

	^ { matcherModel }
]

{ #category : #'as yet unclassified' }
PTLMatcherSubPattern >> inspectPTLKey [

	^ '>' join: selectors
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

{ #category : #accessor }
PTLMatcherSubPattern >> selectors: aCollection [ 
	selectors addAll: aCollection
]
