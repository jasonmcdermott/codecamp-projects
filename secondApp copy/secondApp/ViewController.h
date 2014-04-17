//
//  ViewController.h
//  secondApp
//
//  Created by Peter Neill on 20/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController



@property (weak, nonatomic) IBOutlet UILabel *myLabel;


@property (weak, nonatomic) IBOutlet UIButton *changeColour;


- (IBAction)changeColourAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *myTextField;


@property (weak, nonatomic) IBOutlet UIButton *doneButton;


- (IBAction)doneButton:(id)sender;




@end
