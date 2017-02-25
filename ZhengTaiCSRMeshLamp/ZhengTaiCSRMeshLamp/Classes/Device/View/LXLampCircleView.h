//
//  LXLampCircleView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/24.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXRGBTools.h"

typedef NS_ENUM(NSInteger,LXColorStyle)
{
    LXColorStyleColorFull,
    LXColorStyleWarmAndWhite,
};

typedef NS_ENUM(NSInteger,LXGestureState)
{
    LXGestureStateOther, // 其他点击,马上更新
    LXGestureStateBegan, // 手势开始
    LXGestureStateEnd, // 手势结束,延时更新
};

@protocol LXLampCircleViewDelegate <NSObject>
/**
 * 颜色滑动回调
 */
-(void)scrollColorAndWhiteLampColor:(UIColor*)color colorStyle:(LXColorStyle)colorStyle GestureState:(LXGestureState)gestureState;

@end


@interface LXLampCircleView : UIView

@property (nonatomic,weak)id<LXLampCircleViewDelegate> delegate;

/**
 * 切换彩灯或白灯
 */
-(void)switchLampCircleWithType:(LXColorStyle)colorStyle;

@end
