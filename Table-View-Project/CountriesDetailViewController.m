//
//  CountriesDetailViewController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountriesDetailViewController.h"
#import "Country.h"
#import <SVGKit/SVGKit.h>
#import <SVGKit/SVGKImage.h>


@interface CountriesDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *coutryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
@property (weak, nonatomic) IBOutlet UILabel *continentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;

@end

@implementation CountriesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Country *country = self.country;
    
    self.coutryNameLabel.text = country.name;
    NSString *population = [NSString stringWithFormat:(@"%@"),country.population ];
    self.populationLabel.text = population;
    self.continentLabel.text = country.continent;
    
    @try{
    NSURL *url = [NSURL URLWithString:self.country.flagURLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    SVGKImage *svgImage = [[SVGKImage alloc] initWithData:data];
    _flagImage.image = svgImage.UIImage;
    }
    @catch (NSException *e){
        NSLog(@"Exception: %@", e);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
