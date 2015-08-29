sanato
======

MacOSX (command line) program that allows you to sanitizes file/directory names which are invalid under SMB Shares. This program runs recursively from current working directory looking for file or directory names that includes any of the WARNING or MUST-SWAP characters, if any of the "WARNING" chars are found they will be logged, if any of the MUST-SWAP are found AND the '-s' option is present then those chars in the path will be swapped by '-'.

	Usage: sanato [OPTIONS] <argument> [...]
	   -s, --sanitize                Rename last path components
	   -v, --verbose                 Increase verbosity
	       --version                 Display version and exit
	   -h, --help                    Display this help and exit

Looks for the following sets of characters:

	WARNING SET     |?*<":>/
	MUST-SWAP SET   :?

### Installation and Usage

Download [sanato-1.03.zip](https://github.com/LuisPalacios/sanato/blob/master/download/sanato-1.03.zip) or download this repo and compile with XCode. Place the executable into your PATH. Open a terminal session and run in any of your directories. Firstly without any arguments so it will run in dryrun mode, show what it would do without doing it. When you are ready and happy with the tentative renamings then just run it with -s option.

#### Disclaimer

This is extremely destructive software, it simply renames files, but it can be extremely destructive as you may rename files under BUNDLE's or Application Bundles in MACOSX. Please use it use only if you know what you are doing. The objective of this program was to sanitizes filenames invalid under SMB shares. 

### LICENSE

PLEASE NOTICE that this program may BREAK your Applications or Documents or Libraries because some of them may use special characters ':' and '?' inside their bundles, so USE THIS PROGRAM AT YOUR OWN RISK.

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.


****

