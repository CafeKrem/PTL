"
I'm responsible of matching String.

I'm redefining hasMatch:withContext: because I can match substring of a string give in input.


```language=Pharo
	|pattern|
	  pattern := 'klm' named: #klm .
	(pattern match: 'klm') at: #klm. ""klm""
	
```
"
Class {
	#name : #PTLMatcherString,
	#superclass : #PTLMatcherLiteralEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #instantiation }
PTLMatcherString class >> value: aCharacter [

	^ self new
		  value: aCharacter;
		  yourself
]

{ #category : #'private-running' }
PTLMatcherString >> hasMatch: aValue withContext: aContext [
	^ (super hasMatch: aValue withContext: aContext)
		or: [(aValue isString or: [ aValue isCharacter ])
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
		ifTrue: [ 
		self save: (aValue removeAll: self value) inContext: aContext ]
		ifFalse: [ super hookSaveAction: aValue withContext: aContext ]
]
