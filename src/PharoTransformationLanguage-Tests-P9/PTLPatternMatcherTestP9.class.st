"
This class contains tests
My responsability is to contain specific test of Pharo 9
"
Class {
	#name : #PTLPatternMatcherTestP9,
	#superclass : #PTLPatternMatcherTest,
	#category : #'PharoTransformationLanguage-Tests-P9'
}

{ #category : #tests }
PTLPatternMatcherTestP9 >> compatibilityStringCompositeMatche2 [

	^ RBSelectorNode suchAs: { (RBSelectorNode suchAs: { (#value -> { 
				    'set'.
				    ($* named: #x) }) }) }
]

{ #category : #compatibility }
PTLPatternMatcherTestP9 >> rBASTSpecificCode [

	^ RBSelectorNode suchAs: { 'whileTrue:' }
]
