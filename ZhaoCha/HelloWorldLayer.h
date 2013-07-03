//
//  HelloWorldLayer.h
//  ZhaoCha
//
//  Created by panda zheng on 13-5-24.
//  Copyright __MyCompanyName__ 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    /**************数据****************/
    CGPoint posFlag;
    //用来标记点击的位置
    //如果是完全版的找茬游戏，这个位置应该是一个数组，并且不是直接赋值，而是从本地的文件中读取
    
    /**************本类中使用的变量******/
    int         rForClick;
    //用来标记点击区域的半径
    
    
    /**************UI******/
    /*
     如果有些UI不需要被本类外的使用，并且不需要被本类中的多个方法知道
     那么，直接写在init方法中就可以了，不用声明
     */
    
    //对于这个label，是用来标记当用户点击成功之后，输入的话，这个文字标签就需要在初始化方法和点击成功之后两次使用，需要保留一下引用
    CCLabelTTF* labelSucess;

}

//点击之后调用的方法
- (void) judgeByPos:(CGPoint) touchPos;

//判断点是否在点击区域之内
- (BOOL) checkPos:(CGPoint) touchPos;

//点击成功，显示成功提示
- (void) showSuccessResult;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
