//
//  CurrencyList.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/4/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyList : NSObject

@property (nonatomic) NSArray *allCurrencies;

- (instancetype)init NS_UNAVAILABLE;

- (BOOL)isEmpty;

+ (instancetype) currencyList;

@end

NS_ASSUME_NONNULL_END
