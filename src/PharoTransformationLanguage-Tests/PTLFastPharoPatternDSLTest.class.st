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

{ #category : #example }
PTLFastPharoPatternDSLTest >> methodTestBadSequence [

	2.
	3.
	4
]

{ #category : #running }
PTLFastPharoPatternDSLTest >> methodTestLiteral [
	100
]

{ #category : #example }
PTLFastPharoPatternDSLTest >> methodTestSequence [

	1.
	2.
	3.
	4
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testLiteralAsMatcher [

	| model pattern modelFastPharo |
	model := [ 100 ] sourceNode statements first.
	modelFastPharo := (self importFrom:
		                   PTLFastPharoPatternDSLTest >> #methodTestLiteral)
		                  first.
	pattern := model acceptVisitor: PTLFastPharoPatternDSL new.
	self assert: (pattern match: modelFastPharo) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testSequenceMatcher [

	| pattern modelFastPharo patternModel modelFastPharo2 |
	patternModel := [ 
	                1.
	                2.
	                3.
	                4 ] sourceNode.
	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestSequence.
	modelFastPharo2 := self importFrom:
		                   PTLFastPharoPatternDSLTest >> #methodTestBadSequence.
	pattern := patternModel acceptVisitor: PTLFastPharoPatternDSL new.
	self assert: (pattern match: modelFastPharo) isMatch.
	self deny: (pattern match: modelFastPharo2) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testSymbolMatcher [

	| pattern modelFastPharo patternModel modelFastPharo2 matcherResult |
	patternModel := [ 
	                #'@first'.
	                #'*between'.
	                4 ] sourceNode.
	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestSequence.
	modelFastPharo2 := self importFrom:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestBadSequence.
	pattern := patternModel acceptVisitor: PTLFastPharoPatternDSL new.
	matcherResult := pattern match: modelFastPharo.
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #first) expression value equals: 1.
	self
		assertCollection: ((matcherResult at: #between) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 2. 3 }.
	self assert: (pattern match: modelFastPharo2) isMatch.
]
