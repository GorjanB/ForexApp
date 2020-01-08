//
//  GetDataNavigator.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetData.h"
#import "GetResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface GetDataNavigator : NSObject

@property GetData *dataGetter;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWith:(GetData *)getData;

- (void)getData:(void (^)(GetResponse *response ))callback;

@end

NS_ASSUME_NONNULL_END
