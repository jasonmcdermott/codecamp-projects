//
//  MyScene.h
//  flappyBirdFake
//

//  Copyright (c) 2014 Simon Strobel. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate> {
    
    SKSpriteNode * bird;
    SKSpriteNode *bg;
    
    SKSpriteNode *button;

    
    NSMutableArray * pfostens;
    
    int score;
    
    SKLabelNode *label;
    NSTimer *timer;

    BOOL firstTouch;
}



@end
