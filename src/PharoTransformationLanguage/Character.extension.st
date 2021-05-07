Extension { #name : #Character }

{ #category : #'*PharoTransformationLanguage' }
Character >> asMatcher [
	^ self = $*
		ifTrue: [ PTLEllipsisMatcher new ]
		ifFalse: [ self halt ]
]

{ #category : #'*PharoTransformationLanguage' }
Character >> named: aString [
	^ self asMatcher savedSelector: aString
]
