Extension { #name : #BlockClosure }

{ #category : #'*PharoTransformationLanguage' }
BlockClosure >> valueWithDict: aCollection [

	^ self valueWithArguments:
		  (self argumentNames collect: [ :name | aCollection at: name ])
]
