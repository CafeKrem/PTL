Class {
	#name : #PTLMatcherString,
	#superclass : #PTLMatcherLiteralEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLMatcherString >> hasMatch: aValue withContext: aContext [

	^ (super hasMatch: aValue withContext: aContext) or: [ 
		  aValue isString
			  ifTrue: [ aValue beginsWithEmpty: value caseSensitive: true ]
			  ifFalse: [ false ] ]
]
