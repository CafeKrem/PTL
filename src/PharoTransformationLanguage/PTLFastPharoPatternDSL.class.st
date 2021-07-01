Class {
	#name : #PTLFastPharoPatternDSL,
	#superclass : #RBProgramNodeVisitor,
	#category : #'PharoTransformationLanguage-FastPharoPatternDSL'
}

{ #category : #visiting }
PTLFastPharoPatternDSL >> nameAsJoker: aName [
	^ ('@{1}' format: aName) asSymbol
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitAssignmentNode: anAssignmentNode [
	^ anAssignmentNode class
		suchAs:
			{(#variable -> (anAssignmentNode variable acceptVisitor: self)).
			(#value -> (anAssignmentNode value acceptVisitor: self))}
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitLiteralNode: aNode [
	| valueMatcher |
	valueMatcher := aNode value asMatcher.
	(valueMatcher isEllipsis or: [ valueMatcher isJoker ])
		ifTrue: [ ^ valueMatcher ].
	^ aNode class suchAs: {(#value -> valueMatcher)}
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitMessageNode: messageNode [
	^ messageNode class suchAs: { 
		#receiver -> (messageNode receiver acceptVisitor: self).
		#selector -> messageNode selector.
		#arguments -> (messageNode arguments collect: [ :each | each acceptVisitor: self ]).
	 }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitSequenceNode: aSequenceNode [
	^ aSequenceNode class suchAs: { 
		#statements -> (aSequenceNode statements collect: [ :each | each acceptVisitor: self ])
	 }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitVariableNode: varNode [
	(varNode name beginsWith: '_')
		ifTrue: [ ^ self nameAsJoker: varNode name allButFirst ].
	^ varNode class suchAs: {(#name -> varNode name asSymbol)}
]
