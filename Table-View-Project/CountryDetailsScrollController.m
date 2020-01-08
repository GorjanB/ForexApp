//
//  CountryDetailsScrollController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/15/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountryDetailsScrollController.h"
#import "Country.h"
#import <SVGKit/SVGKit.h>
#import <SVGKit/SVGKImage.h>

@interface CountryDetailsScrollController ()

@end

@implementation CountryDetailsScrollController

- (UITableView *) getTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.translatesAutoresizingMaskIntoConstraints = false;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    return tableView;
}

- (UIView *)getContentView
{
    UIView *contentView = [[UIView alloc] init];
    return contentView;
}

- (UIImageView *) getImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    UIImage *image;
    @try{
        NSURL *url = [NSURL URLWithString:self.country.flagURLString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        SVGKImage *svgImage = [[SVGKImage alloc] initWithData:data];
        image = svgImage.UIImage;
    }
    @catch (NSException *e){
        NSLog(@"Exception: %@", e);
    }
    
    [imageView setImage:image];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

- (UIVisualEffectView *) getVisualEffectView
{
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]init];
    UIBlurEffect *blurEffect = [[UIBlurEffect alloc]init];
    [visualEffect setEffect:blurEffect];
    visualEffect.translatesAutoresizingMaskIntoConstraints = false;
    visualEffect.alpha = 0.0;
    return visualEffect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [self getTableView];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRestorationIdentifier:@"cell"];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.contentView = [self getContentView];
    self.imageView = [self getImageView];
    self.visualEffectView = [self getVisualEffectView];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.visualEffectView];
    
    [self updateViewConstraints];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
    [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant:0.0].active = true;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;
    [self.imageView.heightAnchor constraintEqualToConstant:200].active = true;
    
    [self.visualEffectView.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor].active = true;
    [self.visualEffectView.centerYAnchor constraintEqualToAnchor:self.imageView.centerYAnchor].active = true;
    [self.visualEffectView.widthAnchor constraintEqualToAnchor:self.imageView.widthAnchor].active = true;
    [self.visualEffectView.heightAnchor constraintEqualToAnchor:self.imageView.heightAnchor].active = true;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.visualEffectView.alpha = scrollView.contentOffset.y * 1.0 / (self.imageView.frame.size.height - (2.0 * 66.0));
    if(scrollView.contentOffset.y > (self.imageView.frame.size.height - (2.0 * 66.0)) && [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault]!= nil){
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
    }
    else if (scrollView.contentOffset.y < (self.imageView.frame.size.height - (2.0 * 66.0)) && [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] == nil){
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView setContentOffset:CGPointMake(0, -66.0) animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.tableView setContentSize:CGSizeMake(self.view.bounds.size.width, 1000.0)];
    [self.contentView setFrame:CGRectMake(0.0, -66.0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 3:
            cell.textLabel.text = _country.name;
            return cell;
            break;
        case 4:
            cell.textLabel.text = _country.continent;
            return cell;
            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:(@"%@"), _country.population];
            return cell;
            break;
            
        default:
            break;
    }
    cell.textLabel.text = @"Country";
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 3:
            return @"Country Name";
            break;
        case 4:
            return @"Continent";
            break;
        case 5:
            return @"Population";
            break;
            
        default:
            break;
    }
    return  nil;
}
@end
