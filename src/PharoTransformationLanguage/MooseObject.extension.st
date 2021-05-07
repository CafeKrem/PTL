Extension { #name : #MooseObject }

{ #category : #'*PharoTransformationLanguage' }
MooseObject >> MTLequalsTo: aValue [
	| selfProperty |
	self class = aValue class
		ifFalse: [ ^ false ].
	selfProperty := (self class allSlots
		select: [ :each | each class = FMProperty ])
		reject: [ :each | each name = #startPos or: [ each name = #endPos ] ].
	(selfProperty
		allSatisfy:
			[ :each | (each read: self) = ((aValue class slotNamed: each name) read: aValue) ])
		ifFalse: [ ^ false ].
	(self children
		allSatisfy: [ :each | 
			aValue children
				detect: [ :valueChild | each MTLequalsTo: valueChild ]
				ifFound: [ true ]
				ifNone: [ false ] ])
		ifFalse: [ ^ false ].
	^ true
]
