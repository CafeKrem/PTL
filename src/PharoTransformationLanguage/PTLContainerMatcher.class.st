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

{ #category : #accessor }
PTLContainerMatcher >> element: aMatcher [

	elementMatcher := aMatcher
]

{ #category : #'private-running' }
PTLContainerMatcher >> hasMatch: aValue withContext: aContext [

	"return boolean , true if I can match with my argument aValue else false."

	^ aValue anySatisfy: [ :each | 
		  elementMatcher hasMatch: each withContext: aContext ]
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
