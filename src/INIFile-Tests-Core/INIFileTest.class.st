Class {
	#name : #INIFileTest,
	#superclass : #TestCase,
	#category : #'INIFile-Tests-Core-Model'
}

{ #category : #tests }
INIFileTest >> testBatchAddition [
	| ini dict |
	ini := INIFile new.
	dict := Dictionary newFrom: {'key1'->'val1'. 'key2'->'val2'}.
	(ini section: 'foo') addAll: dict.
	
	self assert: ((ini section: 'foo') at: 'key1') = 'val1'.
	self assert: ((ini section: 'foo') at: 'key2') = 'val2'.
]

{ #category : #tests }
INIFileTest >> testComplexRead [
	| content in |
	content := '

[bar]
;comment

key1 = val1

key2 = val2
;key2 = oldvalue

;foo heading comment
[foo]
key1=    val1
key2= val with a space in it

'.

	in := INIFile readFrom: content readStream.
	self assert: ((in section: 'foo') at: 'key1') = 'val1'.
	self assert: ((in section: 'foo') at: 'key2') = 'val with a space in it'.
	self assert: ((in section: 'bar') at: 'key1') = 'val1'.
	self assert: ((in section: 'bar') at: 'key2') = 'val2'.
]

{ #category : #tests }
INIFileTest >> testEmptyValueOnRead [
	| content in |
	content := '[foo]
key1 =      '.

	in := INIFile readFrom: content readStream.
	self assert: ((in section: 'foo') at: 'key1') isNil
]

{ #category : #tests }
INIFileTest >> testHasSection [
	| ini section |
	ini := INIFile new.
	section := ini section: 'foo'.
	self deny: (ini includesSection: 'foo').
	section at: 'bar' put: 'baz'.
	self assert: (ini includesSection: 'foo').
	
]

{ #category : #tests }
INIFileTest >> testIteration [
	| ini |
	ini := INIFile new.
	(ini section: 'foo') at: 'key1' put: 'val1'.
	(ini section: 'foo') at: 'key2' put: 'val2'.
	(ini section: 'bar') at: 'key1' put: 'val1'.
	(ini section: 'bar') at: 'key2' put: 'val2'.
	
	self assert: ini sections size = 2.
	ini sectionsDo: [:ea | self assert: ea associations size = 2].
]

{ #category : #tests }
INIFileTest >> testMultipleSections [
	| stream out in |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: 'val1'.
	(out section: 'foo') at: 'key2' put: 'val2'.
	(out section: 'bar') at: 'key1' put: 'val1'.
	(out section: 'bar') at: 'key2' put: 'val2'.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	in := INIFile readFrom: stream contents readStream.
	self assert: ((in section: 'foo') at: 'key1') = 'val1'.
	self assert: ((in section: 'foo') at: 'key2') = 'val2'.
	self assert: ((in section: 'bar') at: 'key1') = 'val1'.
	self assert: ((in section: 'bar') at: 'key2') = 'val2'.
]

{ #category : #tests }
INIFileTest >> testNilValueOnWrite [
	| out expected stream |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: nil.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	expected := '[foo]
key1=
'.
	
	self assert: expected = stream contents

	
]

{ #category : #tests }
INIFileTest >> testSectionIsEmpty [
	| ini section |
	ini := INIFile new.
	section := ini section: 'foo'.
	self assert: section isEmpty.
	section at: 'bar' put: 'baz'.
	self deny: section isEmpty.
	
]

{ #category : #tests }
INIFileTest >> testSingleSection [
	| out stream in foo |
	out := INIFile new.
	(out section: 'foo') at: 'key1' put: 'val1'.
	(out section: 'foo') at: 'key2' put: 'val2'.
	stream := WriteStream on: String new.
	out writeOn: stream.
	
	foo := (INIFile readFrom: stream contents readStream) section: 'foo'.
	self assert: (foo at: 'key1') = 'val1'.
	self assert: (foo at: 'key2') = 'val2'.
]
