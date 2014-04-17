//
//  ViewController.m
//  secondApp
//
//  Created by Peter Neill on 20/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

{
    int isBlue;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _myLabel.text = @"This is my text";
    
    _myLabel.textColor = [UIColor blueColor];
    
    _myLabel.backgroundColor = [UIColor greenColor];
    
    
    isBlue = 0;
    
    _myTextField.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColourAction:(id)sender {
    
    if (isBlue == 0) {

    
    _myLabel.textColor = [UIColor orangeColor];
    _myLabel.backgroundColor = [UIColor blueColor];
        
    _myLabel.text = [NSString stringWithFormat:@"new string %@ string", self.myTextField.text];
        
        isBlue = 1;
        
    }else if (isBlue == 1){
        
        _myLabel.textColor = [UIColor redColor];
        _myLabel.backgroundColor = [UIColor yellowColor];
        
        _myLabel.text = [NSString stringWithFormat:@"second new string %@ string", self.myTextField.text];
        
        isBlue = 2;
        
    }
    else{
        
        _myLabel.textColor = [UIColor blueColor];
        _myLabel.backgroundColor = [UIColor greenColor];
        
        _myLabel.text = [NSString stringWithFormat:@"Hello %@ nice coding!", self.myTextField.text];
        
        isBlue = 0;
        
    }
    
}
- (IBAction)doneButton:(id)sender {
    
    NSString *displayString = [NSString stringWithFormat:@"Hello %@ nice coding!", self.myTextField.text];
    
    _myLabel.text = displayString;
    
    [_myTextField resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *displayString = [NSString stringWithFormat:@"Hello %@ nice coding!", self.myTextField.text];
    
    _myLabel.text = displayString;
    
    [_myTextField resignFirstResponder];
    
    return YES;
    
}
@end
