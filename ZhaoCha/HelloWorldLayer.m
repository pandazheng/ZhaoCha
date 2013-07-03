//
//  HelloWorldLayer.m
//  ZhaoCha
//
//  Created by panda zheng on 13-5-24.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        self.isTouchEnabled = YES;
        //init data
        CGPoint posOrign = ccp(445,195);
        //这里的点应该是从本地读取，这里认定是(445,195)
        posFlag = ccp(posOrign.x,320 - posOrign.y);
        
        //点击半径设置为30像素
        rForClick = 30;
        
        //初始化背景图，也就是斑马的图，并添加
        CCSprite *imgBg = [CCSprite spriteWithFile:@"img.jpg"];
        imgBg.anchorPoint = ccp(0,0);
        [self addChild:imgBg];
        
        //初始化文字标签
        labelSucess = [CCLabelTTF labelWithString:@"Found it!" fontName:@"Marker Felt" fontSize:64];
        labelSucess.position = ccp(240,160);
        [self addChild:labelSucess];
        
        labelSucess.visible = NO;
    }
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark logic things
- (void) judgeByPos:(CGPoint)touchPos
{
    if ([self checkPos:touchPos] == YES)
    {
        [self showSuccessResult];
    }
}

- (BOOL) checkPos:(CGPoint)touchPos
{
    float a = touchPos.x - posFlag.x;
    float b = touchPos.y - posFlag.y;
    
    float c = a*a + b*b;
    if (c > rForClick*rForClick)
    {
        return NO;
    }
    
    return YES;
}

- (void) showSuccessResult
{
    labelSucess.visible = YES;
}

#pragma mark touch events
- (void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击结束之后，调用
    //获取触摸点的数组
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1)
    {
        //把点做简单的变换
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        
        //判断单击是否正确
        [self judgeByPos:location];
    }
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
