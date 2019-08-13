"
A baseline for INIFile implementation for Pharo
"
Class {
	#name : #BaselineOfINIFile,
	#superclass : #BaselineOf,
	#category : #BaselineOfINIFile
}

{ #category : #baselines }
BaselineOfINIFile >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			"Packages"
			spec 
				package: 'INIFile-Core';
				package: 'INIFile-Tests-Core' with: [ spec requires: #('INIFile-Core') ].
			
			"Groups"	
			spec	
				group: 'Core' with: #('INIFile-Core');
				group: 'Tests' with: #('INIFile-Tests-Core');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all') ]
]
