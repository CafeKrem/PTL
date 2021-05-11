Class {
	#name : #PTLPatternMatcherTest,
	#superclass : #TestCase,
	#instVars : [
		'matcher'
	],
	#category : #'PharoTransformationLanguage-Tests'
}

{ #category : #tests }
PTLPatternMatcherTest >> methodRBWhileTrue [

	[ 
	1.
	2.  
	3.  
	4 = 5 ] whileTrue: [ 6 ]   
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAbstraction [
	100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAbstraction2 [
	'klm'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAbstraction3 [
	{  }
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAssignement [
	| klm |
	klm := 100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAssignement2 [
	| klm edgard patrick |
	edgard := OrderedCollection new.
	patrick := 100.
	klm := 200
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestAssignement3 [
	| edgard patrick |
	edgard := OrderedCollection new.
	patrick := 100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestBinOp [
	10 + 10
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestBinOp1 [
	10 + 5
]

{ #category : #tests }
PTLPatternMatcherTest >> methodTestCompose1 [
	'klm' setPatrick
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestEllipsisNode [
	100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestEllipsisNode1 [
	'klm'.
	'jiop'.
	'roger'.
	100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestEllipsisNode2 [
	'klm'.
	'patrick'.
	'edgard'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestEllipsisNode3 [
	1.
	2.
	3.
	4.
	6.
	100.
	42.
	50.
	26
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestJoker [
	1.
	2.
	3.
	4.
	5
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestJoker2 [
	10.
	100
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestMultipleChildrenNamed [
	100
		patrick;
		klm;
		edgard
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestMultipleChildrenNamed2 [
	100
		a;
		b;
		c;
		d;
		e;
		r;
		f;
		g;
		h;
		t
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestReturnLiteral4 [
	^ '4'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestReturnLiteralComplex [

	^ '1' + '2' + '3' + '4'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestReturnString [

	^ 'klm'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestSequence [
	'patrick'.
	'edgard'.
	'Rennes'.
	[ 'kl' ].
	100.
	'coucou'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestSequenceDirectMatch [
	[ 'klm' ].
	100.
	'patrick'
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestSequenceIncomplete [
	[ 'klm' ].
	100.
	300.
]

{ #category : #tests }
PTLPatternMatcherTest >> productFASTPharo: aCompiledMethod [
	^ (FASTSmalltalkImporterVisitor new
		runWithSource: aCompiledMethod sourceCode) statements
		asOrderedCollection sorted: [ :a :b | a startPos < b startPos ]
]

{ #category : #tests }
PTLPatternMatcherTest >> testBinOp [

	| pattern model model1 matcherResult |
	pattern := { (FASTExpressionStatement suchAs:
		            { (#expression -> (FASTPharoMessageSend suchAs: { 
				              (#receiver -> (PTLJokerMatcher new named: #x)).
				              (#selector -> '+').
				              (#arguments -> (PTLJokerMatcher new named: #x)) })) }) }
		           asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestBinOp.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestBinOp1.
	matcherResult := pattern match: model.
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #x) value equals: 10.
	self deny: (pattern match: model1) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testEllipsisMatcher [

	| pattern pattern1 model0 model1 matchResult matchResult1 model2 patternShortcut pattern1Shortcut |
	pattern := { 
		           ($* named: #ellipsis).
		           (FASTExpressionStatement suchAs: { 100 }) } asMatcher.
	pattern1 := { 
		            (PTLEllipsisMatcher new named: #ellipsis).
		            (FASTExpressionStatement suchAs: { 100 }) } asMatcher.
	patternShortcut := { 
		                   #'*ellipsis'.
		                   (FASTExpressionStatement suchAs: { 100 }) }
		                   asMatcher.
	pattern1Shortcut := { 
		                    #'*ellipsis'.
		                    (FASTExpressionStatement suchAs: { 100 }) }
		                    asMatcher.
	model0 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestEllipsisNode.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestEllipsisNode1.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestEllipsisNode2.
	matchResult := pattern match: model0.
	matchResult1 := pattern1 match: model0.
	self deny: (pattern match: model2) isMatch.
	self deny: (pattern1 match: model2) isMatch.
	self assert: matchResult isMatch.
	self
		assertCollection: (matchResult context at: #ellipsis)
		hasSameElements: {  }.
	self assert: matchResult1 isMatch.
	self
		assertCollection: (matchResult1 context at: #ellipsis)
		hasSameElements: {  }.
	matchResult := pattern match: model1.
	matchResult1 := pattern1 match: model1.
	self assert: matchResult isMatch.
	self
		assertCollection:
			((matchResult context at: #ellipsis) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }.
	self assert: matchResult1 isMatch.
	self
		assertCollection:
			((matchResult1 context at: #ellipsis) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }.
	self flag: 'extract it to another test ? '.
	"shortcut test"
	matchResult := patternShortcut match: model0.
	matchResult1 := pattern1Shortcut match: model0.
	self deny: (pattern match: model2) isMatch.
	self deny: (pattern1 match: model2) isMatch.
	self assert: matchResult isMatch.
	self
		assertCollection: (matchResult context at: #ellipsis)
		hasSameElements: {  }.
	self assert: matchResult1 isMatch.
	self
		assertCollection: (matchResult1 context at: #ellipsis)
		hasSameElements: {  }.
	matchResult := pattern match: model1.
	matchResult1 := pattern1 match: model1.
	self assert: matchResult isMatch.
	self
		assertCollection:
			((matchResult context at: #ellipsis) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }.
	self assert: matchResult1 isMatch.
	self
		assertCollection:
			((matchResult1 context at: #ellipsis) collect: [ :each | 
				 each expression value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }
]

{ #category : #tests }
PTLPatternMatcherTest >> testEllipsisMatcher2 [
	| pattern model matcherResult |
	pattern := {(PTLJokerMatcher new named: #joker).
	($* named: #before100).
	(FASTExpressionStatement suchAs: {100}).
	($* named: #after100)} asMatcher.
	model := self
		productFASTPharo: PTLPatternMatcherTest >> #methodTestEllipsisNode3.
	matcherResult := pattern match: model.
	self assert: matcherResult isMatch.
	self
		assertCollection:
			((matcherResult at: #before100)
				collect: [ :each | each expression value ])
		hasSameElements: {2 . 3 . 4 . 6}.
	self
		assertCollection:
			((matcherResult at: #after100)
				collect: [ :each | each expression value ])
		hasSameElements: {42 . 50 . 26}.
	self assert: (matcherResult at: #joker) expression value equals: 1
]

{ #category : #tests }
PTLPatternMatcherTest >> testIntegerMatcher [
	| pattern |
	pattern := 100 asMatcher.
	self assert: (pattern match: 100) isMatch.
	self deny: (pattern match: 900) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testJokerMatcher [

	| pattern pattern1 pattern2 model model1 matchResult matchResult2 pattern3 patternShorcut pattern1Shorcut pattern2Shorcut pattern3Shorcut |
	pattern := { 
		           (FASTExpressionStatement suchAs: { 1 }).
		           (PTLJokerMatcher new named: #joker) } asMatcher.
	pattern1 := { 
		            (PTLJokerMatcher new named: #joker).
		            (FASTExpressionStatement suchAs: { 100 }) } asMatcher.
	pattern2 := { 
		            (PTLJokerMatcher new named: #first).
		            $*.
		            (PTLJokerMatcher new named: #last) } asMatcher.
	pattern3 := { 
		            PTLJokerMatcher new.
		            (FASTExpressionStatement suchAs: { 2 }).
		            (FASTExpressionStatement suchAs: { 99 }) } asMatcher.
	patternShorcut := { 
		                  (FASTExpressionStatement suchAs: { 1 }).
		                  #'@joker' } asMatcher.
	pattern1Shorcut := { 
		                   #'@joker'.
		                   (FASTExpressionStatement suchAs: { 100 }) }
		                   asMatcher.
	pattern2Shorcut := { #'@first'. #*. #'@last' } asMatcher.
	pattern3Shorcut := { 
		                   #_.
		                   (FASTExpressionStatement suchAs: { 2 }).
		                   (FASTExpressionStatement suchAs: { 99 }) }
		                   asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestJoker.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestJoker2.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #joker) expression value equals: 2.
	self deny: (pattern1 match: model) isMatch.
	self deny: (pattern3 match: model) isMatch.
	matchResult2 := pattern2 match: model.
	self assert: (matchResult2 at: #first) expression value equals: 1.
	self assert: (matchResult2 at: #last) expression value equals: 5.
	self assert: (pattern1 match: model1) isMatch.
	self
		assert: ((pattern1 match: model1) at: #joker) expression value
		equals: 10.

	"shorcutTest"
	matchResult := patternShorcut match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #joker) expression value equals: 2.
	self deny: (pattern1Shorcut match: model) isMatch.
	self deny: (pattern3Shorcut match: model) isMatch.
	matchResult2 := pattern2Shorcut match: model.
	self assert: (matchResult2 at: #first) expression value equals: 1.
	self assert: (matchResult2 at: #last) expression value equals: 5.
	self assert: (pattern1Shorcut match: model1) isMatch.
	self
		assert:
		((pattern1Shorcut match: model1) at: #joker) expression value
		equals: 10
]

{ #category : #tests }
PTLPatternMatcherTest >> testJokerMatcherAutoAssignedNamed [

	| pattern model matchResult |
	pattern := { (FASTExpressionStatement suchAs:
		            { (#expression -> FASTPharoMessageSend suchAs: { 
				             (#receiver -> #@).
				             (#selector -> '+').
				             (#arguments -> #@) }) }) } asMatcher.

	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestBinOp1.

	matchResult := pattern match: model.

	self assert: matchResult isMatch.

	self assert: (matchResult at: #receiver) value equals: 10.
	self assert: (matchResult at: #arguments) value equals: 5
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchAnAbstraction [
	| pattern model model2 model3 matchResult |
	pattern := {(FASTExpressionStatement
		suchAs: {(#expression -> (FASTLiteral named: #x))})} asMatcher.
	model := self
		productFASTPharo: PTLPatternMatcherTest >> #methodTestAbstraction.
	model2 := self
		productFASTPharo: PTLPatternMatcherTest >> #methodTestAbstraction2.
	model3 := self
		productFASTPharo: PTLPatternMatcherTest >> #methodTestAbstraction3.
	self deny: (pattern match: model3) isMatch.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #x) value equals: 100.
	matchResult := pattern match: model2.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #x) value equals: 'klm'
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchModelRefenceWithConfigurationMatcher [

	| pattern |
	pattern := (FASTReturnStatement suchAs:
		            { (FASTStringLiteral suchAs: 'klm') }) asMatcher.
	self assert: (pattern match: (FASTReturnStatement new expression:
				  (FASTStringLiteral new value: 'klm'))) isMatch.
	self deny: (pattern match: (FASTReturnStatement new expression:
				  (FASTStringLiteral new value: 'patrick'))) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchModelRefenceWithConfigurationMatcher2 [

	| pattern pattern2 model1 model2 |
	model1 := FASTReturnStatement new expression:
		          (FASTStringLiteral new value: 'klm').
	model2 := FASTReturnStatement new expression:
		          (FASTStringLiteral new value: 'patrick').
	pattern := (FASTReturnStatement suchAs:
		            { (FASTStringLiteral suchAs: { 'klm' }) }) asMatcher.
	pattern2 := (FASTReturnStatement suchAs:
		             { (FASTStringLiteral suchAs: 'klm') }) asMatcher.
	self assert: (pattern match: model1) isMatch.
	self assert: (pattern2 match: model1) isMatch.
	self deny: (pattern match: model2) isMatch.
	self deny: (pattern match: model2) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchModelReferenceWithNamedConfiguration [

	| pattern model1 model2 |
	pattern := { ((FASTExpressionStatement suchAs:
		             { (FASTPharoCascade suchAs:
			              { (FASTPharoMessageSend suchAs: { 
					               (#receiver -> 100).
					               (#selector -> 'klm') }) }) }) named: #a) }
		           asMatcher.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestMultipleChildrenNamed.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestMultipleChildrenNamed2.
	self assert: (pattern match: model1) isMatch.
	self deny: (pattern match: model2) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchSavedAssociation [

	| matchResult1 matchResult2 matchResult3 |
	matcher := { ((FASTReturnStatement suchAs:
		             { (FASTStringLiteral suchAs: { '4' }) }) named: #a) }
		           asMatcher.
	matchResult1 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest >> #methodTestReturnLiteral4).
	matchResult2 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest
			                 >> #methodTestReturnLiteralComplex).
	matchResult3 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest >> #methodTestReturnString).
	self assert: matchResult1 isMatch.
	self assert: (matchResult1 at: #a) class equals: FASTReturnStatement.
	self deny: matchResult2 isMatch.
	self deny: matchResult3 isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchTwoLastStatementOfASequence [

	| pattern model matchResult pattern1 matchResult2 |
	pattern := { 
		           $*.
		           (PTLJokerMatcher new named: #lastlast).
		           (PTLJokerMatcher new named: #last) } asMatcher.
	pattern1 := { 
		            $*.
		            (PTLJokerMatcher new named: #beforebefore50).
		            (PTLJokerMatcher new named: #before50).
		            (FASTExpressionStatement suchAs: { 50 }) } asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestEllipsisNode3.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #lastlast) expression value equals: 50.
	self assert: (matchResult at: #last) expression value equals: 26.
	matchResult2 := pattern1 match: model.
	self assert: matchResult2 isMatch.
	self assert: (matchResult2 at: #before50) expression value equals: 42.
	self
		assert: (matchResult2 at: #beforebefore50) expression value
		equals: 100
]

{ #category : #tests }
PTLPatternMatcherTest >> testModelReferenceMatcher [

	| pattern |
	pattern := FASTReturnStatement asMatcher.
	self assert: (pattern match: (FASTReturnStatement new
				  expression: (FASTStringLiteral new
						   value: 'klm';
						   yourself);
				  yourself)) isMatch.
	self deny: (pattern match: FASTExpressionStatement new) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testModelReferenceWithMultipleSubPattern [

	| pattern model1 model2 model3 |
	pattern := { ((FASTExpressionStatement suchAs:
		             { (FASTPharoAssignmentExpression suchAs: { 'klm'. 100 }) }) 
		            named: #a) } asMatcher.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestAssignement.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestAssignement2.
	model3 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestAssignement3.
	self assert: (pattern match: model1) isMatch.
	self deny: (pattern match: model2) isMatch.
	self deny: (pattern match: model3) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testRBAST [

	| pattern model matchResult patternWithoutParenthesis |
	
	pattern := { (RBSequenceNode suchAs:
		            { (#statements -> (RBMessageNode suchAs: { 
				              (#receiver -> (RBBlockNode suchAs:
					                { (#body
					                 -> (RBSequenceNode suchAs: { (#statements -> { 
								                   ($* named: #a).
								                   (PTLJokerMatcher named: #cond) }) })) })).
				              (#selector
				               -> ((Smalltalk version = 'Pharo8.0.0') ifTrue:  [ 'whileTrue:']ifFalse: [RBSelectorNode suchAs: { 'whileTrue:' }])).
				              (#arguments -> (RBBlockNode suchAs:
					                { (#body -> (RBSequenceNode named: #whileBlock)) })) })) }) }
		           asMatcher.
	patternWithoutParenthesis := { (RBSequenceNode suchAs:
		                              { (#statements -> RBMessageNode 
			                               suchAs: { 
					                               (#receiver -> RBBlockNode suchAs:
						                                { (#body -> RBSequenceNode 
							                                 suchAs: { (#statements -> { 
									                                  ($* named: #a).
									                                  (PTLJokerMatcher named: #cond) }) }) }).
					                               (#selector ->((Smalltalk version = 'Pharo8.0.0') ifTrue:  [ 'whileTrue:']ifFalse: [RBSelectorNode suchAs: { 'whileTrue:' }]) ).
					                               (#arguments -> RBBlockNode 
						                                suchAs:
						                                { (#body -> RBSequenceNode 
							                                 named: #whileBlock) }) }) }) }
		                             asMatcher.
	model := (PTLPatternMatcherTest >> #methodRBWhileTrue) ast body.
	matchResult := pattern match: model.

	self assert: matchResult isMatch.
	self
		assertCollection: ((matchResult at: #a) collect: #value)
		hasSameElements: { 1. 2. 3 }.
	self assert: (matchResult at: #cond) selector equals: '='.
	self
		assertCollection:
		((matchResult at: #whileBlock) statements collect: #value)
		hasSameElements: { 6 }.
	"###### Test withOut parenthesis"
	matchResult := patternWithoutParenthesis match: model.

	self assert: matchResult isMatch.
	self
		assertCollection: ((matchResult at: #a) collect: #value)
		hasSameElements: { 1. 2. 3 }.
	self assert: (matchResult at: #cond) selector equals: '='.
	self
		assertCollection:
		((matchResult at: #whileBlock) statements collect: #value)
		hasSameElements: { 6 }
]

{ #category : #tests }
PTLPatternMatcherTest >> testSequenceMatcher [

	| pattern model0 model1 model2 mathResult2 |
	pattern := { 
		           ((FASTExpressionStatement suchAs:
			             { FASTPharoBlockExpression }) named: #block).
		           ((FASTExpressionStatement suchAs: 100) named: #int).
		           ((FASTExpressionStatement suchAs: { FASTStringLiteral }) 
			            named: #str) } asMatcher.

	model0 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequence.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceIncomplete.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceDirectMatch.
	self deny: (pattern match: model0) isMatch.
	self deny: (pattern match: model1) isMatch.
	mathResult2 := pattern match: model2.
	self assert: mathResult2 isMatch.
	self
		assert: (mathResult2 at: #block) expression class
		equals: FASTPharoBlockExpression.
	self assert: (mathResult2 at: #int) expression value equals: 100.
	self
		assert: (mathResult2 at: #str) expression class
		equals: FASTStringLiteral
]

{ #category : #tests }
PTLPatternMatcherTest >> testSequenceMatcher2 [

	| pattern model0 model1 model2 |
	pattern := { 
		           FASTPharoBlockExpression.
		           100.
		           FASTStringLiteral } asMatcher.
	model0 := (self productFASTPharo:
		           PTLPatternMatcherTest >> #methodTestSequence) collect:
		          #expression.
	model1 := (self productFASTPharo:
		           PTLPatternMatcherTest >> #methodTestSequenceIncomplete) 
		          collect: #expression.
	model2 := (self productFASTPharo:
		           PTLPatternMatcherTest >> #methodTestSequenceDirectMatch) 
		          collect: #expression.
	self deny: (pattern match: model0) isMatch.
	self deny: (pattern match: model1) isMatch.
	self assert: (pattern match: model2) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testStringCompositeMatcher [

	| pattern matchResult |
	pattern := { 
		           'set'.
		           ($* named: #x) } asMatcher.
	matchResult := pattern match: 'setLabel'.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #x) equals: 'Label'
]

{ #category : #tests }
PTLPatternMatcherTest >> testStringCompositeMatcher2 [

	| pattern model matchResult |
	pattern := { (FASTExpressionStatement suchAs:
		            { (#expression -> (FASTPharoMessageSend suchAs:
			              { (#selector
			               -> (FASTPharoSelector suchAs: { (#name -> { 
						                 'set'.
						                 ($* named: #x) }) })) })) }) } asMatcher.
	
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestCompose1.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #x) equals: 'Patrick'
]

{ #category : #tests }
PTLPatternMatcherTest >> testStringMatcher [
	| pattern |
	pattern := 'klm' asMatcher.
	self assert: (pattern match: 'klm') isMatch.
	self deny: (pattern match: 'patrick') isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testStringMatcher2 [

	| pattern a b x |
	pattern := RBVariableNode suchAs: { (#name -> #x) } asMatcher.

	a := pattern match: ([ x ] sourceNode statements at: 1).
	b := pattern match: ([ x ] sourceNode statements at: 1).

	self assert: a isMatch.
	self assert: b isMatch
]
