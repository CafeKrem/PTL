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

	^ FASTPharoAssignmentExpression suchAs: { 
			  (#variable -> (anAssignmentNode variable acceptVisitor: self)).
			  (#expression -> (anAssignmentNode value acceptVisitor: self)) }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitBlockNode: aBlockNode [

	^ FASTPharoBlockExpression suchAs:
		  { (#'block > statements' -> (aBlockNode body acceptVisitor: self)) }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitLiteralNode: aNode [

	| valueMatcher |
	valueMatcher := aNode value asMatcher.
	(valueMatcher isEllipsis or: [ valueMatcher isJoker ]) ifTrue: [ 
		^ valueMatcher ].
	^ FASTLiteral suchAs: { (#value -> valueMatcher) }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitMessageNode: messageNode [

	^ FASTPharoMessageSend suchAs: { 
			  (#receiver -> (messageNode receiver acceptVisitor: self)).
			  (#selector -> messageNode selector).
			  (#arguments
			   ->
			   (messageNode arguments collect: [ :each | 
				    each acceptVisitor: self ])) }
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitSequenceNode: aSequenceNode [

	| subPattern |
	^ (aSequenceNode statements collect: [ :statement | 
		  subPattern := statement acceptVisitor: self.
		  subPattern isJokerOrEllipsis
			  ifTrue: [ subPattern ]
			  ifFalse: [ 
			  FASTExpressionStatement suchAs: { (#expression -> subPattern) } ] ]) asMatcher 
]

{ #category : #visiting }
PTLFastPharoPatternDSL >> visitVariableNode: varNode [

	(varNode name beginsWith: '_') ifTrue: [ 
		^ (self nameAsJoker: varNode name allButFirst) asMatcher ].
	^ FASTVariableExpression suchAs: { (#name -> varNode name asSymbol) }
]
