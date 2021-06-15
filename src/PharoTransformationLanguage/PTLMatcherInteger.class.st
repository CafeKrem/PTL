"
I'm match integer

example

```language=Pharo
	|pattern|
	  pattern := 100 named: #klm .
	(pattern match: 100) at: #klm. ""100""
	
```
"
Class {
	#name : #PTLMatcherInteger,
	#superclass : #PTLMatcherLiteralEntity,
	#category : #'PharoTransformationLanguage-model'
}

{ #category : #visitor }
PTLMatcherInteger >> accept: aVisitor [

	^ aVisitor visitIntegerMatcher: self
]

{ #category : #action }
PTLMatcherInteger >> rangeMatch: anInteger withContext: aContext [
	^ value
]
