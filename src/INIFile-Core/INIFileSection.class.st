"
I represent a section within an INI file.
"
Class {
	#name : #INIFileSection,
	#superclass : #Object,
	#instVars : [
		'iniFile',
		'label'
	],
	#category : #'INIFile-Core-Model'
}

{ #category : #'instance creation' }
INIFileSection class >> named: nameString on: anINIFile [
	^ self basicNew initializeWithINIFile: anINIFile label: nameString
]

{ #category : #'instance creation' }
INIFileSection class >> on: anINIFile label: labelString [ 
	^ self basicNew initializeWithINIFile: anINIFile label: labelString
]

{ #category : #accessing }
INIFileSection >> addAll: assocCollection [
	assocCollection associationsDo:
		[:assoc | self at: assoc key put: assoc value]
]

{ #category : #accessing }
INIFileSection >> associations [
	^ Array streamContents:
		[:stream | self associationsDo: [:ea | stream nextPut: ea]]
]

{ #category : #accessing }
INIFileSection >> associationsDo: aBlock [
	self iniFile section: self label associationsDo: aBlock
]

{ #category : #accessing }
INIFileSection >> at: keyString [
	^ self at: keyString ifAbsent: [self error: 'No value specified for key in section']
]

{ #category : #accessing }
INIFileSection >> at: keyString ifAbsent: aBlock [
	^ self iniFile section: self label at: keyString ifAbsent: aBlock
]

{ #category : #accessing }
INIFileSection >> at: keyString put: valueString [
	^ self iniFile section: self label at: keyString put: valueString
]

{ #category : #private }
INIFileSection >> iniFile [
	^ iniFile
]

{ #category : #initialization }
INIFileSection >> initializeWithINIFile: anINIFile label: labelString [
	iniFile := anINIFile.
	label := labelString.
]

{ #category : #testing }
INIFileSection >> isEmpty [
	self associationsDo: [:ea | ^ false].
	
	^ true
]

{ #category : #private }
INIFileSection >> label [
	^ label
]

{ #category : #private }
INIFileSection >> writeOn: aStream [
	aStream nextPutAll: '[', self label, ']'; cr.
	self associationsDo:
		[:assoc | aStream nextPutAll: assoc key, '=', (assoc value ifNil: ['']); cr]
]
