//
//  CurrencyDataManager.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 3/7/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CurrencyDataManager.h"
#import "AppDelegate.h"
#import "CurrencyList.h"
#import "Currency.h"

@implementation CurrencyDataManager{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}

- (void)storeData
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    CurrencyList *currencyList = [CurrencyList currencyList];
    NSArray *currencies = [currencyList allCurrencies];
    for(int i=0; i<[currencies count]; i++){
        NSManagedObject *currencyEntity = [NSEntityDescription insertNewObjectForEntityForName:@"CurrencyData" inManagedObjectContext:context];
        [currencyEntity setValue:[currencies[i] valueForKey:@"name"] forKey:@"name"];
        [appDelegate saveContext];
    }
    if([currencies count] > 0){
        NSLog(@"Se izvrsilo");
    }
}

- (BOOL)loadData
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *requestExamLocation = [NSFetchRequest fetchRequestWithEntityName:@"CurrencyData"];
    NSArray *results = [context executeFetchRequest:requestExamLocation error:nil];
    NSMutableArray *currenciesArray = [[NSMutableArray alloc] init];
    for(int i=0; i<[results count]; i++){
        Currency *currency = [[Currency alloc] init];
        currency.name = [results[i] valueForKey:@"name"];
        [currenciesArray addObject:currency];
    }
    CurrencyList *currencyList = [CurrencyList currencyList];
    currencyList.allCurrencies = [currenciesArray copy];
    if([[currencyList allCurrencies] count] > 0){
        return YES;
    }
    else{
        return NO;
    }
}

@end
