//
//  ViewController.m
//  mapProject
//
//  Created by Peter Neill on 22/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "ViewController.h"
#import "myAnnotationClass.h"

@interface ViewController ()

{
    int textFieldShowing;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _myMapView.delegate = self;
    
    _whyTextField.delegate = self;
    _feelingTextField.delegate = self;
    
    [_backgroundImageView setHidden:YES];
    [_feelingTextField setHidden:YES];
    [_whyTextField setHidden:YES];
    [_closeButton setHidden:YES];
    [_doneButton setHidden:YES];
    
    textFieldShowing = 0;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    

    CLLocationCoordinate2D zoomLocation;
    
    zoomLocation.latitude = _myMapView.userLocation.coordinate.latitude;
    zoomLocation.longitude = _myMapView.userLocation.coordinate.longitude;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(zoomLocation, 500, 500);
    
    [_myMapView setRegion:region animated:YES];
    
    
    
}

- (IBAction)dropPin:(id)sender {
    
    if (textFieldShowing == 0) {
        
        [_backgroundImageView setHidden:NO];
        [_feelingTextField setHidden:NO];
        [_whyTextField setHidden:NO];
        [_closeButton setHidden:NO];
        [_doneButton setHidden:NO];
        
        textFieldShowing = 1;
        
    } else {
        
        [_backgroundImageView setHidden:YES];
        [_feelingTextField setHidden:YES];
        [_whyTextField setHidden:YES];
        [_closeButton setHidden:YES];
        [_doneButton setHidden:YES];
        
        textFieldShowing = 0;
    }
    
    
}
- (IBAction)closeButton:(id)sender {
    
    [self dropPin:nil];
}
- (IBAction)doneButton:(id)sender {
    
    [_whyTextField resignFirstResponder];
    [_feelingTextField resignFirstResponder];
    
    [_backgroundImageView setHidden:YES];
    [_feelingTextField setHidden:YES];
    [_whyTextField setHidden:YES];
    [_closeButton setHidden:YES];
    [_doneButton setHidden:YES];
    
    textFieldShowing = 0;
    
    CLLocationCoordinate2D pinLocation;
    
    pinLocation.latitude = _myMapView.userLocation.location.coordinate.latitude;
    pinLocation.longitude = _myMapView.userLocation.location.coordinate.longitude;
    
    myAnnotationClass *newAnnotation = [[myAnnotationClass alloc]initWithTitle:_feelingTextField.text andCoordinate:pinLocation];
    
//    newAnnotation.coordinate = pinLocation;
//    newAnnotation.title = _feelingTextField.text;
    newAnnotation.subtitle = _whyTextField.text;
    
    [_myMapView addAnnotation:newAnnotation];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self doneButton:nil];
    
    return YES;
    
}



@end
