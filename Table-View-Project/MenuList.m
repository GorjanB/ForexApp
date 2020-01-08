//
//  MenuList.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 1/31/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "MenuList.h"
#import "MenuOption.h"

@interface MenuList()


@end



@implementation MenuList

- (instancetype)initPrivate
{
    self = [super init];
    if(self){
        _allOptions = [[NSMutableArray alloc] init];

        MenuOption *option0 = [[MenuOption alloc] init];
        option0.name = @"Temperature Converter";
        
        MenuOption *option1 = [[MenuOption alloc] init];
        option1.name = @"Countries";
        
        MenuOption *option2 = [[MenuOption alloc] init];
        option2.name = @"Forex";
        
        _allOptions = @[option0,option1,option2];
    }
    return self;
}

+ (instancetype) menuOptions
{
    static MenuList *menuOptions = nil;
    
    if(!menuOptions){
        menuOptions = [[self alloc] initPrivate];
    }
    return menuOptions;
}

@end
