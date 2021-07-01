"
A PTLFastPharoPatternDSLTest is a test class for testing the behavior of PTLFastPharoPatternDSL
"
Class {
	#name : #PTLFastPharoPatternDSLTest,
	#superclass : #TestCase,
	#category : #'PharoTransformationLanguage-Tests-FastPharoPatternDSL'
}

{ #category : #tests }
PTLFastPharoPatternDSLTest >> importFrom: aCompiledMethod [

	^ (FASTSmalltalkImporterVisitor new runWithSource:
		   aCompiledMethod sourceCode) statements asOrderedCollection 
		  sorted: [ :a :b | a startPos < b startPos ]
]

{ #category : #running }
PTLFastPharoPatternDSLTest >> methodTestLiteral [
	100
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testLiteralAsMatcher [

	| model pattern modelFastPharo |
	model := (PTLFastPharoPatternDSLTest >> #methodTestLiteral)
		         sourceNode body statements first.
	modelFastPharo := (self importFrom: (PTLFastPharoPatternDSLTest >> #methodTestLiteral) )first expression.
	pattern := model acceptVisitor: PTLFastPharoPatternDSL new.
	self assert: (pattern match: modelFastPharo) isMatch
]
