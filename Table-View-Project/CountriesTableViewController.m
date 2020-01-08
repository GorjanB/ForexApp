//
//  CountriesTableViewController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/1/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "CountriesTableViewController.h"
#import "CountriesList.h"
#import "Country.h"
#import "CountriesDetailViewController.h"
#import <SVGKit/SVGKit.h>
#import <SVGKit/SVGKImage.h>
#import "CountryTableViewCell.h"
#import "ImageUtil.h"
#import "TestConnection.h"
#import "info.m"
#import "CountryDetailsController.h"
#import "CountryDetailsScrollController.h"
#import "GetDataNavigator.h"
#import "GetCountryList.h"
#import "GetResponse.h"
#import "DataManagerNavigator.h"
#import "CountryDataManager.h"

@interface CountriesTableViewController ()

@property UIActivityIndicatorView *spinner;


@end

@implementation CountriesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestConnection testAPIConnection:URL_COUNTRIES controller:self];
    _spinner = [self getSpinner];
    
    [self.tableView registerClass:[CountryTableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    if([[CountriesList countryList] isEmpty]){
        BOOL loadedCountries = [self loadCountries];
        if(!loadedCountries){
            [self getCountries];
        }
    }
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        [TestConnection testInternetConnection:self];
        [TestConnection testAPIConnection:URL_COUNTRIES controller:self];
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_spinner];
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CountriesList countryList] allCountries] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"UITableViewCell";
    CountryTableViewCell *cell = (CountryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSArray *countries = [[CountriesList countryList] allCountries];
    Country *country = countries[indexPath.row];
    
    cell.textLabel.text = country.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self setDefaultCellImage:cell];
    [self setCellImageFromURL:cell Country:country];
    
    return cell;
}

- (void)setDefaultCellImage:(CountryTableViewCell *)cell
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(40,40), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.imageView.image = blank;
}

- (void)setCellImageFromURL:(CountryTableViewCell *)cell Country:(Country *)country
{
    NSURL *url = [NSURL URLWithString:country.flagURLString];
    [self loadFromURL:url callback:^(UIImage *image){
        if(self.view.window && image != nil){
            cell.imageView.image = [ImageUtil imageWithImage:image scaledToSize:CGSizeMake(40, 40)];
        }
    }];
}

- (void)loadFromURL:(NSURL *)url callback:(void (^)(UIImage * image))callback
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        @try{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        SVGKImage *svgImage = [[SVGKImage alloc] initWithData:imageData];
        UIImage *image = svgImage.UIImage;
        dispatch_async(dispatch_get_main_queue(), ^{
            if(imageData.length > 0){
            callback(image);
            }
        });
        }@catch(NSException *e){}});
}

- (UIActivityIndicatorView *)getSpinner
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [spinner setHidesWhenStopped:TRUE];
    [spinner stopAnimating];
    [spinner setHidden:TRUE];
    return spinner;
}

- (void)reloadInputViews
{
    [_spinner stopAnimating];
    [_spinner setHidden:TRUE];
    [self.view setNeedsDisplay];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryDetailsScrollController *scrollController = [[CountryDetailsScrollController alloc] init];
    
    NSArray *countries = [[CountriesList countryList] allCountries];
    Country *selectedCountry = countries[indexPath.row];
    
    scrollController.country = selectedCountry;
    [self.navigationController pushViewController:scrollController animated:YES];
}

- (BOOL)loadCountries
{
    DataManagerNavigator *dataManagerNavigator = [[DataManagerNavigator alloc] initWithDataManager:[[CountryDataManager alloc] init]];
        return [dataManagerNavigator loadData];
}

- (void)getCountries
{
    DataManagerNavigator *dataManagerNavigator = [[DataManagerNavigator alloc] initWithDataManager:[[CountryDataManager alloc] init]];
    if([[CountriesList countryList] isEmpty]){
        [_spinner startAnimating];
        GetDataNavigator *getDataNavigator = [[GetDataNavigator alloc] initWith:[[GetCountryList alloc] init]];
        [getDataNavigator getData:^(GetResponse * response) {
            if(response.didGetData){
                [dataManagerNavigator storeData];
                [self reloadInputViews];
                [self.view setNeedsDisplay];
                [self.tableView reloadData];
                [self viewDidLoad];
            }
        }];
    }
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

@end
