//
//  CountriesList.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountriesList : NSObject

@property (nonatomic) NSMutableArray *allCountries;

+ (instancetype)countryList;

- (instancetype)init NS_UNAVAILABLE;

- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
