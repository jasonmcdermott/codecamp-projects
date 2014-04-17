//
//  MenuScene.m
//  flappyBirdFake
//
//  Created by Simon Strobel on 15.03.14.
//  Copyright (c) 2014 Simon Strobel. All rights reserved.
//

#import "MenuScene.h"
#import "MyScene.h"

@implementation MenuScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
        bg.position = CGPointMake(160,284);
        bg.size = CGSizeMake(320, 568);
        
        SKSpriteNode *playButton = [SKSpriteNode spriteNodeWithImageNamed:@"playBtn.png"];
        
        playButton.position = CGPointMake(self.size.width/2, self.size.height/2);
        playButton.size = CGSizeMake(200, 100);
        playButton.name = @"playButton";
        
        [self addChild:bg];
        [self addChild:playButton];
        
        
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"playButton"]) {
        
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        
        MyScene *gameScene = [[MyScene alloc]initWithSize:CGSizeMake(self.size.width, self.size.height)];
        
        [self.scene.view presentScene:gameScene transition:transition];
        
    }
    
    
    
    
    
}




@end
