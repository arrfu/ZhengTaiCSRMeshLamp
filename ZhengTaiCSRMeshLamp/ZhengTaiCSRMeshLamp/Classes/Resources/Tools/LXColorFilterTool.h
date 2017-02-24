//
//  LXColorFilterTool.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/14.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ColorFilterBlock)(UIColor *color);

@protocol LXColorFilterToolDelegate <NSObject>

-(void)colorFilterTimeToSendColor:(UIColor*)color;

@end

@interface LXColorFilterTool : NSObject

@property (nonatomic,weak)id<LXColorFilterToolDelegate> delegate;
@property (nonatomic,assign)int timeSpace; // 时间间隔 ms

/**
 * 开始颜色过滤定时器定时器
 */
-(void)startColorFilterTimerWithColor:(UIColor*)color; // delegate

/**
 * block方式 回调颜色
 */
-(void)setColorFilterTimerWithColorWithColor:(UIColor*)color Block:(ColorFilterBlock)block;

/**
 * 关闭定时器
 */
-(void)stopColorFilterTimer;
@end
