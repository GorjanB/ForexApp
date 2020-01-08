//
//  GetCountryList.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/28/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "GetCountryList.h"
#import "Country.h"
#import "info.m"
#import <UIKit/UIKit.h>
#import "CountriesList.h"
#import "GetResponse.h"

@implementation GetCountryList

- (void)getData:(void (^)(GetResponse * _Nonnull))callback{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_sync(queue, ^{
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:URL_COUNTRIES] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error,%@", [error localizedDescription]);
                GetResponse *getResponse = [[GetResponse alloc] init];
                getResponse.error = error;
                getResponse.didGetData = NO;
                callback(getResponse);
            }
            else {
                CountriesList *countryList = [CountriesList countryList];
                countryList.allCountries = [[NSMutableArray alloc] init];
                NSArray *arr =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                for (int i =0; i<[arr count]; i++) {
                    Country *country = [[Country alloc] init];
                    country.name = [arr[i] valueForKey:@"name"];
                    country.flagURLString = [arr[i] valueForKey:@"flag"];
                    country.population = [arr[i] valueForKey:@"population"];
                    country.continent = [arr[i] valueForKey:@"subregion"];
                    [countryList.allCountries addObject:country];
                }
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
