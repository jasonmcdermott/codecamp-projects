//
//  photoViewController.m
//  postcardApp
//
//  Created by Peter Neill on 23/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "photoViewController.h"
#import "keepViewController.h"

@interface photoViewController ()

@end

@implementation photoViewController

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
    
    [_keepButton setHidden:YES];
    [_deleteBUtton setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        UIAlertView *noCamera = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"There's no camera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [noCamera show];
        
    } else {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
    }

    
    
}
- (IBAction)cameraRoll:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES
                     completion:nil];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _myImageView.image = info[UIImagePickerControllerEditedImage];
    
    [_keepButton setHidden:NO];
    [_deleteBUtton setHidden:NO];
    [_takePhoto setHidden:YES];
    [_cameraRoll setHidden:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
    
}
- (IBAction)keepButton:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    keepViewController *KeepVC = [storyboard instantiateViewControllerWithIdentifier:@"keepVC"];
    
    KeepVC.imageFromPhotoVC = _myImageView.image;
    
    [self.navigationController presentViewController:KeepVC animated:YES completion:nil];
    
   
}
- (IBAction)deleteButton:(id)sender {
    
    _myImageView.image = nil;
    
    [_keepButton setHidden:YES];
    [_deleteBUtton setHidden:YES];
    [_takePhoto setHidden:NO];
    [_cameraRoll setHidden:NO];
    
    
}
@end
