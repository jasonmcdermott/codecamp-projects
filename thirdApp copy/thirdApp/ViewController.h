//
//  ViewController.h
//  thirdApp
//
//  Created by Peter Neill on 21/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;


@property (weak, nonatomic) IBOutlet UIButton *textButton;


- (IBAction)textButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *cameraButton;


- (IBAction)cameraButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;


- (IBAction)sendButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *textImageVIew;


@property (weak, nonatomic) IBOutlet UITextField *myTextField;















@end
