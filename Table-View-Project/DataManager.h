//
//  DataManager.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 3/6/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

- (void)storeData;
- (BOOL)loadData;

@end

NS_ASSUME_NONNULL_END
