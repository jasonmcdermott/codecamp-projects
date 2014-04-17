//
//  ViewController.m
//  thirdApp
//
//  Created by Peter Neill on 21/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    int isTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_textImageVIew setHidden:YES];
    [_myTextField setHidden:YES];
    
    _myTextField.delegate = self;
    
    isTextField = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textButton:(id)sender {
    
    NSLog(@"textButton pressed");
    
    if (isTextField == 0) {
        [_textImageVIew setHidden:NO];
        [_myTextField setHidden:NO];
        
        isTextField = 1;
        
    }else{
        [_textImageVIew setHidden:YES];
        [_myTextField setHidden:YES];
        
        isTextField = 0;
        
    }
    

    
    
}
- (IBAction)cameraButton:(id)sender {
    
    NSLog(@"cameraButton pressed");
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:@"Camera Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"Take Photo",
                                    @"Choose from camera roll"
                                    , nil];
    myActionSheet.tag = 2;
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
    
}

-(void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        UIAlertView *noCamera = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"There's no camera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [noCamera show];
        
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

-(void)chooseExistingPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES
                     completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    _bigImageView.image = chosenImage;
    
    _bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)sendButton:(id)sender {
    
    NSLog(@"sendButton pressed");
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:@"Sharing Options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                    @"Share via Email",
                                    @"Share via Text"
                                    , nil];
    myActionSheet.tag = 1;
    [myActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (actionSheet.tag == 1) {
        if (buttonIndex == 2) {
            //do nothing
        }else if (buttonIndex == 1){
            [self sendTextMessage];
        }else if (buttonIndex == 0){
            [self sendEmail];
        }else{
            //do nothing
        }
    } else {
        
        if (buttonIndex == 2) {
            //do nothing
        }else if (buttonIndex == 1){
            [self chooseExistingPhoto];
        }else if (buttonIndex == 0){
            [self takePhoto];

        }else{
            //do nothing
        }
        
        
        
        
    }

    
}

-(void)sendTextMessage
{
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *composer = [[MFMessageComposeViewController alloc]init];
        
        composer.messageComposeDelegate = self;
        
        NSData *imageData = UIImagePNGRepresentation(_bigImageView.image);
        
        [composer addAttachmentData:imageData typeIdentifier:@"public.png" filename:@"image.png"];
        
        composer.body = _myTextField.text;
        
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
    
    [composer setMessageBody:self.myTextField.text isHTML:NO];
    
    NSData *imageData = UIImagePNGRepresentation(_bigImageView.image);
    
    [composer addAttachmentData:imageData mimeType:@"public.png" fileName:@"image.png"];
    
    [self presentViewController:composer animated:YES completion:nil];
    
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%d", self.myTextField.text.length);

    
    if (self.myTextField.text.length > 0) {
        //leave it on the screen
    } else {
        
        [_myTextField setHidden:YES];
        [_textImageVIew setHidden:YES];
        
        isTextField = 0;
        
    }
    
    [_myTextField resignFirstResponder];
    
    return YES;
    
}


@end
