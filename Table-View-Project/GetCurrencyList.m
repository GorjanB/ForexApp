//
//  GetCurrencyList.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "GetCurrencyList.h"
#import "CurrencyList.h"
#import "info.m"
#import <UIKit/UIKit.h>
#import "Currency.h"
#import "GetResponse.h"

@implementation GetCurrencyList

- (void)getData:(void (^)(GetResponse * _Nonnull))callback{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_sync(queue, ^{
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:URL_EXCHANGERATES] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                GetResponse *getResponse = [[GetResponse alloc] init];
                getResponse.error = error;
                getResponse.didGetData = NO;
                callback(getResponse);
            }
            else {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSDictionary *currencies = [dict valueForKey:@"rates"];
                NSMutableArray *currenciesNames = [NSMutableArray arrayWithArray:currencies.allKeys];
                [currenciesNames addObject:@"EUR"];
                NSMutableArray *currenciesArray = [[NSMutableArray alloc] init];
                for(NSString *currencyName in currenciesNames){
                    Currency *currency = [[Currency alloc] init];
                    currency.name = currencyName;
                    [currenciesArray addObject:currency];
                }
                CurrencyList *currencyList = [CurrencyList currencyList];
                currencyList.allCurrencies = [currenciesArray copy];
                dispatch_async(dispatch_get_main_queue(), ^{
                    GetResponse *getResponse = [[GetResponse alloc] init];
                    getResponse.didGetData = YES;
                    callback(getResponse);
                });
            }
            
        }]resume];
    
    });
}


@end
