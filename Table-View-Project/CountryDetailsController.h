//
//  CountryDetailsController.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/14/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryDetailsController : UITableViewController<UIScrollViewDelegate,UITableViewDelegate>

@property UIScrollView *scrollView;
@property UIView *contentView;
@property UIImageView *imageView;
@property UIVisualEffectView *visualEffectView;
@end

NS_ASSUME_NONNULL_END
