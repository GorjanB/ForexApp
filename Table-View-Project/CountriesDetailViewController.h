//
//  CountriesDetailViewController.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Country;

NS_ASSUME_NONNULL_BEGIN

@interface CountriesDetailViewController : UIViewController

@property (nonatomic, strong) Country *country;

@end

NS_ASSUME_NONNULL_END
