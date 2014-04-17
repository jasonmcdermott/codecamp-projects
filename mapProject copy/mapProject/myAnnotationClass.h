//
//  myAnnotationClass.h
//  mapProject
//
//  Created by Peter Neill on 22/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface myAnnotationClass : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

-(id)initWithTitle:(NSString *)ttl andCoordinate: (CLLocationCoordinate2D)c2d;

@end
