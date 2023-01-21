"
I represent an INI file that is typically stored
as a file with an *.ini extension and holds 
initialization values for an application in the following format:

[First section]
key1=val1
key2=val2


To write an INI file:
=============
|file section stream|
file := INIFile new.
section := file section: 'First section'.
section at: 'key1' put: 'val1'.
section at: 'key2' put: 'val2'.

stream := 'test.ini' asFileReference writeStream.
[file writeOn: stream ] 
    ensure: [ stream close ]

To read an INI file:
=============
|file section stream|
stream := 'test.ini' asFileReference readStream.

file := INIFile readFrom: stream.
section := file section: 'First section'.

(section at: 'key1') inspect.

stream close.
"
Class {
	#name : #INIFile,
	#superclass : #Object,
	#instVars : [
		'sectionDictionaries'
	],
	#category : #'INIFile-Core-Model'
}

{ #category : #private }
INIFile class >> addSettingFrom: lineString to: section [
	| stream key value |
	stream := lineString readStream.
	key := (stream upTo: $=) trimBoth.
	value := (stream upToEnd) trimBoth.
	section at: key put: (value isEmpty ifTrue: [nil] ifFalse: [value]).
]

{ #category : #private }
INIFile class >> labelFrom: aString [
	| stream |
	stream := aString readStream.
	stream upTo: $[.
	^ stream upTo: $]
]

{ #category : #private }
INIFile class >> newSectionIn: anINIFile from: aString [
	| stream |
	stream := aString readStream.
	stream upTo: $[.
	^ anINIFile section: (stream upTo: $])
]

{ #category : #'instance creation' }
INIFile class >> readFrom: aStream [
	| section line ini |
	section := nil.
	ini := self new.
	
	[aStream atEnd] whileFalse:
		[line := aStream nextLine trimBoth.
		line isEmpty ifFalse:
			[line first
				caseOf:
					{[$[] -> [section := Dictionary new.  ini sectionDictionaries add: (self labelFrom: line) -> section].
					[$;] -> ["ignore comment line"].}
				otherwise: [section ifNotNil: [self addSettingFrom: line to: section]]]].
	
	^ ini
]

{ #category : #private }
INIFile >> ensureSectionDictionary: label [
	^ (self sectionDictionaries
		detect: [:ea | ea key = label]
		ifNone: [self sectionDictionaries add: label -> Dictionary new]) value
]

{ #category : #testing }
INIFile >> includesSection: label [
	^ self sectionDictionaries anySatisfy: [:each | each key = label ] 
]

{ #category : #accessing }
INIFile >> section: sectionString [
	^ INIFileSection named: sectionString on: self
]

{ #category : #private }
INIFile >> section: label associationsDo: aBlock [
	(self ensureSectionDictionary: label)
		associationsDo: aBlock
]

{ #category : #private }
INIFile >> section: label at: keyString ifAbsent: absentBlock [
	^ (self ensureSectionDictionary: label)
		at: keyString ifAbsent: absentBlock
]

{ #category : #private }
INIFile >> section: label at: keyString put: valueString [
	^ (self ensureSectionDictionary: label)
		at: keyString put: valueString
]

{ #category : #private }
INIFile >> sectionDictionaries [
	^ sectionDictionaries ifNil: [sectionDictionaries := OrderedCollection new]
]

{ #category : #accessing }
INIFile >> sections [
	^ Array streamContents:
		[:stream | self sectionsDo: [:ea | stream nextPut: ea]]
]

{ #category : #accessing }
INIFile >> sectionsDo: aBlock [
	self sectionDictionaries do:
		[:assoc | aBlock value: (INIFileSection on: self label: assoc key)]
]

{ #category : #writing }
INIFile >> writeOn: aStream [
	self sections
		do: [:ea | ea writeOn: aStream]
		separatedBy: [aStream nextPutAll: OSPlatform current lineEnding ]
]
