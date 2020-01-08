//
//  DataManagerNavigator.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 3/6/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "DataManagerNavigator.h"

@implementation DataManagerNavigator

- (instancetype)initWithDataManager:(DataManager *)dataManager
{
    self = [super init];
    if (self) {
        self.dataManager = dataManager;
    }
    return self;
}

- (void)storeData
{
    [self.dataManager storeData];
}

- (BOOL)loadData
{
    return [self.dataManager loadData];
}

@end
