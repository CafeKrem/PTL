Class {
	#name : #PTLContainerMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'elementMatcher'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #institation }
PTLContainerMatcher class >> element: anObject [

	^ self new
		  element: anObject asMatcher;
		  yourself
]

{ #category : #instantiation }
PTLContainerMatcher class >> elements: aCollection [

	^ self new
		  elements: (aCollection collect: #asMatcher);
		  yourself
]

{ #category : #accessor }
PTLContainerMatcher >> element: aMatcher [

	elementMatcher := aMatcher asOrderedCollection
]

{ #category : #accessor }
PTLContainerMatcher >> elements: aCollection [ 
	elementMatcher := aCollection  
]

{ #category : #'private-running' }
PTLContainerMatcher >> hasMatch: aValue withContext: aContext [

	"return boolean , true if I can match with my argument aValue else false."

	^ elementMatcher anySatisfy: [ :matcher | 
		  aValue anySatisfy: [ :each | 
			  matcher hasMatch: each withContext: aContext ] ]
]

{ #category : #'private-running' }
PTLContainerMatcher >> match: aValue withContext: aContext [

	aValue isEmpty ifTrue: [ ^ false ].

	^ (self hasMatch: aValue withContext: aContext)
		  ifTrue: [ 
			  self hookSaveAction: aValue withContext: aContext.
			  true ]
		  ifFalse: [ false ]
]
