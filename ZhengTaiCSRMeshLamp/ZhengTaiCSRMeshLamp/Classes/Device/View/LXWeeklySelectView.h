//
//  LXWeeklySelectView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LXWeeklySelectViewType)
{
    LXWeeklySelectViewTypeOnce, // 单次
    LXWeeklySelectViewTypeEveryDay, // 每天
    LXWeeklySelectViewTypeUserDefie, // 自定义
};


typedef void (^LXWeeklySelectViewBlock)(LXWeeklySelectViewType type,NSInteger repeat);





@interface LXWeeklySelectView : UIView

-(void)setLXWeeklySelectViewBlock:(LXWeeklySelectViewBlock)block;

@end
