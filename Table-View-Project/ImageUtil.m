//
//  ImageUtil.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/5/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
