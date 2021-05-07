Class {
	#name : #PTLMatcherSubPattern,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'subPatterns'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'private-running' }
PTLMatcherSubPattern >> hasMatch: aValue withContext: aContext [

	^ subPatterns allSatisfy: [ :pattern |
		"use hasMatch instead ?" 
		  pattern match: aValue withContext: aContext ]
]

{ #category : #initialization }
PTLMatcherSubPattern >> initialize [
	super initialize.
	subPatterns := OrderedCollection new
]

{ #category : #accessor }
PTLMatcherSubPattern >> subPatterns: aCollection [
	subPatterns := aCollection
]
