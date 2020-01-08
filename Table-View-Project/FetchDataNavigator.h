//
//  FetchDataNavigator.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchCurrencyList.h"
#import "FetchData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FetchDataNavigator : NSObject

@property FetchData *fetchData;

- (instancetype)init NS_UNAVAILABLE;

-(instancetype) initWith:(FetchData *)fetchData;

@end

NS_ASSUME_NONNULL_END
