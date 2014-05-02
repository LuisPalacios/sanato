/**
 
 sanato (healing), Looks for charset's in file and directory names
 
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
 
 This program uses the ddcli, a framework for building command
 line based Objective-C tools. Its source files are available here:
 http://www.dribin.org/dave/software/#ddcli
 
 */

#import <Foundation/Foundation.h>
#import "DDCommandLineInterface.h"
#import "Sana.h"

int main (int argc, char * const * argv)
{
    return DDCliAppRunWithClass([Sana class]);
}

