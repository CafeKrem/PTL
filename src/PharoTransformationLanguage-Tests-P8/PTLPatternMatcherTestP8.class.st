"
This class contains tests

My responsability is to contain specific test of Pharo 8
"
Class {
	#name : #PTLPatternMatcherTestP8,
	#superclass : #PTLPatternMatcherTest,
	#category : #'PharoTransformationLanguage-Tests-P8'
}

{ #category : #compatibility }
PTLPatternMatcherTestP8 >> compatibilityStringCompositeMatche2 [

	^ { 
		  'set'.
		  ($* named: #x) }
]

{ #category : #compatibility }
PTLPatternMatcherTestP8 >> rBASTSpecificCode [

	^ 'whileTrue:'
]

{ #category : #tests }
PTLPatternMatcherTestP8 >> testJokerMatcher3 [

	| pattern a |
	pattern := RBMessageNode suchAs: { (#selector -> #'@selector') }.
	self
		assert:
			((pattern match: ([ 1 -> 3 ] sourceNode statements at: 1)) at:
				 #selector)
		equals: '->'.
	self
		assert:
			((pattern match: ([ a foo ] sourceNode statements at: 1)) at:
				 #selector)
		equals: 'foo'
]
