Class {
	#name : #BaselineOfPTL,
	#superclass : #BaselineOf,
	#category : #BaselineOfPTL
}

{ #category : #baselines }
BaselineOfPTL >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec package: 'PharoTransformationLanguage'.

		spec
			baseline: 'FASTPharo'
			with: [ spec repository: 'github://moosetechnology/FAST-Pharo/src' ] ]
]
