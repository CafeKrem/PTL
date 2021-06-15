Class {
	#name : #PTLMatcherModelVisitor,
	#superclass : #Object,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #visitor }
PTLMatcherModelVisitor >> visitIntegerMatcher: aVisitor [ 
	self subclassResponsibility 
]

{ #category : #visiting }
PTLMatcherModelVisitor >> visitListMatcher: aPTLListMatcher [ 
	self subclassResponsibility 
]
