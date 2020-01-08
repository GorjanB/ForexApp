//
//  CountryDetailsController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/14/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountryDetailsController.h"
#import "ImageUtil.h"
@interface CountryDetailsController ()

@end

@implementation CountryDetailsController

- (UIScrollView *) getScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    return scrollView;
}

- (UIView *)getContentView{
    UIView *contentView = [[UIView alloc] init];
    return contentView;
}

- (UIImageView *) getImageView{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    [imageView setImage:[UIImage imageNamed:@"Brad Cox"]];
    imageView.clipsToBounds = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    return imageView;
}

- (UIVisualEffectView *) getVisualEffectView{
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]init];
    UIBlurEffect *blurEffect = [[UIBlurEffect alloc]init];
    [visualEffect setEffect:blurEffect];
    visualEffect.translatesAutoresizingMaskIntoConstraints = false;
    visualEffect.alpha = 0.0;
    return visualEffect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [self getScrollView];
    self.contentView = [self getContentView];
    self.imageView = [self getImageView];
    self.visualEffectView = [self getVisualEffectView];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.visualEffectView];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    //self.navigationItem.title = @"New Title";
    //UIImage *image = [UIImage imageNamed:@"Brad Cox"];
    //image = [ImageUtil imageWithImage:image scaledToSize:CGSizeMake(40, 40)];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
    
    //self.navigationController.navigationBar.prefersLargeTitles = true;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
    [self.imageView.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant:66.0].active = true;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = true;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = true;
    [self.imageView.heightAnchor constraintEqualToConstant:400.0 + 66.0].active = true;
    
    [self.visualEffectView.centerXAnchor constraintEqualToAnchor:self.imageView.centerXAnchor].active = true;
    [self.visualEffectView.centerYAnchor constraintEqualToAnchor:self.imageView.centerYAnchor].active = true;
    [self.visualEffectView.widthAnchor constraintEqualToAnchor:self.imageView.widthAnchor].active = true;
    [self.visualEffectView.heightAnchor constraintEqualToAnchor:self.imageView.heightAnchor].active = true;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.visualEffectView.alpha = scrollView.contentOffset.y * 1.0 / (self.imageView.frame.size.height - (2.0 * 66.0));
    if(scrollView.contentOffset.y > (self.imageView.frame.size.height - (2.0 * 66.0)) && [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault]!= nil){
    }
    else if (scrollView.contentOffset.y < (self.imageView.frame.size.height - (2.0 * 66.0)) && [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] == nil){
        
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _scrollView.delegate = self;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 1000.0)];
    [self.contentView setFrame:CGRectMake(0.0, 0.0, self.scrollView.contentSize.width, self.scrollView.contentSize.height)];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = @"Country";
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Header";
    label.backgroundColor = UIColor.lightGrayColor;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}


@end
