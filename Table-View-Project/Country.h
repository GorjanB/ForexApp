//
//  Country.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Country : NSObject

@property (strong) NSString *name;
@property (strong) NSString *flagURLString;
@property (strong) NSString *population;
@property (strong) NSString *continent;
@end

NS_ASSUME_NONNULL_END
