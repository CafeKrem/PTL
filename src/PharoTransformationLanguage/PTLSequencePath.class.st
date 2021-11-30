Class {
	#name : #PTLSequencePath,
	#superclass : #PTLPath,
	#instVars : [
		'pathSequence'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'instance creation' }
PTLSequencePath class >> from: aString [

	| collection |
	collection := (aString splitOn: self navigationSymbol) collect: [ 
		              :subpath | subpath asPTLPath ].

	^ (super from: aString) pathSequence: collection
]

{ #category : #'instance creation' }
PTLSequencePath class >> navigationSymbol [
	^ #>
]

{ #category : #accessing }
PTLSequencePath >> pathSequence: anObject [

	pathSequence := anObject
]

{ #category : #accessing }
PTLSequencePath >> resolveOn: anObject [

	| tmpObject |
	tmpObject := anObject.
	pathSequence do: [ :subpath | 
		tmpObject := subpath resolveOn: tmpObject ].
	^ tmpObject
]
