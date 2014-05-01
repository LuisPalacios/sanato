/**
 
 sanato (healing), looks for ':' or '?' in file/dir names, renaming to '-'
 
 Copyright (C) 2014  Luis Palacios
 
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

 Created by Luis Palacios on 01/05/14
 
 */

#import "Sana.h"

@implementation Sana

-(id)init
{
    if ( (self = [super init]) ) {
        // OPTION A) no longer used, leaft here as an example
        // Define a set of valid characters and rename the inverse set of characters
        // bu the character '-'.
        //
        // self.addValid = @"'~.,;!¡\"@®#$%^&*()—_-+=|{}[]áéíóúÁÉÍÓÚñÑçÇ€";
    }
    return self;
}

- (void) application: (DDCliApplication *) app
    willParseOptions: (DDGetoptLongParser *) optionsParser
{
    [optionsParser setGetoptLongOnly: YES];
    DDGetoptOption optionTable[] =
    {
        // Long         Short   Argument options
        {"sanitize",   's',    DDGetoptNoArgument},
        {"verbose",    'v',    DDGetoptNoArgument},
        {"version",    0,      DDGetoptNoArgument},
        {"help",       'h',    DDGetoptNoArgument},
        {nil,           0,      0},
    };
    [optionsParser addOptionsFromTable: optionTable];
}

- (int) application: (DDCliApplication *) app
   runWithArguments: (NSArray *) arguments
{
    if (_help)
    {
        [self printHelp];
        return EXIT_SUCCESS;
    }
    
    if (_version)
    {
        [self printVersion];
        return EXIT_SUCCESS;
    }
    
    // Lets rock...
    [self sana];
    
    return EXIT_SUCCESS;
}

- (void) setVerbose: (BOOL) verbose;
{
    if (verbose)
        _verbosity++;
    else if (_verbosity > 0)
        _verbosity--;
}

- (void) printUsage: (FILE *) stream;
{
    [self printVersion];
    ddfprintf(stream, @"%@: Usage [OPTIONS] <argument> [...]\n", DDCliApp);
}
- (void) printHelp;
{
    [self printUsage: stdout];
    
    // OPTION A) no longer used, leaft here as an example
    // Define a set of valid characters and rename the inverse set of characters
    // bu the character '-'.
    //
    //    printf("\n"
    //           "  -s, --sanitize                Rename last path components\n"
    //           "  -v, --verbose                 Increase verbosity\n"
    //           "      --version                 Display version and exit\n"
    //           "  -h, --help                    Display this help and exit\n"
    //           "\n"
    //           "Allow ONLY the following sets of characters: \n"
    //           "   alphanumeric Character Set: \n"
    //           "   whitespace\n"
    //           "   %s\n"
    //           "\n"
    //           "Open a terminal session on your macosx, run in any directory, will recursively\n"
    //           "go through subdirectories looking for names which include a character not in \n"
    //           "the above sets and if found will swap them by the '-' char.\n"
    //           "\n"
    //           "I recommend running first without arguments, so will perform a dry run,\n"
    //           "showing what it would do without doing it\n"
    //           "\n"
    //           "When you are ready to go just run it with -s option.\n"
    //           "\n", [self.addValid UTF8String]);
    
    printf("\n"
           "  -s, --sanitize                Rename last path components\n"
           "  -v, --verbose                 Increase verbosity\n"
           "      --version                 Display version and exit\n"
           "  -h, --help                    Display this help and exit\n"
           "\n"
           "Looks for ':' or '?' in file and directory names, renaming them to '-'\n"
           "\n"
           "Open a terminal session on your macosx, run in any directory, will recursively\n"
           "go through subdirectories looking for names with such characters and swap them\n"
           "by '-' when found.\n"
           "\n"
           "I recommend running first without arguments, so will perform a dry run,\n"
           "showing what it would do without doing it\n"
           "\n"
           "When you are ready to go just run it with -s option.\n"
           "\n");

    
}
- (void) printVersion;
{
    ddprintf(@"%@ version %s\nLuis Palacios, 2014\n\n", DDCliApp, "1.02");
}

