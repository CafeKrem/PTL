"
I'm a matcher containing a list of matcher. 

So I overide #match:withContext: in order to match every subPattern.


```language=Pharo
	|pattern|
	  pattern :=  {1  . #'*' . 4 } named: #klm asMatcher.
	(pattern match: {1 . 3 . 4  }) at: #klm. ""OrderedCollection new""
	
```

Internal Representation and Key Implementation Points.

    Instance Variables
	matcher:		<Object> , the first matcher of my list.

"
Class {
	#name : #PTLListMatcher,
	#superclass : #PTLMatcherModelEntity,
	#instVars : [
		'matcher'
	],
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #hook }
PTLListMatcher >> hookSaveAction: aValue withContext: aContext [

	savedSelector ifNotNil: [ aContext at: savedSelector put: aValue ]
]

{ #category : #PTL }
PTLListMatcher >> inspectPTLAction [

	| collectionMatcher tmpMatcher |
	collectionMatcher := OrderedCollection new.
	tmpMatcher := matcher.
	collectionMatcher add: tmpMatcher.
	[ tmpMatcher hasNext ] whileTrue: [ 
		tmpMatcher := tmpMatcher next.
		collectionMatcher add: tmpMatcher ].
	^ collectionMatcher
]

{ #category : #PTL }
PTLListMatcher >> inspectPTLKey [

	^ 'list matcher store in ' , savedSelector
]

{ #category : #'as yet unclassified' }
PTLListMatcher >> inspectionPattern [

	<inspectorPresentationOrder: 0 title: 'Pattern'>
	| collectionMatcher tmpMatcher |
	collectionMatcher := OrderedCollection new.
	tmpMatcher := matcher.
	collectionMatcher add: tmpMatcher.
	[ tmpMatcher hasNext ] whileTrue: [ 
		tmpMatcher := tmpMatcher next.
		collectionMatcher add: tmpMatcher ].
	^ SpListPresenter new
		  items: collectionMatcher;
		  display: [ :aMatcher | aMatcher toString ];
		  yourself
]

{ #category : #'private-running' }
PTLListMatcher >> match: aValue withContext: aContext [

	| isMatched matcherTmp tmpValue |
	tmpValue := aValue copy asOrderedCollection.
	matcherTmp := matcher.
	isMatched := matcherTmp match: tmpValue withContext: aContext.
	[ isMatched and: [ matcherTmp hasNext ] ] whileTrue: [ 
		isMatched := matcherTmp next match: tmpValue withContext: aContext.
		matcherTmp := matcherTmp next ].
	isMatched := isMatched and: [ tmpValue isEmpty ].
	isMatched ifTrue: [ 
		self hookSaveAction: aValue withContext: aContext ].
	^ isMatched
]

{ #category : #accessor }
PTLListMatcher >> matcher: aMatcher [
	matcher := aMatcher
]
