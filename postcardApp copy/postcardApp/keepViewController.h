//
//  keepViewController.h
//  postcardApp
//
//  Created by Peter Neill on 23/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface keepViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (nonatomic, strong) UIImage *imageFromPhotoVC;

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;


@property (weak, nonatomic) IBOutlet UITextView *messageTextView;


@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)cancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;


- (IBAction)sendButton:(id)sender;








@end
