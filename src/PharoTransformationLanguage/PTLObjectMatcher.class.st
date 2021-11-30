Class {
	#name : #PTLObjectMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'class_',
		'pathToMatchers'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #instanciation }
PTLObjectMatcher class >> onClass: aClass [

	^ self new matchAgainstClass: aClass
]

{ #category : #instanciation }
PTLObjectMatcher class >> onClass: aClass withMatchers: aCollection [

	^ (self onClass: aClass)
		  updateMatchersWith: aCollection asDictionary;
		  yourself
]

{ #category : #initialization }
PTLObjectMatcher >> at: key putMatcher: matcher [
	pathToMatchers at: key put: matcher
]

{ #category : #'as yet unclassified' }
PTLObjectMatcher >> checkInnerMatching: aPath onInstance: instance inContext: context [

	| matcher attributeValue |
	matcher := pathToMatchers at: aPath.
	attributeValue := aPath resolveOn: instance.
	self flag: 'FIXME: remove copy of collections'.
	^ matcher
		  match: attributeValue copy convertToCollection
		  withContext: context
]

{ #category : #'as yet unclassified' }
PTLObjectMatcher >> compareValue: aValue [

	"matchOnlyThisClass ifTrue: [ ^ aValue class = class_ ]."
	^ aValue isKindOf: class_
]

{ #category : #'as yet unclassified' }
PTLObjectMatcher >> hasMatch: aValue withContext: aContext [

	| value |
	value := self firstElementOf: aValue.
	(self compareValue: value) ifFalse: [ ^ false ].
	pathToMatchers keysDo: [ :path | 
		(self checkInnerMatching: path onInstance: value inContext: aContext) 
			ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #initialization }
PTLObjectMatcher >> initialize [
	pathToMatchers := Dictionary new.
]

{ #category : #PTL }
PTLObjectMatcher >> inspectPTLAction [
	^ pathToMatchers 
]

{ #category : #PTL }
PTLObjectMatcher >> inspectPTLKey [
	^ class_ name
]

{ #category : #'private-running' }
PTLObjectMatcher >> match: aValue withContext: aContext [

	(super match: aValue withContext: aContext)
		ifTrue: [ 
			self flag: #tryToConnectToHook.
			^ self nacBlock valueWithArguments:
				  (self nacBlock argumentNames collect: [ :name | 
					   aContext at: name ]) ]
		ifFalse: [ ^ false ]
]

{ #category : #accessor }
PTLObjectMatcher >> matchAgainstClass: aClass [
	class_ := aClass
]

{ #category : #accesor }
PTLObjectMatcher >> nacBlock [

	^ nacBlock ifNil: [ nacBlock := [ true ] ]
]

{ #category : #initialization }
PTLObjectMatcher >> updateMatchersWith: aDictionaryOfMatchers [
	pathToMatchers addAll: aDictionaryOfMatchers 
]
