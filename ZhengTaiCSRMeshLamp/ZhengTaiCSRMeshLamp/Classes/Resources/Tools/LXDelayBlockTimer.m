//
//  LXDelayBlockTimer.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/7/6.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXDelayBlockTimer.h"



@interface LXDelayBlockTimer(){
    int delayCount; // 延时计数
    NSTimer *delayTimer;
    int totalCount; // 总时间
    FinishBlock finishBlock;
}

@end

@implementation LXDelayBlockTimer



/**
 * 开始倒计时
 */
-(void)startDelayTimer:(CGFloat)count finishBlock:(FinishBlock)block{
//-(void)startDelayTimer:(CGFloat)count finishBlock:(void (^)())block{

    if (self.timeInterval <= 0) {
        self.timeInterval = 1;
    }
    
    delayCount = 0;
    finishBlock = block;
    
    totalCount = count;
    
    [self stopDelayTimer]; // 取消上一定时器
    
    if (delayTimer == nil) {
        delayTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timesCounting) userInfo:nil repeats:YES];
    }
    
    [[NSRunLoop currentRunLoop] addTimer:delayTimer forMode:NSRunLoopCommonModes];
    
}

-(void)timesCounting{
    
    if (delayCount < totalCount) {
        delayCount++;
    }
    else{
        // 时间到
        [self stopDelayTimer]; // 取消上一定时器
        
        if (finishBlock) {
            finishBlock();
        }
    }
    
    LXLog(@"count = %d",delayCount);
    
}

/**
 * 取消延时定时器
 */
-(void)stopDelayTimer{
    [delayTimer invalidate];
    delayTimer = nil;
}

@end
