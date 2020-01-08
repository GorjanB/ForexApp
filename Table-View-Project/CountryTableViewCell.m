//
//  CountryTableViewCell.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/5/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountryTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CountryTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 40, 40);
    self.imageView.layer.cornerRadius = 10;
    self.imageView.clipsToBounds = YES;
}

@end
