//
//  HomeViewController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 1/31/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuList.h"
#import "MenuOption.h"
#import "TemperatureConverterController.h"
#import "CountriesTableViewController.h"
#import "ForexController.h"
#import "CurrencyList.h"
#import "TestConnection.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        [MenuList menuOptions];
        [TestConnection testInternetConnection:self];
    }
    return self;
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MenuList menuOptions] allOptions] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *options = [[MenuList menuOptions] allOptions];
    MenuOption *option = options[indexPath.row];
    cell.textLabel.text = option.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        TemperatureConverterController *temperatureConverterController = [[TemperatureConverterController alloc]init];
        
        [self.navigationController pushViewController:temperatureConverterController animated:YES];
    }
    else if(indexPath.row == 1){
        CountriesTableViewController *countriesController = [[CountriesTableViewController alloc]init];
        
        [self.navigationController pushViewController:countriesController animated:YES];
    }
    else if(indexPath.row == 2){
        ForexController *forexController = [[ForexController alloc] init];
        
        [self.navigationController pushViewController:forexController animated:YES];
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
