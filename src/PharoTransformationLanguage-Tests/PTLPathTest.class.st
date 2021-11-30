Class {
	#name : #PTLPathTest,
	#superclass : #TestCase,
	#category : #'PharoTransformationLanguage-Tests-tests'
}

{ #category : #tests }
PTLPathTest >> testPathCreation [

	| p |
	p := PTLPath from: 'x'.
	self assert: p path equals: #x.
	
	p := PTLPath from: 'x>y'.
	self assert: p path equals: #'x>y'.
	
	p := 'x>y' asPTLPath.
	self assert: p path equals: #'x>y'.
	
	p := #'x>y' asPTLPath.
	self assert: p path equals: #'x>y'.
]

{ #category : #tests }
PTLPathTest >> testPathResolve [

	| p point |
	p := 'x' asPTLPath.
	point := 4 @ 5.

	self assert: (p resolveOn: point) equals: 4.

	p := 'y' asPTLPath.
	self assert: (p resolveOn: point) equals: 5
]

{ #category : #tests }
PTLPathTest >> testSequencePathResolve [

	| p complexObject |
	complexObject := PTLTestClassA new b: (PTLTestClassB new id: 'myid').

	p := 'b>id' asPTLPath.

	self assert: (p resolveOn: complexObject) equals: 'myid'
]
