//
//  MyScene.m
//  flappyBirdFake
//
//  Created by Simon Strobel on 25.02.14.
//  Copyright (c) 2014 Simon Strobel. All rights reserved.
//

#import "MyScene.h"
#import "MenuScene.h"

@implementation MyScene


static const uint32_t birdCategory = 0x1 << 0;
static const uint32_t pfostenCategory = 0x1 << 1;



-(void)spawnPfosten {

    int randomHeight = (arc4random() % (int)self.frame.size.height-150)+250;
    
    //Obere Kante
    SKSpriteNode *pfosten = [SKSpriteNode spriteNodeWithImageNamed:@"oben.png"];
    pfosten.size = CGSizeMake(70,25);
    pfosten.position = CGPointMake(450,randomHeight);
    
    
    //Untere Kante
    SKSpriteNode *bottomNode = [SKSpriteNode spriteNodeWithImageNamed:@"oben.png"];
    bottomNode.size = CGSizeMake(70,25);
    bottomNode.position = CGPointMake(pfosten.position.x, pfosten.position.y-150);

    
    //Unterer Rest
    SKSpriteNode *restBelow = [SKSpriteNode spriteNodeWithImageNamed:@"mitte.png"];
    restBelow.size = CGSizeMake(60,bottomNode.position.y);
    restBelow.position = CGPointMake(pfosten.position.x,bottomNode.position.y-restBelow.size.height/2-bottomNode.size.height/2+1);


    //Oberer Rest
    SKSpriteNode *restAbove = [SKSpriteNode spriteNodeWithImageNamed:@"mitte.png"];
    restAbove.size = CGSizeMake(60,self.frame.size.height+pfosten.position.y);
    restAbove.position = CGPointMake(pfosten.position.x,pfosten.position.y+restAbove.size.height/2+pfosten.size.height/2-2);
    
    [pfostens addObject:pfosten];
    [pfostens addObject:bottomNode];
    [pfostens addObject:restBelow];
    [pfostens addObject:restAbove];
    
    [self addChild:pfosten];
    [self addChild:restBelow];
    [self addChild:bottomNode];
    [self addChild:restAbove];
    //Physics hinzufügen
    for (int i = 0; i < [pfostens count]; i++) {
        
        SKSpriteNode *oneOfThose = [pfostens objectAtIndex:i];
        oneOfThose.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:oneOfThose.frame.size];
        oneOfThose.physicsBody.usesPreciseCollisionDetection = YES;
        oneOfThose.physicsBody.categoryBitMask = pfostenCategory;
        oneOfThose.physicsBody.affectedByGravity = NO;
        oneOfThose.physicsBody.mass = 1000.4;
        oneOfThose.name = [NSString stringWithFormat:@"beforeBird"];
            
    
        
    }
  
    
    
   
}



-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        button = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(100, 30)];
        button.hidden = YES;
        button.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
      
        score = 0;
        pfostens = [[NSMutableArray alloc]init];
        
        bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird.png"];
        bird.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        bird.size = CGSizeMake(30,30);
        bird.zPosition = 5;
        
        bg = [SKSpriteNode spriteNodeWithImageNamed:@"bg.png"];
        bg.position = CGPointMake(160,284);
        bg.size = CGSizeMake(320, 568);
        [self addChild:bg];
        [self addChild:bird];
        
        label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = [NSString stringWithFormat:@"%d",score];
        label.fontSize = 40;
        label.fontColor = [SKColor whiteColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/1.5);
        label.zPosition = 2;
        [self addChild:label];
        
        
        bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bird.frame.size];
        bird.physicsBody.usesPreciseCollisionDetection = YES;
        bird.physicsBody.categoryBitMask = birdCategory;
        bird.physicsBody.dynamic = YES;
        bird.physicsBody.mass = 0.2;
        bird.physicsBody.affectedByGravity = NO;
        
        bird.physicsBody.collisionBitMask = birdCategory | pfostenCategory;
        bird.physicsBody.contactTestBitMask =
        birdCategory | pfostenCategory;
        
        firstTouch = YES;
    
        [self spawnPfosten];
          timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(spawnPfosten) userInfo:nil repeats:YES];

    
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"replayButton"]) {
        
        [self removeFromParent];
        
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        
        MyScene *gameScene = [[MyScene alloc]initWithSize:CGSizeMake(self.size.width, self.size.height)];
        
        [self.scene.view presentScene:gameScene transition:transition];
        
    }

    
    else if ([node.name isEqualToString:@"homeButton"]) {
        
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        
        MenuScene *gameScene = [[MenuScene alloc]initWithSize:CGSizeMake(self.size.width, self.size.height)];
        
        [self.scene.view presentScene:gameScene transition:transition];
        
        
        
    }
    
    
    [bird.physicsBody applyImpulse:CGVectorMake(0.0,60)];
    bird.physicsBody.affectedByGravity = YES;

    
    if (firstTouch == YES) {

        
        firstTouch = NO;
        
    }
    else {
        
        
    }
}


