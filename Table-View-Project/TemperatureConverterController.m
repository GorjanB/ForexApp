//
//  TemperatureConverterController.m
//  Table-View-Project
//
//  Created by Gorjan Buzharovski on 1/31/19.
//  Copyright © 2019 Gorjan Buzharovski. All rights reserved.
//

#import "TemperatureConverterController.h"

@interface TemperatureConverterController ()<UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *farenheitTextField;
@property (weak, nonatomic) IBOutlet UITextField *celsiusTextField;


@end

@implementation TemperatureConverterController

- (IBAction)celsiusChangedEditing:(UITextField *)sender
{
    NSString *input = sender.text;
    float fvalue = [input floatValue] * (9/5.0) + 32.0;
    _farenheitTextField.text = [NSString stringWithFormat:@"%.2f",fvalue];
}

- (IBAction)farenheitChangedEditing:(UITextField *)sender
{
    NSString *input = sender.text;
    float fvalue = ([input floatValue] - 32.0) * (5/9.0);
    _celsiusTextField.text = [NSString stringWithFormat:@"%.2f",fvalue];
}

- (IBAction)farenheitTextEntered:(UITextField *)sender
{
    NSString *input = sender.text;
    float fvalue = ([input floatValue] - 32.0) * (5/9.0);
    _celsiusTextField.text = [NSString stringWithFormat:@"%.2f",fvalue];
}

- (IBAction)celsiusTextEntered:(UITextField *)sender
{
    NSString *input = sender.text;
    float fvalue = [input floatValue] * (9/5.0) + 32.0;
    _farenheitTextField.text = [NSString stringWithFormat:@"%.2f",fvalue];
}

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
