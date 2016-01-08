sanato
======

MacOSX (command line) program that allows you to sanitizes file/directory names which are invalid under SMB Shares. This program runs recursively from current working directory looking for file or directory names that includes any of the WARNING or MUST-SWAP characters, if any of the "WARNING" chars are found they will be logged, if any of the MUST-SWAP are found AND the '-s' option is present then those chars in the path will be swapped by '-'.

	Usage: sanato [OPTIONS] <argument> [...]
	   -s, --sanitize                Rename last path components
	   -v, --verbose                 Increase verbosity
	   --version                     Display version and exit
	   -h, --help                    Display this help and exit

Looks for the following sets of characters:

	WARNING SET     |?*<":>/
	MUST-SWAP SET   :?

### Installation and Usage

Download [sanato-1.03.zip](https://github.com/LuisPalacios/sanato/blob/master/download/sanato-1.03.zip) or download this repo and compile with XCode. Place the executable into your PATH. Open a terminal session and run in any of your directories. Firstly without any arguments so it will run in dryrun mode, show what it would do without doing it. When you are ready and happy with the tentative renamings then just run it with -s option.

#### Disclaimer

This is extremely destructive software, it simply renames files, but it can be extremely destructive as you may rename files under BUNDLE's or Application Bundles in MACOSX. Please use it only if you know what you are doing. The objective of this program was to sanitizes filenames invalid under SMB shares. 

### LICENSE

Licensed under [The MIT license](http://www.opensource.org/licenses/mit-license.php)

****

