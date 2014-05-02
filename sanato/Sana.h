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
 *  @brief  Looks for charset's in file and directory names, renaming if necesary
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

/**
 * @brief String with all the INVALID "warning" characters
 */
@property (nonatomic, strong) NSString *stringCharsMustWarn;

/**
 * @brief String with all the characters that I'll rename to '-'
 */
@property (nonatomic, strong) NSString *stringCharsMustSwap;


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
