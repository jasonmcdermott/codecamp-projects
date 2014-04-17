//
//  photoViewController.h
//  postcardApp
//
//  Created by Peter Neill on 23/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface photoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@property (weak, nonatomic) IBOutlet UIButton *takePhoto;

- (IBAction)takePhoto:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *cameraRoll;


- (IBAction)cameraRoll:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *keepButton;

- (IBAction)keepButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *deleteBUtton;


- (IBAction)deleteButton:(id)sender;


@end
