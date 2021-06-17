Class {
	#name : #PTLPatternMatcherTest,
	#superclass : #TestCase,
	#category : #'PharoTransformationLanguage-Tests-tests'
}

{ #category : #testing }
PTLPatternMatcherTest class >> isAbstract [
	^ self = PTLPatternMatcherTest
]

{ #category : #compatibility }
PTLPatternMatcherTest >> compatibilityStringCompositeMatche2 [

	^ self subclassResponsibility
]

{ #category : #tests }
PTLPatternMatcherTest >> methodRBWhileTrue [

	[ 
	1.
	2.  
	3.  
	4 = 5 ] whileTrue: [ 6 ]   
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAbstraction [
	100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAbstraction2 [
	'klm'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAbstraction3 [
	{  }
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAssignement [
	| klm |
	klm := 100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAssignement2 [
	| klm edgard patrick |
	edgard := OrderedCollection new.
	patrick := 100.
	klm := 200
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestAssignement3 [
	| edgard patrick |
	edgard := OrderedCollection new.
	patrick := 100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestBinOp [
	10 + 10
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestBinOp1 [
	10 + 5
]

{ #category : #'as yet unclassified' }
PTLPatternMatcherTest >> methodTestBinOp3 [
	100 + 100  
]

{ #category : #tests }
PTLPatternMatcherTest >> methodTestCompose1 [
	'klm' setPatrick
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestEllipsisNode [
	100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestEllipsisNode1 [
	'klm'.
	'jiop'.
	'roger'.
	100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestEllipsisNode2 [
	'klm'.
	'patrick'.
	'edgard'
]

{ #category : #example }
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

{ #category : #example }
PTLPatternMatcherTest >> methodTestJoker [
	1.
	2.
	3.
	4.
	5
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestJoker2 [
	10.
	100
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestMultipleChildrenNamed [
	100
		patrick;
		klm;
		edgard
]

{ #category : #example }
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
PTLPatternMatcherTest >> methodTestPragma [
	<patate>
	<carote: #( #rouge #orange)>
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestReturnLiteral4 [
	^ '4'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestReturnLiteralComplex [

	^ '1' + '2' + '3' + '4'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestReturnString [

	^ 'klm'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestSequence [
	'patrick'.
	'edgard'.
	'Rennes'.
	[ 'kl' ].
	100.
	'coucou'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestSequenceDirectMatch [
	[ 'klm' ].
	100.
	'patrick'
]

{ #category : #example }
PTLPatternMatcherTest >> methodTestSequenceIncomplete [
	[ 'klm' ].
	100.
	300.
]

{ #category : #tests }
PTLPatternMatcherTest >> productFASTPharo: aCompiledMethod [
	^ aCompiledMethod ast body
	"(FASTSmalltalkImporterVisitor new
		runWithSource: aCompiledMethod sourceCode) statements
		asOrderedCollection sorted: [ :a :b | a startPos < b startPos ]"
]

{ #category : #compatibility }
PTLPatternMatcherTest >> rBASTSpecificCode [
	self subclassResponsibility.
]

{ #category : #tests }
PTLPatternMatcherTest >> testBinOp [

	| pattern model model1 matcherResult |
	pattern := { (RBSequenceNode suchAs:
		            { (#statements -> (RBMessageNode suchAs: { 
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
PTLPatternMatcherTest >> testContainerMatcher [

	| pattern |
	pattern := PTLContainerMatcher element: 100.

	self assert: (pattern match: { 100 }) isMatch.
	self assert: (pattern match: { 1. 5. 7. 100 }) isMatch.
	self assert: (pattern match: { 100. 5. 4 }) isMatch.
	self assert: (pattern match: { 1. 100. 4 }) isMatch.
	self deny: (pattern match: {  }) isMatch.
	self deny: (pattern match: { 1. 23. 443. 53. 21. 2 }) isMatch.
	self deny: (pattern match: { 'lk'. '100' }) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testContainerMatcher1 [

	| pattern |
	pattern :=  (Class suchAs: {#slotNames -> (PTLContainerMatcher element:  #x)}).

	self assert: (pattern match: Point) isMatch.
	self deny: (pattern match: Class) isMatch.
]

{ #category : #tests }
PTLPatternMatcherTest >> testContainerMatcher2 [

	| pattern |
	pattern := Class suchAs:
		           { (#slotNames
		            -> (PTLContainerMatcher elements: { #x. #y })) }.

	self assert: (pattern match: Point) isMatch.
	self deny: (pattern match: Class) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testContainerMatcher3 [

	| pattern |
	pattern := Object suchAs: { 
			           (#x -> 100).
			           (#class -> Class suchAs:
				            { (#slotNames
				             -> (PTLContainerMatcher elements: { #x. #y })) }) }.

	self assert: (pattern match: 100 @ 0) isMatch.
	self deny: (pattern match: 50 @ 100) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testContainerMatcher4 [

	| patternPatate patternCarote |
	patternPatate := CompiledMethod suchAs:
		                 { (#pragmas -> (PTLContainerMatcher element:
			                   (Pragma suchAs: { (#selector -> #patate) }))) }.
	patternCarote := CompiledMethod suchAs:
		                 { (#pragmas
		                  ->
			                  (PTLContainerMatcher element: (Pragma suchAs: { 
						                    (#selector -> #carote:).
						                    (#arguments
						                     -> (PTLContainerMatcher element: #rouge)) }))) }.

	self assert:
		(patternPatate match: PTLPatternMatcherTest >> #methodTestPragma)
			isMatch.
	self assert:
		(patternCarote match: PTLPatternMatcherTest >> #methodTestPragma)
			isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testContainerMatcher5API [

	| patternPatate patternCarote pattern |
	patternPatate := CompiledMethod suchAs:
		                 { (#pragmas
		                  ->
		                  (Pragma suchAs: { (#selector -> #patate) })
			                  isContained) }.
	patternCarote := CompiledMethod suchAs:
		                 { (#pragmas -> (Pragma suchAs: { 
				                   (#selector -> #carote:).
				                   (#arguments -> #rouge isContained) })
			                  isContained) }.

	pattern := Object suchAs: { 
			           (#x -> 100).
			           (#class -> Class suchAs:
				            { (#slotNames -> { #x. #y } isContained) }) }.

	self assert: (pattern match: 100 @ 0) isMatch.
	self deny: (pattern match: 50 @ 100) isMatch.
	self assert:
		(patternPatate match: PTLPatternMatcherTest >> #methodTestPragma)
			isMatch.
	self assert:
		(patternCarote match: PTLPatternMatcherTest >> #methodTestPragma)
			isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testDirectPath [

| pattern |
pattern := RBMessageNode  suchAs: { #'receiver > class ' -> Class }  .

self assert: (pattern match:  [ 'klm' asString ] sourceNode body statements first ) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testEllipsisMatcher [

	| pattern pattern1 model0 model1 matchResult matchResult1 model2 patternShortcut pattern1Shortcut |
	pattern := (RBSequenceNode suchAs: { (#statements -> { 
			             ($* named: #ellipsis).
			             100 }) }) asMatcher.
	pattern1 := (RBSequenceNode suchAs: { (#statements -> { 
			              (PTLEllipsisMatcher new named: #ellipsis).
			              100 }) }) asMatcher.
	patternShortcut := (RBSequenceNode suchAs:
		                    { (#statements -> { #'*ellipsis'. 100 }) })
		                   asMatcher.
	pattern1Shortcut := RBSequenceNode suchAs:
		                    #statements
		                    -> { { #'*ellipsis'. 100 } } asMatcher.
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
		((matchResult context at: #ellipsis) collect: [ :each | each value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }.
	self assert: matchResult1 isMatch.
	self
		assertCollection:
		((matchResult1 context at: #ellipsis) collect: [ :each | each value ])
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
		((matchResult context at: #ellipsis) collect: [ :each | each value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }.
	self assert: matchResult1 isMatch.
	self
		assertCollection:
		((matchResult1 context at: #ellipsis) collect: [ :each | each value ])
		hasSameElements: { 'klm'. 'jiop'. 'roger' }
]

{ #category : #tests }
PTLPatternMatcherTest >> testEllipsisMatcher2 [

	| pattern model matcherResult |
	pattern := RBSequenceNode suchAs: { (#statements -> { 
			            (PTLJokerMatcher new named: #joker).
			            ($* named: #before100).
			            100.
			            ($* named: #after100) }) } asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestEllipsisNode3.
	matcherResult := pattern match: model.
	self assert: matcherResult isMatch.
	self
		assertCollection:
		((matcherResult at: #before100) collect: [ :each | each value ])
		hasSameElements: { 2. 3. 4. 6 }.
	self
		assertCollection:
		((matcherResult at: #after100) collect: [ :each | each value ])
		hasSameElements: { 42. 50. 26 }.
	self assert: (matcherResult at: #joker) value equals: 1
]

{ #category : #tests }
PTLPatternMatcherTest >> testIntegerMatcher [
	| pattern |
	pattern := 100 asMatcher.
	self assert: (pattern match: 100) isMatch.
	self deny: (pattern match: 900) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testJoker3 [
	| pattern matcherResult  |
	pattern := { 1. 2 . 3. #'@klm'  . 5 . 6 } asMatcher.
	
	matcherResult := (pattern match: {1 . 2 . 3 . 4 . 5 . 6}).
	
	self assert: matcherResult isMatch.
	self assert: (matcherResult at: #klm) equals: 4
 
]

{ #category : #tests }
PTLPatternMatcherTest >> testJokerMatcher [

	| pattern pattern1 pattern2 model model1 matchResult matchResult2 pattern3 patternShorcut pattern1Shorcut pattern2Shorcut pattern3Shorcut |
	pattern := RBSequenceNode suchAs: { (#statements -> { 
			            1.
			            (PTLJokerMatcher new named: #joker) }) } asMatcher.
	pattern1 := RBSequenceNode suchAs: { (#statements -> { 
			             (PTLJokerMatcher new named: #joker).
			             100 }) } asMatcher.
	pattern2 := RBSequenceNode suchAs: { (#statements -> { 
			             (PTLJokerMatcher new named: #first).
			             $*.
			             (PTLJokerMatcher new named: #last) }) } asMatcher.
	pattern3 := RBSequenceNode suchAs: { (#statements -> { 
			             PTLJokerMatcher new.
			             2.
			             99 }) } asMatcher.
	patternShorcut := RBSequenceNode suchAs:
		                  { (#statements -> { 1. #'@joker' }) } asMatcher.
	pattern1Shorcut := RBSequenceNode suchAs:
		                   { (#statements -> { #'@joker'. 100 }) } asMatcher.
	pattern2Shorcut := RBSequenceNode suchAs:
		                   { (#statements -> { #'@first'. #*. #'@last' }) }
			                   asMatcher.
	pattern3Shorcut := RBSequenceNode suchAs:
		                   { (#statements -> { #_. 2. 99 }) } asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestJoker.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestJoker2.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #joker) value equals: 2.
	self deny: (pattern1 match: model) isMatch.
	self deny: (pattern3 match: model) isMatch.
	matchResult2 := pattern2 match: model.
	self assert: (matchResult2 at: #first) value equals: 1.
	self assert: (matchResult2 at: #last) value equals: 5.
	self assert: (pattern1 match: model1) isMatch.
	self assert: ((pattern1 match: model1) at: #joker) value equals: 10.

	"shorcutTest"
	matchResult := patternShorcut match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #joker) value equals: 2.
	self deny: (pattern1Shorcut match: model) isMatch.
	self deny: (pattern3Shorcut match: model) isMatch.
	matchResult2 := pattern2Shorcut match: model.
	self assert: (matchResult2 at: #first) value equals: 1.
	self assert: (matchResult2 at: #last) value equals: 5.
	self assert: (pattern1Shorcut match: model1) isMatch.
	self
		assert: ((pattern1Shorcut match: model1) at: #joker) value
		equals: 10
]

{ #category : #tests }
PTLPatternMatcherTest >> testJokerMatcherAutoAssignedNamed [

	| pattern model matchResult |
	pattern := { (RBSequenceNode suchAs:
		            { (#statements -> RBMessageNode suchAs: { 
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
	pattern := { (RBSequenceNode suchAs:
		            { (#statements -> (RBLiteralNode named: #x)) }) }
		           asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestAbstraction.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestAbstraction2.
	model3 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestAbstraction3.
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
	pattern := RBSequenceNode suchAs:
		           { (#statements -> (RBReturnNode suchAs: { 'klm' })) }
			           asMatcher.
	self assert: (pattern match: [ ^ 'klm' ] sourceNode body) isMatch.
	self deny: (pattern match: [ ^ 'patrick' ] sourceNode body) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchModelRefenceWithConfigurationMatcher2 [

	| pattern pattern2 model1 model2 |
	model1 := [ ^ 'klm' ] sourceNode body.
	model2 := [ ^ 'patrick' ] sourceNode body.
	pattern := RBSequenceNode suchAs:
		           { (#statements -> (RBReturnNode suchAs: { 'klm' })) }
			           asMatcher.
	pattern2 := RBSequenceNode suchAs:
		            { (#statements -> RBReturnNode suchAs: 'klm') }
			            asMatcher.
	self assert: (pattern match: model1) isMatch.
	self assert: (pattern2 match: model1) isMatch.
	self deny: (pattern match: model2) isMatch.
	self deny: (pattern match: model2) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchModelReferenceWithNamedConfiguration [

	| pattern model1 model2 |
	pattern := { (RBSequenceNode suchAs: { (#statements
		             ->
			             { (RBCascadeNode suchAs: { (RBMessageNode suchAs: { 
						               (#receiver -> 100).
						               (#selector -> 'klm') }) }) }) }) } asMatcher.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestMultipleChildrenNamed.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestMultipleChildrenNamed2.
	self assert: (pattern match: model1) isMatch.
	self deny: (pattern match: model2) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchSavedAssociation [

	| matchResult1 matchResult2 matchResult3 matcher | 
	matcher := RBSequenceNode suchAs:
		           { { (#statements
		            -> ((RBReturnNode suchAs: { '4' }) named: #a)) } }
			           asMatcher.
	matchResult1 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest >> #methodTestReturnLiteral4).
	matchResult2 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest
			                 >> #methodTestReturnLiteralComplex).
	matchResult3 := matcher match: (self productFASTPharo:
			                 PTLPatternMatcherTest >> #methodTestReturnString).
	self assert: matchResult1 isMatch.
	self assert: (matchResult1 at: #a) class equals: RBReturnNode.
	self deny: matchResult2 isMatch.
	self deny: matchResult3 isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testMatchTwoLastStatementOfASequence [

	| pattern model matchResult pattern1 matchResult2 |
	pattern := RBSequenceNode suchAs: { (#statements -> { 
			            $*.
			            (PTLJokerMatcher new named: #lastlast).
			            (PTLJokerMatcher new named: #last) }) } asMatcher.
	pattern1 := RBSequenceNode suchAs: { (#statements -> { 
			             $*.
			             (PTLJokerMatcher new named: #beforebefore50).
			             (PTLJokerMatcher new named: #before50).
			             50 }) } asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestEllipsisNode3.
	matchResult := pattern match: model.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #lastlast) value equals: 50.
	self assert: (matchResult at: #last) value equals: 26.
	matchResult2 := pattern1 match: model.
	self assert: matchResult2 isMatch.
	self assert: (matchResult2 at: #before50) value equals: 42.
	self assert: (matchResult2 at: #beforebefore50) value equals: 100
]

{ #category : #tests }
PTLPatternMatcherTest >> testModelReferenceMatcher [

	| pattern |
	pattern := RBReturnNode asMatcher.
	self assert:
		(pattern match: [ ^ 'klm' ] sourceNode statements first) isMatch.
	self deny:
		(pattern match: [ 'klm' ] sourceNode statements first) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testModelReferenceWithMultipleSubPattern [

	| pattern model1 model2 model3 |
	pattern := RBSequenceNode suchAs:
		           { (#statements -> { ((RBAssignmentNode suchAs: { 
				              (#variable -> 'klm').
				              (#value -> 100) }) named: #a) }) } asMatcher.
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
PTLPatternMatcherTest >> testNonApplicativeCondition [

	| pattern |
	pattern := (RBReturnNode
		            suchAs: { (#value -> RBLiteralValueNode named: #x) }
		            like: [ :x | x value isString not ]) asMatcher.
	self
		assert:
		((pattern match: ([ ^ 100 ] sourceNode statements at: 1)) at: #x) value
		equals: 100.
	self deny:
		(pattern match: ([ ^ 'klm' ] sourceNode statements at: 1)) isMatch
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
				              (#selector -> self rBASTSpecificCode).
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
									                                  (PTLJokerMatcher named:
										                                   #cond) }) }) }).
					                               (#selector
					                                -> self rBASTSpecificCode).
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
PTLPatternMatcherTest >> testRangeMatcher [
	| pattern |
	pattern := PTLRangeMatcher from: 5 to: 10.
	self assert: (pattern match: 5) isMatch.
	self assert: (pattern match: 6) isMatch.
	self assert: (pattern match: 10) isMatch.
	self deny: (pattern match: 2) isMatch.
	self deny: (pattern match: 12) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testRangeMatcher2 [
	| pattern |
	pattern := PTLRangeMatcher from: #'@foo' to: 10.
	self assert: (pattern match: 5) isMatch.
	self assert: (pattern match: -5) isMatch.
	self assert: (pattern match: 0) isMatch.
	self assert: (pattern match: 10) isMatch.
	self deny: (pattern match: 12) isMatch.
	self deny: (pattern match: 20) isMatch.
]

{ #category : #tests }
PTLPatternMatcherTest >> testRangeMatcher3 [
	| pattern |
	pattern := Point
		suchAs:
			{(#y -> #'@foo').
			(#x -> (PTLRangeMatcher from: #'@foo' to: 10))}.
	self assert: (pattern match: 7 @ 2) isMatch.
	self assert: (pattern match: 10 @ 2) isMatch.
	self assert: (pattern match: 10 @ 10) isMatch.
	self deny: (pattern match: 5 @ 10) isMatch
]

{ #category : #tests }
PTLPatternMatcherTest >> testRangeMatcher4 [
	| pattern |
	pattern := Point
		suchAs: {(#x -> (PTLRangeMatcher from: 2 to: 10) named: #res)}.
	self assert: ((pattern match: 7 @ 2) at: #res) equals: 7.
	self assert: ((pattern match: 10 @ 2) at: #res) equals: 10.
	self assert: ((pattern match: 10 @ 10) at: #res) equals: 10.
	self assert: ((pattern match: 1 @ 10) at: #res) isNil
]

{ #category : #tests }
PTLPatternMatcherTest >> testRangeMatcher5 [
	| pattern pattern2 |
	pattern := Point
		suchAs: {(#x -> (PTLRangeMatcher from: 2 to: 10) named: #res)}.
	pattern2 := Point
		suchAs: {(#x -> #'2..10' named: #res)}.
	self assert: ((pattern match: 7 @ 2) at: #res) equals: 7.
	self assert: ((pattern match: 10 @ 2) at: #res) equals: 10.
	self assert: ((pattern match: 10 @ 10) at: #res) equals: 10.
	self assert: ((pattern match: 1 @ 10) at: #res) isNil.
	
	self assert: ((pattern2 match: 7 @ 2) at: #res) equals: 7.
	self assert: ((pattern2 match: 10 @ 2) at: #res) equals: 10.
	self assert: ((pattern2 match: 10 @ 10) at: #res) equals: 10.
	self assert: ((pattern2 match: 1 @ 10) at: #res) isNil
]

{ #category : #tests }
PTLPatternMatcherTest >> testSequenceMatcher [

	| pattern model0 model1 model2 mathResult2 |
	pattern := RBSequenceNode suchAs: { (#statements -> { 
			            (RBBlockNode named: #block).
			            (100 named: #int).
			            (RBLiteralNode named: #str) }) } asMatcher.

	model0 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequence.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceIncomplete.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceDirectMatch.
	self deny: (pattern match: model0) isMatch.
	self assert: (pattern match: model1) isMatch.
	mathResult2 := pattern match: model2.
	self assert: mathResult2 isMatch.
	self assert: (mathResult2 at: #block) class equals: RBBlockNode.
	self assert: (mathResult2 at: #int) value equals: 100.
	self assert: (mathResult2 at: #str) class equals: RBLiteralValueNode
]

{ #category : #tests }
PTLPatternMatcherTest >> testSequenceMatcher2 [

	| pattern model0 model1 model2 |
	pattern := RBSequenceNode suchAs: { (#statements -> { 
			            RBBlockNode.
			            100.
			            RBLiteralValueNode }) } asMatcher.
	model0 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequence.
	model1 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceIncomplete.
	model2 := self productFASTPharo:
		          PTLPatternMatcherTest >> #methodTestSequenceDirectMatch.
	self deny: (pattern match: model0) isMatch.
	self assert: (pattern match: model1) isMatch.
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

	| pattern model matchResult compatibility |
	compatibility := self compatibilityStringCompositeMatche2.
	pattern := { (RBSequenceNode suchAs: { (#statements
		             ->
		             (RBMessageNode suchAs: { (#selector -> compatibility) })) }) }
		           asMatcher.

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

{ #category : #tests }
PTLPatternMatcherTest >> testStringMatcher3 [
	| pattern matchResult |
	pattern :=  { 'get' . #'*truc'  . '()' } asMatcher.
	matchResult :=  pattern match:  'getLabel()'.
	self assert: matchResult isMatch.
	self assert: (matchResult at: #truc) equals: 'Label'
]

{ #category : #tests }
PTLPatternMatcherTest >> testTwiceMatchShouldNotModifyAST [

	"this is a non regression test"

	| pattern model matcherResult |
	pattern := { (RBSequenceNode suchAs:
		            { (#statements -> (RBMessageNode suchAs: { 
				              (#receiver -> (PTLJokerMatcher new named: #x)).
				              (#selector -> '+').
				              (#arguments -> (PTLJokerMatcher new named: #x)) })) }) }
		           asMatcher.
	model := self productFASTPharo:
		         PTLPatternMatcherTest >> #methodTestBinOp3.

	matcherResult := pattern match: model.
	self assert: matcherResult isMatch.
	self deny: model statements isEmpty.
	self assert: (pattern match: model) isMatch
]
