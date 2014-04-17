//
//  keepViewController.m
//  postcardApp
//
//  Created by Peter Neill on 23/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "keepViewController.h"

@interface keepViewController ()

@end

@implementation keepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}











- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _mainImageView.image = _imageFromPhotoVC;
    
    _messageTextView.delegate = self;
    _locationTextField.delegate = self;
    
}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([_messageTextView.text isEqualToString:@"Write your message..."]) {
        
        _messageTextView.text = @"";
        
        _messageTextView.textColor = [UIColor blackColor];
    }
    

    
    return YES;
    
}






//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if ([_messageTextView.text isEqualToString:@"Write your message..."]) {
//        
//        _messageTextView.text = @"";
//        
//        _messageTextView.textColor = [UIColor blackColor];
//    }
//    
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    
    if ([_messageTextView.text isEqualToString:@""]) {
        
        _messageTextView.text = @"Write your message...";
        
        _messageTextView.textColor = [UIColor colorWithRed:0.737 green:0.737 blue:0.737 alpha:1.0];
    }


}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_locationTextField resignFirstResponder];
    
    return NO;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [_messageTextView resignFirstResponder];
    }
    return YES;
}


- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sendButton:(id)sender {
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:@"Sharing Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"Share via Email",
                                    @"Share via Text"
                                    , nil];
    myActionSheet.tag = 1;
    
    [myActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    

        if (buttonIndex == 2) {
            //do nothing
        }else if (buttonIndex == 1){
            [self sendTextMessage];
        }else if (buttonIndex == 0){
            [self sendEmail];
        }else{
            //do nothing
        }

    
}

-(void)sendTextMessage
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *composer = [[MFMessageComposeViewController alloc]init];
        
        composer.messageComposeDelegate = self;
    
        
        [self presentViewController:composer animated:YES completion:nil];
    } else {
        UIAlertView *noText = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Unfortunately you can't send text messages" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [noText show];
    }
}

-(void)sendEmail
{
    
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc]init];
    
    composer.mailComposeDelegate = self;
    
    NSData *imageData = UIImagePNGRepresentation([self screenshot]);
    
    [composer addAttachmentData:imageData mimeType:@"public.png" fileName:@"image.png"];
    
    
    [self presentViewController:composer animated:YES completion:nil];
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(UIImage *)screenshot {
    
    [_sendButton setHidden:YES];
    [_cancelButton setHidden:YES];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [_sendButton setHidden:NO];
    [_cancelButton setHidden:NO];
    
    return image;
    
}

@end
