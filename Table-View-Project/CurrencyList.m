//
//  CurrencyList.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/4/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CurrencyList.h"
#import "info.m"
#import <UIKit/UIKit.h>
#import "Currency.h"

@interface CurrencyList()


@end

@implementation CurrencyList

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[CountryList countryList]" userInfo:nil];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    return self;
}

- (BOOL)isEmpty
{
    if([self.allCurrencies count] == 0){
        return YES;
    }
    else{
        return NO;
    }
}

+ (instancetype) currencyList
{
    static CurrencyList *currencyList = nil;
    if(!currencyList){
    currencyList = [[self alloc] initPrivate];
    }
    
    return currencyList;
}

@end
