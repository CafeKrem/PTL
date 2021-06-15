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

{ #category : #visit }
PTLVisuealisationPattern >> visitModelReferenceMatcher: matcherModelReference [

	| firstTL firstModel eachTL eachModel listBlock modelRefenceBlock |
	1 halt.
	firstTL := matcherModelReference configuration first accept: self.
	firstModel := matcherModelReference configuration first.
	1 halt.
	modelRefenceBlock := TLBasicBlock title:
		                     matcherModelReference modelDescription name.
	memory add: modelRefenceBlock.
	modelRefenceBlock next: firstTL asOrderedCollection.
	1 halt.
	[ firstModel isNotNil and: [ firstModel next isNotNil ] ] whileTrue: [ 
		eachTL := firstModel next accept: self.
		eachModel := firstModel next.
		firstTL next: eachTL asOrderedCollection.
		"eachTL pred: firstTL."
		firstTL := eachTL.
		firstModel := eachModel ].


	

	^ modelRefenceBlock
]

{ #category : #visitr }
PTLVisuealisationPattern >> visitSubPattern: aSubPattern [

	| block subBlock |
	block := TLBasicBlock title: aSubPattern selector.
	memory add: block.
	subBlock := aSubPattern matcherModel  accept: self.

	block next: subBlock asOrderedCollection.
	^ block
]
