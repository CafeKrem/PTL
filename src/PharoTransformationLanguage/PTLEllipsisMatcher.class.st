"
I'm Ellipses a matcher I'm equivalent to a kleen star.

while my next matcher has not match I will consume the input.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

see my super class public API.

examples

```language=Pharo
	|pattern|
   pattern := #'*klm'  asMatcher.
	(pattern match: 'jiop') at: #klm. ""'jiop'""
	
	  pattern :=  { 1 . 3 . 4  #'*klm'  } asMatcher.
	(pattern match: {1 . 3 . 4  }) at: #klm. ""OrderedCollection new""
	
```
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #PTLEllipsisMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'matchedNodes'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #testing }
PTLEllipsisMatcher >> isEllipsis [
	^ true
]

{ #category : #action }
PTLEllipsisMatcher >> jokerHasMatch: aValue [

	^ aValue size == 1
]

{ #category : #action }
PTLEllipsisMatcher >> jokerHasMatch: aValue withNext: aNext withContext: aContext [

	^ aNext hasMatch: aValue allButFirst withContext: aContext
]

{ #category : #'private-running' }
PTLEllipsisMatcher >> match: aValue withContext: aContext [
	| value isNextMatch |
	matchedNodes := OrderedCollection new.
	next
		ifNil: [ "I match all the collection because I'm the last."
			self save: aValue inContext: aContext.
			isNextMatch := true ]
		ifNotNil: [ [ aValue isEmpty
				or:
					[ isNextMatch := next hasMatch: aValue withContext: aContext ] ]
				whileFalse: [value := self pop: aValue.
					matchedNodes add: value ].
			self save: matchedNodes inContext: aContext ].
	^ isNextMatch
]

{ #category : #util }
PTLEllipsisMatcher >> pop: aValue [
	aValue isString
		ifTrue: [ ^ aValue ].
	aValue isCollection
		ifTrue: [ ^ aValue removeFirst ].
	^ aValue
]

{ #category : #'private-running' }
PTLEllipsisMatcher >> save: aValue inContext: aContext [

	savedSelector ifNotNil: [ 
		aValue isCollection ifTrue: [ 
			(aValue size == 1 and: [ aValue first isString ]) 
				ifTrue: [ ^ aContext at: savedSelector put: aValue first ].
			(aValue isNotEmpty and: [ aValue first isCharacter ]) 
				ifTrue: [ 
				^ aContext at: savedSelector put: ('' join: aValue) ] ].
		aContext at: savedSelector put: aValue ]
]
