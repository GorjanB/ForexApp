//
//  MenuList.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 1/31/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MenuOption;

@interface MenuList : NSObject

@property (nonatomic) NSArray *allOptions;

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)menuOptions;

@end

NS_ASSUME_NONNULL_END
