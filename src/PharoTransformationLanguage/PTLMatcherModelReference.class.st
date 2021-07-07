"
I'm a matcher for any Object I'm containing the class of the Object and a description of it.

example: 


```language=Pharo
	|pattern|
	  pattern := RBSequenceNode suchAs:
		           { (#statements -> (RBReturnNode named: #klm)) }
			           asMatcher.
	((pattern match: [^ 15] sourceNode) at: #klm) value. ""15""
	
```

    Instance Variables
	configuration:		<PTLMatcherSubPattern> , it will contains the description of the object that want to match.
	modelDescription:	<Class> , the description of the object that we want to match.


"
Class {
	#name : #PTLMatcherModelReference,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'modelDescription',
		'configuration',
		'matchOnlyThisClass'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #instanciation }
PTLMatcherModelReference class >> withClass: aClass withConfiguration: aCollection [
	^ self new
		modelDescription: aClass;
		configuration: aCollection;
		yourself
]

{ #category : #'as yet unclassified' }
PTLMatcherModelReference >> compareValue: aValue [

	matchOnlyThisClass ifTrue: [ ^ aValue class = modelDescription ].
	^ aValue isKindOf: modelDescription
]

{ #category : #accessor }
PTLMatcherModelReference >> configuration [
	^ configuration
]

{ #category : #accessor }
PTLMatcherModelReference >> configuration: aCollection [
	configuration := aCollection
]

{ #category : #'as yet unclassified' }
PTLMatcherModelReference >> hasMatch: aValue withContext: aContext [

	| value |
	value := self firstElementOf: aValue.(value isKindOf: modelDescription).

	^ (self compareValue: value)
		  ifTrue: [ 
			  configuration allSatisfy: [ :pattern | 
				  pattern match: value withContext: aContext ] ]
		  ifFalse: [ false ]
]

{ #category : #initialization }
PTLMatcherModelReference >> initialize [

	matchOnlyThisClass := false
]

{ #category : #PTL }
PTLMatcherModelReference >> inspectPTLAction [
	^ self configuration 
]

{ #category : #PTL }
PTLMatcherModelReference >> inspectPTLKey [
	^ modelDescription name
]

{ #category : #'as yet unclassified' }
PTLMatcherModelReference >> inspectionPattern [

	<inspectorPresentationOrder: 0 title: 'Pattern'>
	| collectionMatcher |
	collectionMatcher := { self }.
	^ SpTreePresenter new
		  roots: collectionMatcher;
		  children: [ :aClass | aClass inspectPTLAction ];
		  display: [ :aClass | aClass inspectPTLKey ];
		  expandRoots;
		  yourself
]

{ #category : #'private-running' }
PTLMatcherModelReference >> match: aValue withContext: aContext [

	(super match: aValue withContext: aContext)
		ifTrue: [ 
			self flag: #tryToConnectToHook.
			^ self nacBlock valueWithArguments:
				  (self nacBlock argumentNames collect: [ :name | 
					   aContext at: name ]) ]
		ifFalse: [ ^ false ]
]

{ #category : #configuration }
PTLMatcherModelReference >> matchOnlyThisClass: aBoolean [

	matchOnlyThisClass := aBoolean
]

{ #category : #accessor }
PTLMatcherModelReference >> modelDescription: aClass [
	modelDescription := aClass
]

{ #category : #accesor }
PTLMatcherModelReference >> nacBlock [

	^ nacBlock ifNil: [ nacBlock := [ true ] ]
]

{ #category : #toString }
PTLMatcherModelReference >> toString [
	^ modelDescription name
]
