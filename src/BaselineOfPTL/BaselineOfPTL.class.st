Class {
	#name : #BaselineOfPTL,
	#superclass : #BaselineOf,
	#category : #BaselineOfPTL
}

{ #category : #baselines }
BaselineOfPTL >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'PharoTransformationLanguage';
			package: 'PharoTransformationLanguage-Tests'.

		spec
			for: #'pharo8.x'
			do: [ spec package: 'PharoTransformationLanguage-Tests-P8' ].
		spec
			for: #'pharo9.x'
			do: [ spec package: 'PharoTransformationLanguage-Tests-P9' ] ]
]
