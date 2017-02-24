//
//  LXLampCircleView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/24.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LXColorStyle)
{
    LXColorStyleColorFull,
    LXColorStyleWarmAndWhite,
};


@interface LXLampCircleView : UIView


/**
 * 切换彩灯或白灯
 */
-(void)switchLampCircleWithType:(LXColorStyle)colorStyle;

@end
