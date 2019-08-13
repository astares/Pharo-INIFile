"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestINIFileTestsCore,
	#superclass : #PackageManifest,
	#category : #'INIFile-Tests-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestINIFileTestsCore class >> ruleRBCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#INIFileTest)) #'2019-08-13T20:05:31.590234+02:00') )
]
