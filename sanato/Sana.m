//
//  Sana.m
//  sanato
//
//  Created by Luis Palacios on 01/05/14.
//  Copyright (c) 2014 Luis Palacios.
//

#import "Sana.h"

@implementation Sana

-(id)init
{
    if ( (self = [super init]) ) {
        self.stringCharsMustWarn = @"|\?*<\":>/";
        self.stringCharsMustSwap = @":?";
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
    
    printf("\n"
           "  -s, --sanitize                Rename last path components\n"
           "  -v, --verbose                 Increase verbosity\n"
           "      --version                 Display version and exit\n"
           "  -h, --help                    Display this help and exit\n"
           "\n"
           "Looks for the following sets of characters: \n"
           "   WARNING SET     %s\n"
           "   MUST-SWAP SET   %s\n"
           "\n"
           "\n"
           "Runs recursively from current working directory looking for file or directory\n"
           "names that includes any char from the WARNING or MUST-SWAP sets. Upon finding\n"
           "any from the \"WARNING\" set the path will be logged. If finding any from the\n"
           "\"MUST-SWAP\" set and the '-s' option present then those chars in the path will \n"
           "be swapped by '-'\n"
           "\n"
           "I recommend running first without arguments, so it will run in dryrun mode,\n"
           "showing what it would do without doing it\n"
           "\n"
           "When you are ready to go just run it with -s option.\n"
           "\n", self.stringCharsMustWarn.UTF8String, self.stringCharsMustSwap.UTF8String);
    
    
}
- (void) printVersion;
{
    ddprintf(@"%@ version %s\nLuis Palacios, (c)2014\n\n", DDCliApp, "1.03");
}

// -------------------------------------------------------------------------------------

-(void) sana
{
    @autoreleasepool {
        // To store the initial directory
        NSString *initialDir=nil;
        
        // Allways work from the current directory
        NSURL *directoryURL = [NSURL URLWithString:@"."];  // URL pointing to the directory you want to browse
        
        // Define the character sets that I'll warn about and that I'll swap
        NSMutableCharacterSet *charsetMustWarn = [NSCharacterSet characterSetWithCharactersInString:self.stringCharsMustWarn];
        [charsetMustWarn addCharactersInString:self.stringCharsMustSwap]; // Make sure Warn set has also "must swap" set
        NSCharacterSet *charsetMustSwap = [NSCharacterSet characterSetWithCharactersInString:self.stringCharsMustSwap];
        
        
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
                NSLog(@"Current working Directory: \e[1;32m%@\e[m", initialDir);
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
                NSString *lastPathComponent = [url lastPathComponent];
                
                // Check if lastPathComponent has any of the "WARNING" set (which includes the MUST-SWAP)
                NSRange rMustWarn = [lastPathComponent rangeOfCharacterFromSet:charsetMustWarn];
                if (rMustWarn.location != NSNotFound) {
                    
                    // lets get ready...
                    NSString* newLastPathComponent=nil;
                    
                    // Final URLs
                    NSURL *oldURL = [dirURL URLByAppendingPathComponent:lastPathComponent];
                    NSURL *newURL = nil;
                    
                    // Colored "oldURL" into strings for nice logging
                    NSString *oldDirectory = [[oldURL path] stringByDeletingLastPathComponent];
                    NSString *oldLastPathComponentedColored = [self sourceString:lastPathComponent withCharset:charsetMustWarn withColorString:@"\e[1;31m"];
                    NSString *oldPathColored = [NSString stringWithFormat:@"%@/%@", oldDirectory, oldLastPathComponentedColored];
                    
                    // Lets also check if between those there is any of the "MUST-SWAP"
                    NSRange rMustSwap = [lastPathComponent rangeOfCharacterFromSet:charsetMustSwap];
                    if (rMustSwap.location != NSNotFound) {
                        
                        
                        //// Replacing wellknown characters (not used, left for future option...)
                        //NSString *sanitized = [lastPathComponent stringByReplacingOccurrencesOfString: @"¢" withString: @"ó"];
                        //sanitized = [sanitized stringByReplacingOccurrencesOfString: @"Ã±" withString: @"ñ"];
                        //NSString* newLastPathComponent = [[sanitized componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@"-"];
                        
                        // Prepare new renamed path name and url
                        newLastPathComponent = [[lastPathComponent componentsSeparatedByCharactersInSet:charsetMustSwap] componentsJoinedByString:@"-"];
                        newURL = [dirURL URLByAppendingPathComponent:newLastPathComponent];
                        
                        if ( _sanitize ) {
                            // Execute it...
                            if ( _verbosity ) {
                                NSLog(@"\e[1;31m  being\e[m < %@", oldPathColored);
                                NSLog(@"\e[1;31mrenamed\e[m > %@", [newURL path]);
                            } else {
                                NSLog(@"\e[1;31mrenamed\e[m > %@", [newURL path]);
                            }
                            // Exec the rename
                            NSError *error;
                            if ( [fileManager moveItemAtURL:oldURL toURL:newURL error:&error] == NO ) {
                                NSLog(@"ERROR !!!  %@", [error localizedDescription]);
                            }
                        } else {
                            // dry run
                            NSLog(@"\e[1;32mwill be\e[m < %@", oldPathColored);
                            NSLog(@"\e[1;32mrenamed\e[m > %@", [newURL path]);
                        }
                    } else {
                        // dry run
                        NSLog(@"\e[1;33mwarning\e[m < %@", oldPathColored);
                    }
                }
            }
        }
    }
}

-(NSString *) sourceString:(NSString*)theString withCharset:(NSCharacterSet*)charsetToColor withColorString:(NSString*)colorString
{
    NSMutableString *string=[NSMutableString string];
    
    NSString *substr = theString;
    NSRange rango = [substr rangeOfCharacterFromSet:charsetToColor];
    if ( rango.location != NSNotFound ) {
        while  (rango.location != NSNotFound) {
            [string appendString:[substr substringToIndex:rango.location]];
            [string appendString:colorString];
            [string appendString:[substr substringWithRange:rango]];
            [string appendString:@"\e[m"];
            substr = [substr substringFromIndex:rango.location+1];
            rango = [substr rangeOfCharacterFromSet:charsetToColor];
        }
        [string appendString:substr];
    }
    else
    {
        string=[theString mutableCopy];
    }
    return string;
}


@end
