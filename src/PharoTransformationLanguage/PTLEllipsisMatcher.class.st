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
	(pattern match: 'jiop') at: #klm. """"'jiop'""""
	
	  pattern :=  { 1 . 3 . 4  #'*klm'  } asMatcher.
	(pattern match: {1 . 3 . 4  }) at: #klm. """"OrderedCollection new""""
	
```
 
Internal Representation and Key Implementation Points.
    Implementation Points
"
Class {
	#name : #PTLEllipsisMatcher,
	#superclass : #PTLMatcherModelEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLEllipsisMatcher >> hasMatch: aCollection withContext: aContext [
	1 halt.
	"do nothing in this case"
]

{ #category : #testing }
PTLEllipsisMatcher >> isEllipsis [
	^ true
]

{ #category : #'private-running' }
PTLEllipsisMatcher >> match: aCollection withContext: aContext [

	| value isNextMatch |
	matchedNodes := OrderedCollection new.
	next
		ifNil: [ 
			self save: aCollection inContext: aContext.
			isNextMatch := true ]
		ifNotNil: [ 
			[ 
			aCollection isEmpty or: [ 
				isNextMatch := next hasMatch: aCollection withContext: aContext ] ] 
				whileFalse: [ 
					value := self pop: aCollection.
					matchedNodes add: value ].
			self save: matchedNodes inContext: aContext ].
	^ isNextMatch
]

{ #category : #'private-running' }
PTLEllipsisMatcher >> save: aCollection inContext: aContext [

	savedSelector ifNotNil: [ 
		aCollection isCollection ifTrue: [ 
			(aCollection size == 1 and: [ aCollection first isString ]) 
				ifTrue: [ ^ aContext at: savedSelector put: aCollection first ].
			(aCollection isEmpty not and: [ aCollection first isCharacter ]) 
				ifTrue: [ 
				^ aContext at: savedSelector put: ('' join: aCollection) ] ].
		aContext at: savedSelector put: aCollection ]
]
