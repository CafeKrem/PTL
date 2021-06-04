Class {
	#name : #PTLEllipsisMatcher,
	#superclass : #PTLMatcherModelEntity,
	#category : #'PharoTransformationLanguage-model'
}

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
