Class {
	#name : #PTLPath,
	#superclass : #Object,
	#instVars : [
		'path'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #'instance creation' }
PTLPath class >> from: aPathString [
	^ self new path: aPathString asSymbol
]

{ #category : #displaying }
PTLPath >> displayString [

	^ '{1}({2})' format: { 
			  super displayString.
			  path }
]

{ #category : #accessing }
PTLPath >> path [
	^ path
]

{ #category : #accessing }
PTLPath >> path: aString [ 
	path := aString
]

{ #category : #printing }
PTLPath >> printString [

	^ '{1}({2})' format: { 
			  super printString.
			  path }
]

{ #category : #accessing }
PTLPath >> resolveOn: anObject [
	^ [ (anObject class slotNamed: path) read: anObject ]
		                  on: Error
		                  do: [ 
			                  [ anObject perform: path ]
				                  on: Error
				                  do: [ 
					                  PTLSelectorNotDefined signal:
						                  ('class {1} does not understand the message {2}. Please look at your pattern maybe there is an error.' 
							                   format: { 
									                   anObject class name.
									                   path }) ] ].
]
