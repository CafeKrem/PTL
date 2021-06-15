Class {
	#name : #PTLVisuealisationPattern,
	#superclass : #PTLMatcherModelVisitor,
	#instVars : [
		'memory',
		'visu'
	],
	#category : #'PharoTransformationLanguage-visualisaitonTelescope'
}

{ #category : #initialization }
PTLVisuealisationPattern >> initialize [ 
	memory := OrderedCollection new
]

{ #category : #'instance creation' }
PTLVisuealisationPattern >> open [

	visu := TLFlowGraph new
		        entryPoint: memory first;
		        nextProperty: #next.
	visu addInteraction: (TLPopUpAction text: #title) onMouseOver.
	visu styleSheet nodeLabel: #title.

	visu open
]

{ #category : #entryPoint }
PTLVisuealisationPattern >> open: entryPoint [ 
	visu := TLFlowGraph new
		        entryPoint: entryPoint;
		        nextProperty: #next.
	visu addInteraction: (TLPopUpAction text: #title) onMouseOver.
	visu styleSheet nodeLabel: #title.

	visu open
]

{ #category : #visitor }
PTLVisuealisationPattern >> visitIntegerMatcher: anIntegerMatcher [

	| entity |
	entity := TLBasicBlock title: anIntegerMatcher value asString.
	memory add: entity.
	^ entity
]

{ #category : #visiting }
PTLVisuealisationPattern >> visitListMatcher: aList [

	| firstTL firstModel eachTL eachModel listBlock |
	firstTL := aList matcher accept: self.
	firstModel := aList matcher.
	listBlock := TLBasicBlock title: 'a list matcher'.
	memory add: listBlock.
	listBlock next: firstTL asOrderedCollection .
	[ firstModel isNotNil and: [ firstModel next isNotNil ]  ] whileTrue: [ 
		eachTL := firstModel next accept: self.
		eachModel := firstModel next.
		firstTL next: eachTL asOrderedCollection.
		"eachTL pred: firstTL."
		firstTL := eachTL.
		firstModel := eachModel ].
	^ listBlock
]
