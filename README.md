# Pharo-INIFile
Parser for .INI files (as often used on Windows)

#Usage
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
```

## Video
[![Watch the video](https://img.youtube.com/vi/Ifqb_vslzTE/hqdefault.jpg)](https://youtu.be/Ifqb_vslzTE)

# History
- moved here from old SmalltalkHub repo: [http://smalltalkhub.com/#!/~TorstenBergmann/INIFile](http://smalltalkhub.com/#!/~TorstenBergmann/INIFile)
