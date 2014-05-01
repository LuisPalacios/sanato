sanato
======

MacOSX command line program that allows you to sanitizes file/directory names. I needed a program that is able to go through the complete subdirectory structure from current working directory, looking for file or directory names containing either the '?' or ':' characters and beaing able to rename those to '-'.

	sanato: Usage [OPTIONS] <argument> [...]
	   -s, --sanitize                Rename last path components
	   -v, --verbose                 Increase verbosity
	       --version                 Display version and exit
	   -h, --help                    Display this help and exit


### Installation and Usage

Download and compile with XCode. Place the resulting executable into your PATH. 

Open a terminal session run in any directory, firstly without any arguments. It will run recursively through subdirectories looking for names with '?' or ':' characters. 

I recommend running first without arguments, so will perform a dry run,
showing what it would do without doing it

When you are ready to go just run it with -s option, last path names found with those characters will be swapped by the '-' character. 



