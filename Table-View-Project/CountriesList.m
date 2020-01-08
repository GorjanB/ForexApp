//
//  CountriesList.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountriesList.h"
#import "Country.h"
#import "info.m"
#import <UIKit/UIKit.h>

@interface CountriesList()


@end


@implementation CountriesList


- (instancetype) initPrivate
{
    self = [super init];
    return self;
}

+ (instancetype) countryList
{
    static CountriesList *allCountries = nil;
    
    if(!allCountries){
        allCountries = [[self alloc] initPrivate];
    }
    
    return allCountries;
}

- (BOOL) isEmpty
{
    if([self.allCountries count] == 0){
        return YES;
    }
    else{
        return NO;
    }
}

@end
