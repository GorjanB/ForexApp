//
//  FetchDataNavigator.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "FetchDataNavigator.h"
#import "FetchData.h"

@implementation FetchDataNavigator

- (instancetype)initWith:(FetchData *)fetchData{
    self = [super init];
    if (self) {
        _fetchData = fetchData;
    }
    return self;
}

@end
