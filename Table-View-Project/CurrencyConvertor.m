//
//  CurrencyConvertor.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/19/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CurrencyConvertor.h"
#import "info.m"

@implementation CurrencyConvertor

- (void) changeCurrency: (NSString *)from_value To: (NSString *) to_value Amount:(nonnull NSString *)amount callback:(void (^)(double convert_value))callback
{
    if([from_value isEqualToString:to_value]){
            callback([amount doubleValue]);
    }
    else{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSString *urlString = URL_EXCHANGERATES;
        NSMutableString *mutableString = [[NSMutableString alloc] initWithString:urlString];
        [mutableString appendString:[NSString stringWithFormat:(@"?base=%@"),from_value]];
        NSString *urlStr = [NSString stringWithString:mutableString];
        NSURL *url = [NSURL URLWithString:urlStr];
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(data != nil){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                NSDictionary *currencies = [dict valueForKey:@"rates"];
                double amount_to_convert = [amount doubleValue];
                NSLog(@"Amount to convert = %f",amount_to_convert);
                double conversion_rate = [[currencies valueForKey:[NSString stringWithFormat:(@"%@"),to_value]] doubleValue];
                NSLog(@"Conversion rate = %f", conversion_rate);
                double conversion_value = amount_to_convert * conversion_rate;
                NSLog(@"Conversion value = %f",conversion_value);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    callback(conversion_value);
                });
            }
            else{
            }
        }]
         resume];
    });
    }
}
@end
