//
//  CountryDetailsScrollController.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/15/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Country;
NS_ASSUME_NONNULL_BEGIN

@interface CountryDetailsScrollController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property UITableView *tableView;
@property UIView *contentView;
@property UIImageView *imageView;
@property UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) Country *country;
@end

NS_ASSUME_NONNULL_END
