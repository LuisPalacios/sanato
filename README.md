sanato
======

MacOSX cmd line to sanitizes file/directory names 


sanato version 1.02
Luis Palacios, 2014

sanato: Usage [OPTIONS] <argument> [...]

  -s, --sanitize                Rename last path components
  -v, --verbose                 Increase verbosity
      --version                 Display version and exit
  -h, --help                    Display this help and exit

Looks for ':' or '?' in file and directory names, renaming them to '-'

Open a terminal session on your macosx, run in any directory, will recursively
go through subdirectories looking for names with such characters and swap them
by '-' when found.

I recommend running first without arguments, so will perform a dry run,
showing what it would do without doing it

When you are ready to go just run it with -s option.

