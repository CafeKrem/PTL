"
A PTLFastPharoPatternDSLTest is a test class for testing the behavior of PTLFastPharoPatternDSL
"
Class {
	#name : #PTLFastPharoPatternDSLTest,
	#superclass : #TestCase,
	#category : #'PharoTransformationLanguage-FastPharoPatternDSL'
}

{ #category : #tests }
PTLFastPharoPatternDSLTest >> importFrom: aCompiledMethod [

	^ (FASTSmalltalkImporterVisitor new runWithSource:
		   aCompiledMethod sourceCode) statements asOrderedCollection 
		  sorted: [ :a :b | a startPos < b startPos ]
]

{ #category : #'as yet unclassified' }
PTLFastPharoPatternDSLTest >> methodTestAssign [

	| a |
	1.
	2.
	a := 100
]

{ #category : #'as yet unclassified' }
PTLFastPharoPatternDSLTest >> methodTestBadAssign [

	| a |
	1.
	2.
	a := 200
]

{ #category : #example }
PTLFastPharoPatternDSLTest >> methodTestBadSequence [

	2.
	3.
	4
]

{ #category : #'as yet unclassified' }
PTLFastPharoPatternDSLTest >> methodTestIncrementAssign [
	| klm |
	klm := klm + 1
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

{ #category : #'as yet unclassified' }
PTLFastPharoPatternDSLTest >> methodTestWhileFalse [
	[ 1 . 2 . 3 = 4 ] whileFalse: [ 5 . 6.  ]
]

{ #category : #'as yet unclassified' }
PTLFastPharoPatternDSLTest >> methodTestWhileTrue [
	[ 1 . 2 . 3 = 4 ] whileTrue: [ 5 . 6.  ]
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testAssignMatcher [

	| a model pattern fastPharoModel matchResult fastPharoModel2 |
	model := [ 
	         #'*any'.
	         a := 100 ] .
	pattern := model asFASTPharoMatcher.

	fastPharoModel := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestAssign.
	fastPharoModel2 := self importFrom:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestBadAssign.
	matchResult := pattern match: (fastPharoModel collect: #expression).
	self assert: matchResult isMatch.
	self
		assertCollection: ((matchResult at: #any) collect: #value)
		hasSameElements: { 1. 2 }.
		
	self deny: (pattern match: (fastPharoModel2 collect: #expression) ) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testLiteralAsMatcher [

	| model pattern modelFastPharo |
	model := [ 100 ] sourceNode.
	modelFastPharo := (self importFrom:
		                   PTLFastPharoPatternDSLTest >> #methodTestLiteral)
		                  first.
	pattern := model body acceptVisitor: PTLFastPharoPatternDSL new.
	self assert: (pattern match: modelFastPharo expression) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testMessageSendMatcher [

	| pattern modelFastPharo patternModel modelFastPharo2 matcherResult patternShortcut |
	patternModel := [ 
	                [ 
	                #'*beforeCond'.
	                #'@condition' ] whileTrue: [ #'*body' ] ] sourceNode.
	modelFastPharo := (self importFrom:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestWhileTrue) collect: [ :each | 
		                  each expression ].
	modelFastPharo2 := self importFrom:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestWhileFalse.
	pattern := patternModel body acceptVisitor:
		           PTLFastPharoPatternDSL new.
	matcherResult := pattern match: modelFastPharo.
	self assert: matcherResult isMatch.
	self
		assert: (matcherResult at: #condition) expression receiver value
		equals: 3.
	self
		assertCollection:
			((matcherResult at: #beforeCond) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 1. 2 }.
	self
		assertCollection:
		((matcherResult at: #body) collect: [ :each | each expression value ])
		hasSameElements: { 5. 6 }.
	self deny: (pattern match: modelFastPharo2) isMatch.

	"######### shortcut #############"

	pattern := patternModel asFASTPharoMatcher.
	matcherResult := pattern match: modelFastPharo.
	self assert: matcherResult isMatch.
	self
		assert: (matcherResult at: #condition) expression receiver value
		equals: 3.
	self
		assertCollection:
			((matcherResult at: #beforeCond) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 1. 2 }.
	self
		assertCollection:
		((matcherResult at: #body) collect: [ :each | each expression value ])
		hasSameElements: { 5. 6 }.
	self deny: (pattern match: modelFastPharo2) isMatch
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
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestBadSequence.
	pattern := patternModel body acceptVisitor:
		           PTLFastPharoPatternDSL new.
	self assert:
		(pattern match: (modelFastPharo collect: #expression)) isMatch.
	self deny:
		(pattern match: (modelFastPharo2 collect: #expression)) isMatch
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
	pattern := patternModel body acceptVisitor:
		           PTLFastPharoPatternDSL new.
	matcherResult := pattern match: (modelFastPharo collect: #expression).
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #first) value equals: 1.
	self
		assertCollection:
		((matcherResult at: #between) collect: [ :each | each value ])
		hasSameElements: { 2. 3 }.
	self assert: (pattern match: (modelFastPharo2 collect: #expression)) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testVariableMatcher [

	| pattern modelFastPharo patternModel matcherResult |
	patternModel := [ _x := _x + 1 ] sourceNode.

	pattern := patternModel asFASTPharoMatcher.

	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest
		                  >> #methodTestIncrementAssign.
	matcherResult := pattern match: (modelFastPharo collect: #expression).
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #x) name equals: 'klm'
]
