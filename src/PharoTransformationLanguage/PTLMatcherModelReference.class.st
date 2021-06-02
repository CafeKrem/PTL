Class {
	#name : #PTLMatcherModelReference,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'modelDescription',
		'configuration'
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
	value := self firstElementOf: aValue.
	^ (value isKindOf: modelDescription)
		ifTrue: [ configuration match: value withContext: aContext ]
		ifFalse: [ false ]
]

{ #category : #'private-running' }
PTLMatcherModelReference >> match: aValue withContext: aContext [

	(super match: aValue withContext: aContext)
		ifTrue: [ 
			^ self nacBlock valueWithArguments:
				  (self nacBlock argumentNames collect: [ :name | 
					   aContext at: name ]) ]
		ifFalse: [ ^ false ]
]

{ #category : #accessor }
PTLMatcherModelReference >> modelDescription: aClass [
	modelDescription := aClass
]

{ #category : #accesor }
PTLMatcherModelReference >> nacBlock [

	^ nacBlock ifNil: [ nacBlock := [ true ] ]
]
