"
A baseline for INIFile implementation for Pharo

See [https://github.com/astares/Pharo-INIFile](https://github.com/astares/Pharo-INIFile)
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
				group: 'CI' with: #('Tests');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all') ]
]
