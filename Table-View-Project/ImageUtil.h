//
//  ImageUtil.h
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/5/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageUtil : NSObject

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end

NS_ASSUME_NONNULL_END
