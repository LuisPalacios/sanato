sanato
======

MacOSX (command line) program that allows you to sanitizes file/directory names. This program uns recursively from current working directory looking for file or directory names that includes any of the WARNING or MUST-SWAP characters, if any of the "WARNING" chars are found they will be logged, if any of the MUST-SWAP are found and the '-s' option is present then those chars in the path will swapped by '-'.

	sanato: Usage [OPTIONS] <argument> [...]
	   -s, --sanitize                Rename last path components
	   -v, --verbose                 Increase verbosity
	       --version                 Display version and exit
	   -h, --help                    Display this help and exit

Looks for the following sets of characters:

	WARNING SET     |?*<":>/
	MUST-SWAP SET   :?

### Installation and Usage

Download [sanato-1.03.zip](https://github.com/LuisPalacios/sanato/blob/master/download/sanato-1.03.zip) or Clone this repo and compile with XCode. Place the executable into your PATH. Open a terminal session run in any directory, firstly without any arguments so it will run in dryrun mode, show what it would do without doing any renaming. When you are ready and happy with the tentative renamings then just run it with -s option.

### LICENSE

PLEASE NOTICE that this program may BREAK your Applications or Documents. Be aware that some applications, documents or libraries may use special characters ':' and '?' inside their bundles, so USE THIS PROGRAM AT YOUR OWN RISK

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