// -------------------------------------------------------------------------------------

-(void) sana
{
    @autoreleasepool {
        // To store the initial directory
        NSString *initialDir=nil;
        
        // Allways work from the current directory
        NSURL *directoryURL = [NSURL URLWithString:@"."];  // URL pointing to the directory you want to browse

        // OPTION A) no longer used, leaft here as an example
        // Define a set of valid characters and rename the inverse set of characters
        // bu the character '-'.
        //
        // Define what is valid
        // NSMutableCharacterSet *charactersToKeep = [NSMutableCharacterSet alphanumericCharacterSet];
        // [charactersToKeep addCharactersInString:@" "];
        // [charactersToKeep addCharactersInString:self.addValid];
        // NSCharacterSet *notAllowedChars = [charactersToKeep invertedSet];

        // OPTION B)
        //
        // Define "only" the two characters that I don't want, so any of thess
        // characters in the file or directory name will be swapped by '-'
        NSCharacterSet *notAllowedChars = [NSCharacterSet characterSetWithCharactersInString:@":?"];

        // Lets go through the directories
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
        NSDirectoryEnumerator *enumerator = [fileManager
                                             enumeratorAtURL:directoryURL
                                             includingPropertiesForKeys:keys
                                             options:0
                                             errorHandler:^(NSURL *url, NSError *error) {
                                                 // Handle the error.
                                                 // Return YES if the enumeration should continue after the error.
                                                 return YES;
                                             }];

        // Lets rock...
        for (NSURL *url in enumerator) {
            if ( !initialDir ) {
                initialDir = [[url URLByDeletingLastPathComponent] path];
                NSLog(@"Current working Directory: %@", initialDir);
            }
            NSError *error;
            NSNumber *isDirectory = nil;
            if (! [url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                // handle error
                NSLog(@"Error: %@", [error description]);
            }
            else
            {
                // Separate components
                NSURL *dirURL = [url URLByDeletingLastPathComponent];
                NSString *lastPathComponent = [url lastPathComponent]; //[[url absoluteString] lastPathComponent];
                
                // Check if lastPathComponent has an invalid char
                NSRange r = [lastPathComponent rangeOfCharacterFromSet:notAllowedChars];
                if (r.location != NSNotFound) {
                    
                    //// Replacing wellknown characters
                    //NSString *sanitized = [lastPathComponent stringByReplacingOccurrencesOfString: @"¢" withString: @"ó"];
                    //sanitized = [sanitized stringByReplacingOccurrencesOfString: @"Ã±" withString: @"ñ"];
                    //
                    //// Removing unaccepted characters
                    //NSString* newLastPathComponent = [[sanitized componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@"-"];

                    // Removing unaccepted characters
                    NSString* newLastPathComponent = [[lastPathComponent componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@"-"];

                    // Final URLs
                    NSURL *oldURL = [dirURL URLByAppendingPathComponent:lastPathComponent];
                    NSURL *newURL = [dirURL URLByAppendingPathComponent:newLastPathComponent];

                    if ( _sanitize ) {
                        // Execute it...
                        if ( _verbosity ) {
                            NSLog(@"< %@", [oldURL path]);
                            NSLog(@"> %@  (*renamed*)", [newURL path]);
                        } else {
                            NSLog(@"%@  (*renamed*)", [newURL path]);
                        }
                        
                        // Exec the rename
                        NSError *error;
                        if ( [fileManager moveItemAtURL:oldURL toURL:newURL error:&error] == NO ) {
                            NSLog(@"ERROR !!!  %@", [error localizedDescription]);
                        }
                        
                    } else {
                        // dry run
                        NSLog(@"DRYRUN < %@", [oldURL path]);
                        NSLog(@"DRYRUN > %@", [newURL path]);
                    }
                }
            }
        }
        
    }
}



@end
