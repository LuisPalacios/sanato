//
//  Sana.h
//  sanato
//
//  Created by Luis Palacios on 01/05/14.
//  Copyright (c) 2014 Luis Palacios.
//

#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"

/**
 *  @brief  Looks for ':' or '?' in file and directory names, renaming them to '-'
 *  @class  Sana
 *
 *  @author  Luis Palacios
 *  @date    May 1st, 2014
 *
 *  This class allows to perform a sanitize on file and directory names
 *
 */
@interface Sana : NSObject <DDCliApplicationDelegate>
{
    NSString * _output;
    int _verbosity;
    BOOL _sanitize;
    BOOL _version;
    BOOL _help;
}

// OPTION A) no longer used, leaft here as an example
// Define a set of valid characters and rename the inverse set of characters
// bu the character '-'.
//
///**
// * @brief String with all the valid characters
// */
// @property (nonatomic, strong) NSString *addValid;

#pragma mark -
#pragma mark Public Instance Methods

/**
 * @brief Executes the sanitize  of the file and directory names
 *
 * 'sana', from Latin, means heal
 *
 * @return void
 */
-(void) sana;


@end
