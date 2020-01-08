//
//  ForexController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 2/4/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "ForexController.h"
#import "CurrencyList.h"
#import "TestConnection.h"
#import "info.m"
#import "CurrencyConvertor.h"
#import "Currency.h"
#import "GetDataNavigator.h"
#import "GetCurrencyList.h"
#import "GetResponse.h"
#import "DataManagerNavigator.h"
#import "CurrencyDataManager.h"

@interface ForexController ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *currencyFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *currencyToTextField;
@property (strong,nonatomic) NSArray *currencies;
@property (weak, nonatomic) IBOutlet UITextField *valueFromTF;
@property (weak, nonatomic) IBOutlet UITextField *valueToTF;
@property UIPickerView *picker;
@property CurrencyConvertor *currencyConvertor;
@property UIActivityIndicatorView *spinner;

@end

@implementation ForexController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [TestConnection testInternetConnection:self];
    [TestConnection testAPIConnection:URL_EXCHANGERATES controller:self];
    _spinner = [self getSpinner];
    
    if([[CurrencyList currencyList] isEmpty]){
        BOOL loadedCurrencies = [self loadCurrencies];
        if(!loadedCurrencies){
            [self getCurrencies];
        }
    }
    
    _currencyConvertor = [[CurrencyConvertor alloc] init];
    _currencies = [[CurrencyList currencyList] allCurrencies];
    
    [self setupPicker];
    
    _currencyFromTextField.inputView = _picker;
    _currencyToTextField.inputView = _picker;
    
    _valueFromTF.keyboardType = UIKeyboardTypeNumberPad;
    _valueToTF.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)viewDidLayoutSubviews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_spinner];
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)changedEditingFromTF:(UITextField *)sender
{
    NSLog(@"Amount to convert = %@",_valueFromTF.text);
    
    [_currencyConvertor changeCurrency:_currencyFromTextField.text To:_currencyToTextField.text Amount:_valueFromTF.text callback:^(double currency){
        self->_valueToTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];
}

- (IBAction)changedEditingToTF:(UITextField *)sender
{
    NSLog(@"%@",_valueToTF.text);
    NSString *currencyToTF = _currencyToTextField.text;
    NSString *currencyFromTF = _currencyFromTextField.text;
    NSString *amount = _valueToTF.text;
    
    [_currencyConvertor changeCurrency:currencyToTF To:currencyFromTF Amount:amount callback:^(double currency){
        self->_valueFromTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];

}

- (IBAction)endEditingFromTF:(UITextField *)sender
{
    NSLog(@"Amount to convert = %@",_valueFromTF.text);
    
    [_currencyConvertor changeCurrency:_currencyFromTextField.text To:_currencyToTextField.text Amount:_valueFromTF.text callback:^(double currency){
        self->_valueToTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];
    
}

- (IBAction)endEditingToTF:(id)sender
{
    NSLog(@"%@",_valueToTF.text);
    NSString *currencyToTF = _currencyToTextField.text;
    NSString *currencyFromTF = _currencyFromTextField.text;
    NSString *amount = _valueToTF.text;
    
    [_currencyConvertor changeCurrency:currencyToTF To:currencyFromTF Amount:amount callback:^(double currency)
    {
        self->_valueFromTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];
}

- (IBAction)currencyFromChanged:(UITextField *)sender
{
    NSLog(@"CHANGED!");
    NSLog(@"Amount to convert = %@",_valueFromTF.text);
    
    [_currencyConvertor changeCurrency:_currencyFromTextField.text To:_currencyToTextField.text Amount:_valueFromTF.text callback:^(double currency){
        self->_valueToTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];
    
}

- (IBAction)currencyToChanged:(UITextField *)sender
{
    NSLog(@"%@",_valueToTF.text);
    NSString *currencyToTF = _currencyToTextField.text;
    NSString *currencyFromTF = _currencyFromTextField.text;
    NSString *amount = _valueToTF.text;
    
    [_currencyConvertor changeCurrency:currencyToTF To:currencyFromTF Amount:amount callback:^(double currency){
        self->_valueFromTF.text = [NSString stringWithFormat:(@"%.2f"), currency];
    }];
    
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

- (void)setupPicker{
    _picker = [[UIPickerView alloc] init];
    _picker.delegate = self;
    _picker.dataSource = self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_currencies count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Currency *currency = _currencies[row];
    return currency.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(_currencyFromTextField.isEditing){
        Currency *currency = _currencies[row];
        _currencyFromTextField.text = currency.name;
    }
    else if(_currencyToTextField.isEditing){
        Currency *currency = _currencies[row];
        _currencyToTextField.text = currency.name;
    }
}

- (BOOL)loadCurrencies
{
    DataManagerNavigator *dataManagerNavigator = [[DataManagerNavigator alloc] initWithDataManager:[[CurrencyDataManager alloc] init]];
    return [dataManagerNavigator loadData];
}

- (void)getCurrencies
{
    DataManagerNavigator *dataManagerNavigator = [[DataManagerNavigator alloc] initWithDataManager:[[CurrencyDataManager alloc] init]];
    if([[CurrencyList currencyList] isEmpty]){
        [_spinner startAnimating];
        GetDataNavigator *getDataNavigator = [[GetDataNavigator alloc] initWith:[[GetCurrencyList alloc] init]];
        [getDataNavigator getData:^(GetResponse * response) {
            if(response.didGetData){
                [dataManagerNavigator storeData];
                [self reloadInputViews];
                [self.navigationController reloadInputViews];
                [self.view setNeedsDisplay];
                [self viewDidLoad];
            }
        }];
    }
}

@end