- (void)didMoveToView:(SKView *)view
{
   
    self.physicsWorld.contactDelegate = self;

}


- (void) didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode *firstNode;
    SKSpriteNode *secondNode;
    
    firstNode = (SKSpriteNode *)contact.bodyA.node;
    secondNode = (SKSpriteNode *) contact.bodyB.node;
    
    if ((contact.bodyA.categoryBitMask == birdCategory)
        && (contact.bodyB.categoryBitMask == pfostenCategory))
    {
        [pfostens removeAllObjects];
        [bird.physicsBody setAffectedByGravity:NO];
        [timer invalidate];
        label.fontSize = 30;
        label.text = [NSString stringWithFormat:@"GAME OVER"];
        
        SKSpriteNode *gameOverMenu = [SKSpriteNode spriteNodeWithImageNamed:@"gameOverBg.png"];
        gameOverMenu.position = CGPointMake(self.size.width/2, self.size.height/2);
        gameOverMenu.size = CGSizeMake(300, 250);
        
        [self addChild:gameOverMenu];
        
        SKLabelNode *gameOverLbl = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameOverLbl.text = [NSString stringWithFormat:@"Score: %d",score];
        gameOverLbl.fontSize = 30;
        gameOverLbl.fontColor = [SKColor whiteColor];
        gameOverLbl.position = CGPointMake(gameOverMenu.position.x, gameOverMenu.position.y);
        [self addChild:gameOverLbl];
        
        SKSpriteNode *replayButton = [SKSpriteNode spriteNodeWithImageNamed:@"replayBtn.png"];
        replayButton.position = CGPointMake(gameOverMenu.position.x-80,gameOverMenu.position.y-70);
        replayButton.size = CGSizeMake(100, 40);
        replayButton.name = @"replayButton";
        [self addChild:replayButton];
        
        
        SKSpriteNode *homeButton = [SKSpriteNode spriteNodeWithImageNamed:@"homeButton.png"];
        homeButton.position = CGPointMake(gameOverMenu.position.x+80,gameOverMenu.position.y-70);
        homeButton.size = CGSizeMake(100, 40);
        homeButton.name = @"homeButton";
        [self addChild:homeButton];
        
        

    }
    
}


-(void)update:(CFTimeInterval)currentTime {
    
    
    if ([pfostens count] > 1) {

    SKSpriteNode *sprite = [pfostens objectAtIndex:1];
    
    if (sprite.position.x < bird.position.x && [sprite.name isEqualToString:@"beforeBird"] && sprite.position.x > 0) {
        
        NSLog(@"called other");

        score++;
        label.text = [NSString stringWithFormat:@"%d",score/2];
        sprite.name = @"afterBird";
        

    }
    }
    for (int i = 0; i < [pfostens count]; i++) {
        
        SKSpriteNode * pfosten = [pfostens objectAtIndex:i];
        
        if (pfosten.position.x < -50) {
            
            SKSpriteNode *spNext = [[SKSpriteNode alloc]init];
            spNext = [pfostens objectAtIndex:i+1];
            spNext.position = CGPointMake(spNext.position.x-5, spNext.position.y);
           
            [pfosten removeFromParent];
            [pfostens removeObject:pfosten];
            
            
        }
        
    pfosten.position = CGPointMake(pfosten.position.x-3, pfosten.position.y);


    }
    
  


}

@end
