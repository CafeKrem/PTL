Class {
	#name : #PTLMatcherLiteralEntity,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'value'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLMatcherLiteralEntity >> hasMatch: aValue withContext: aContext [

	^ value = aValue or: [ 
		  (aValue class allSlots collect: [ :each | each read: aValue ]) 
			  anySatisfy: [ :each | each = value ] ]
]

{ #category : #accessing }
PTLMatcherLiteralEntity >> value [
	^value 
]

{ #category : #accessing }
PTLMatcherLiteralEntity >> value: anInteger [ 
	value := anInteger
]
