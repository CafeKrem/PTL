Class {
	#name : #PTLTelescopeVisuTest,
	#superclass : #TestCase,
	#category : #'PharoTransformationLanguage-visualisaitonTelescope'
}

{ #category : #tests }
PTLTelescopeVisuTest >> testListWithStringMatcherVisu [

	| pattern visitor visu |
	pattern := {1 . 2 . 3 . 4 . 5 }asMatcher.
	visitor := PTLVisuealisationPattern new.
	visu := pattern accept: visitor.
	visitor open: visu
]

{ #category : #tests }
PTLTelescopeVisuTest >> testModelRefenceVisu [

	| pattern visitor visu |
	pattern := RBReturnNode suchAs: { (#value -> 100) }.
	visitor := PTLVisuealisationPattern new.
	visu := pattern accept: visitor.
	1 halt.
	visitor open: visu
]

{ #category : #tests }
PTLTelescopeVisuTest >> testStringVisu [

	| pattern visitor visu |
	pattern := 100 asMatcher.
	visitor := PTLVisuealisationPattern new.
	visu := pattern accept: visitor.
	visitor open: visu
]
