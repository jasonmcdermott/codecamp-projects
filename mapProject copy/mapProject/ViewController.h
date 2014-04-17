//
//  ViewController.h
//  mapProject
//
//  Created by Peter Neill on 22/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *myMapView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *dropPin;


- (IBAction)dropPin:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@property (weak, nonatomic) IBOutlet UITextField *feelingTextField;


@property (weak, nonatomic) IBOutlet UITextField *whyTextField;


@property (weak, nonatomic) IBOutlet UIButton *closeButton;


- (IBAction)closeButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *doneButton;


- (IBAction)doneButton:(id)sender;







@end
