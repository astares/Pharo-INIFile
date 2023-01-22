"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestINIFileCore,
	#superclass : #PackageManifest,
	#category : #'INIFile-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestINIFileCore class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'INIFile class' #readFrom: #true)) #'2023-01-22T02:25:58.325105+01:00') )
]

{ #category : #'code-critics' }
ManifestINIFileCore class >> ruleLiteralArrayContainsSuspiciousTrueFalseOrNilRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ManifestINIFileCore class' #ManifestINIFileCore)) #'2023-01-22T02:26:07.678353+01:00') )
]
