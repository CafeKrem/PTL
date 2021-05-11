Class {
	#name : #PTLMatcherString,
	#superclass : #PTLMatcherLiteralEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLMatcherString >> hasMatch: aValue withContext: aContext [

	^ (super hasMatch: aValue withContext: aContext) or: [ 
		  (aValue isString or: [ aValue isCharacter ])
			  ifTrue: [ 
			  aValue asString
				  beginsWithEmpty: value asString
				  caseSensitive: true ]
			  ifFalse: [ false ] ]
]
