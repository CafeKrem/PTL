Class {
	#name : #PTLMatcherString,
	#superclass : #PTLMatcherLiteralEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLMatcherString >> hasMatch: aValue withContext: aContext [
	^ (super hasMatch: aValue withContext: aContext)
		or: [ (aValue isString or: [ aValue isCharacter ])
				ifTrue:
					[ aValue asString beginsWithEmpty: value asString caseSensitive: true ]
				ifFalse: [ aValue isCollection
						ifTrue: [ ('' join: aValue)
								beginsWithEmpty: value asString
								caseSensitive: true ]
						ifFalse: [ false ] ] ]
]

{ #category : #hook }
PTLMatcherString >> hookSaveAction: aValue withContext: aContext [

	(aValue isCollection and: [ aValue first isCharacter ])
		ifTrue: [ aValue removeAll: self value ]
		ifFalse: [ super hookSaveAction: aValue withContext: aContext ]
]
