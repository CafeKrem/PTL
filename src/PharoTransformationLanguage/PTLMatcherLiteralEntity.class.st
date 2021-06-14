"
I'm an abstract class for Literal Matcher.

 
    Instance Variables
	value:		<Object>


    Implementation Points
"
Class {
	#name : #PTLMatcherLiteralEntity,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'value'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #testing }
PTLMatcherLiteralEntity class >> isAbstract [

	^ self = PTLMatcherLiteralEntity
]

{ #category : #'private-running' }
PTLMatcherLiteralEntity >> hasMatch: aValue withContext: aContext [

	| aFirstValue |
	aFirstValue := self firstElementOf: aValue.
	^ value = aFirstValue or: [ 
		  (aFirstValue class allSlots collect: [ :each | 
			   each read: aFirstValue ]) anySatisfy: [ :each | each = value ] ]
]

{ #category : #accessing }
PTLMatcherLiteralEntity >> value [
	^value 
]

{ #category : #accessing }
PTLMatcherLiteralEntity >> value: aLiteral [ 
	value := aLiteral
]
