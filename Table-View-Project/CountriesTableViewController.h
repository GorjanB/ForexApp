//
//  CountriesTableViewController.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountriesTableViewController : UITableViewController

- (void)loadFromURL:(NSURL *)url callback:(void(^)(UIImage *imageData))callback;

@end

NS_ASSUME_NONNULL_END
