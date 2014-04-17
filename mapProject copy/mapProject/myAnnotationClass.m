//
//  myAnnotationClass.m
//  mapProject
//
//  Created by Peter Neill on 22/01/2014.
//  Copyright (c) 2014 Peter Neill. All rights reserved.
//

#import "myAnnotationClass.h"

@implementation myAnnotationClass

-(id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d{
    
    _title = ttl;
    _coordinate = c2d;
    return self;
}

@end
