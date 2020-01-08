//
//  DataManagerNavigator.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 3/6/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManagerNavigator : NSObject

@property DataManager *dataManager;

- (void)storeData;
- (BOOL)loadData;

- (instancetype)initWithDataManager:(DataManager *)dataManager;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
