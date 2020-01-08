//
//  GetDataNavigator.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "GetDataNavigator.h"
#import "GetResponse.h"
#import "GetResponse.h"

@implementation GetDataNavigator


- (instancetype)initWith:(GetData *)getData{
    
    self = [super init];
    if (self) {
        _dataGetter = getData;
    }
    return self;
}


- (void)getData:(void (^)(GetResponse * response))callback{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        [self.dataGetter getData:^(GetResponse * response) {
            callback(response);
        }];
    });
}



@end
