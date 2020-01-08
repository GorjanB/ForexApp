//
//  CurrencyConvertor.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/19/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyConvertor : NSObject

- (void) changeCurrency: (NSString *)from_value To: (NSString *) to_value Amount:(nonnull NSString *)amount callback:(void (^)(double convert_value))callback;

@end

NS_ASSUME_NONNULL_END
