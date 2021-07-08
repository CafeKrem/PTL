"
I'm a range Matcher I match if input is between from and to.

example

```language=Pharo
	|pattern|
	  pattern := #1..32 named: #x
	(pattern match: 15) at: #klm. ""15""
``` 

Internal Representation and Key Implementation Points.

    Instance Variables
	from:		<Integer>
	to:		<Integer>


"
Class {
	#name : #PTLRangeMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'from',
		'to'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #accessor }
PTLRangeMatcher class >> from: lower to: upper [
	^ self new
		from: lower asMatcher;
		to: upper asMatcher;
		yourself
]

{ #category : #accessor }
PTLRangeMatcher >> from: anInteger [ 
	from := anInteger
]

{ #category : #'private-running' }
PTLRangeMatcher >> hasMatch: anInteger withContext: aContext [
	| value |
	value := self firstElementOf: anInteger.
	^ (from rangeMatch: value withContext: aContext) <= value
		and: [ value <= (to rangeMatch: value withContext: aContext) ]
]

{ #category : #PTL }
PTLRangeMatcher >> inspectPTLAction [
	"return a collection of children or an empty collection if there is no children"
	^ {  }
]

{ #category : #API }
PTLRangeMatcher >> inspectPTLKey [

	"how to display each matcher "

	^ from asString , '..' , to asString
]

{ #category : #accessor }
PTLRangeMatcher >> to: anInteger [ 
	to := anInteger
]
