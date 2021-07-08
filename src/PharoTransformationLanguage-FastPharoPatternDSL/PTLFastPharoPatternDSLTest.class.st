"
A PTLFastPharoPatternDSLTest is a test class for testing the behavior of PTLFastPharoPatternDSL
"
Class {
	#name : #PTLFastPharoPatternDSLTest,
	#superclass : #TestCase,
	#instVars : [
		'a'
	],
	#classInstVars : [
		'a'
	],
	#category : #'PharoTransformationLanguage-FastPharoPatternDSL'
}

{ #category : #tests }
PTLFastPharoPatternDSLTest >> importFrom: aCompiledMethod [

	^ (FASTSmalltalkImporterVisitor new runWithSource:
		   aCompiledMethod sourceCode) statements asOrderedCollection 
		  sorted: [ :a :b | a startPos < b startPos ]
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> importMethod: aCompiledMethod [

	^ (FASTSmalltalkImporterVisitor new runWithSource:
		   aCompiledMethod sourceCode)
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
PTLFastPharoPatternDSLTest >> methodTestBlock [

	| klm |
	[ klm := klm + 1 ]
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

	| model pattern fastPharoModel matchResult fastPharoModel2 |
	model := [ 
	         #'*any'.
	         a := 100 ].
	pattern := model asFASTPharoMatcher.
	fastPharoModel := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestAssign.
	fastPharoModel2 := self importFrom:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestBadAssign.
	matchResult := pattern match: fastPharoModel.
	self assert: matchResult isMatch.
	self
		assertCollection:
		((matchResult at: #any) collect: [ :each | each expression value ])
		hasSameElements: { 1. 2 }.

	self deny: (pattern match: fastPharoModel2) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testBlockInstructionMatcher [

	| pattern model |
	pattern := [ 1 ] asFASTPharoInstructionMatcher.
	model := (self importFrom:
		          PTLFastPharoPatternDSLTest >> #methodTestAssign) collect:
		         #expression.
	self deny: (pattern match: model) isMatch.
	self assert: (pattern match: model first) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testLiteralAsMatcher [

	| model pattern modelFastPharo |
	pattern := [ 100 ] asFASTPharoMatcher.
	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestLiteral.
	self assert: (pattern match: modelFastPharo ) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testMessageSendMatcher [

	| pattern modelFastPharo patternModel modelFastPharo2 matcherResult |
	patternModel := [ 
	                [ 
	                #'*beforeCond'.
	                #'@condition' ] whileTrue: [ #'*body' ] ] sourceNode.
	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest >> #methodTestWhileTrue.
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
PTLFastPharoPatternDSLTest >> testMethodMatcher [

	| model pattern fastPharoModel matchResult fastPharoModel2 |
	pattern := FASTPharoMethodEntity suchAs: { (#statements -> [ 
		            #'*any'.
		            a := 100 ] asFASTPharoMatcher) }.
	fastPharoModel := self importMethod:
		                  PTLFastPharoPatternDSLTest >> #methodTestAssign.
	fastPharoModel2 := self importMethod:
		                   PTLFastPharoPatternDSLTest
		                   >> #methodTestBadAssign.
	matchResult := pattern match: fastPharoModel.
	self assert: matchResult isMatch.
	self
		assertCollection:
		((matchResult at: #any) collect: [ :each | each expression value ])
		hasSameElements: { 1. 2 }.

	self deny: (pattern match: fastPharoModel2) isMatch
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
	pattern := patternModel body acceptVisitor:
		           PTLFastPharoPatternDSL new.
	matcherResult := pattern match: modelFastPharo.
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #first) expression value equals: 1.
	self
		assertCollection: ((matcherResult at: #between) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 2. 3 }.
	self assert: (pattern match: modelFastPharo2) isMatch
]

{ #category : #tests }
PTLFastPharoPatternDSLTest >> testVariableMatcher [

	| pattern modelFastPharo patternModel matcherResult |
	patternModel := [ _x := _x + 1 ] sourceNode.

	pattern := patternModel asFASTPharoMatcher.

	modelFastPharo := self importFrom:
		                  PTLFastPharoPatternDSLTest
		                  >> #methodTestIncrementAssign.
	matcherResult := pattern match: modelFastPharo.
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #x) name equals: 'klm'
]
