# Pharo-INIFile
Parser for .INI files (as often used on Windows) for [Pharo](https://www.pharo.org)

[![Pharo](https://img.shields.io/static/v1?style=for-the-badge&message=Pharo&color=3297d4&logo=Harbor&logoColor=FFFFFF&label=)](https://www.pharo.org) 

[![Unit Tests](https://github.com/astares/Pharo-INIFile/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/astares/Pharo-INIFile/actions/workflows/unit-tests.yml)
[![Coverage Status](https://codecov.io/github/astares/Pharo-INIFile/coverage.svg?branch=main)](https://codecov.io/gh/astares/Pharo-INIFile/branch/main)


[![Pharo 9](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo 12](https://img.shields.io/badge/Pharo-12-%23aac9ff.svg)](https://pharo.org/download)


# Quick Start

## Installation via Script

```Smalltalk
Metacello new 
	repository: 'github://astares/Pharo-INIFile:main/src';
	baseline: 'INIFile';
	load
```

# Usage
The project includes a class **INIFile** that represent an INI file. An INI file is typically stored
as a file with an *.ini extension and holds initialization values for an application in the following format:

# Examples

## Writing to an INI file
```Smalltalk
|file section stream|
file := INIFile new.
section := file section: 'First section'.
section at: 'key1' put: 'val1'.
section at: 'key2' put: 'val2'.

stream := 'test.ini' asFileReference writeStream.
[file writeOn: stream ] 
    ensure: [ stream close ]
```

The resulting ini file will be:

```
[First section]
key1=val1
key2=val2
```

## Reading from an INI File
```Smalltalk
|file section stream|
stream := 'test.ini' asFileReference readStream.

file := INIFile readFrom: stream.
section := file section: 'First section'.

(section at: 'key1') inspect.

stream close.

file sections inspect"
```
## Reading from an INI File using specific encoding
If you need a specific encoding use one of the encoding schemes:

```Smalltalk
|file section stream|
stream := 'aspnet_perf.ini' asFileReference readStreamEncoded: 'utf16le'.
file := INIFile readFrom: stream.
stream close.
file sections inspect 
```

## Video
[![Watch the video](https://img.youtube.com/vi/Ifqb_vslzTE/hqdefault.jpg)](https://youtu.be/Ifqb_vslzTE)

# History
- moved here from old SmalltalkHub repo: [http://smalltalkhub.com/#!/~TorstenBergmann/INIFile](http://smalltalkhub.com/#!/~TorstenBergmann/INIFile)
