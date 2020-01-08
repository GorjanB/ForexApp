//
//  CountryDataManager.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 3/6/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountryDataManager.h"
#import "AppDelegate.h"
#import "CountriesList.h"
#import "Country.h"

@implementation CountryDataManager{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}

- (void)storeData
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    CountriesList *countryList = [CountriesList countryList];
    NSArray *countries = [countryList allCountries];
    for(int i=0; i<[countries count]; i++){
        NSManagedObject *countryEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CountryData" inManagedObjectContext:context];
        [countryEntity setValue:[countries[i] valueForKey:@"name"] forKey:@"name"];
        [countryEntity setValue:[countries[i] valueForKey:@"flagURLString"] forKey:@"flagURLString"];
        [countryEntity setValue:[countries[i] valueForKey:@"continent"] forKey:@"continent"];
        NSString *countryPopulation = [[countries[i] valueForKey:@"population"] stringValue];
        [countryEntity setValue:(NSString *)countryPopulation forKey:@"population"];
        [appDelegate saveContext];
    }
    
}

- (BOOL)loadData
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    CountriesList *countryList = [CountriesList countryList];
    countryList.allCountries = [[NSMutableArray alloc] init];
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"CountryData"];
    NSArray *results = [context executeFetchRequest:requestExamLocation error:nil];
    for(int i=0; i<[results count]; i++){
        Country *country = [[Country alloc] init];
        country.name = [results[i] valueForKey:@"name"];
        country.flagURLString = [results[i] valueForKey:@"flagURLString"];
        country.population = [results[i] valueForKey:@"population"];
        country.continent = [results[i] valueForKey:@"continent"];
        [countryList.allCountries addObject:country];
    }
    if([[countryList allCountries] count] > 0){
        return YES;
    }
    else{
        return NO;
    }
}

@end
