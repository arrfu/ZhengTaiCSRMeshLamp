//
//  LXDelayBlockTimer.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/7/6.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FinishBlock)();

@interface LXDelayBlockTimer : NSObject

@property (nonatomic,assign)float timeInterval; // 调用频率，每隔多少秒调用一次

/**
 * 开始倒计时
 */
-(void)startDelayTimer:(CGFloat)count finishBlock:(FinishBlock)block;

/**
 * 取消延时定时器
 */
-(void)stopDelayTimer;
@end
