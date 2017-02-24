//
//  LXColorFilterTool.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/6/14.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXColorFilterTool.h"

@interface LXColorFilterTool(){
    NSTimer *colorTimer; // 延时分段设置颜色，防止一次性发送过多死机
}

@property (nonatomic,strong)NSMutableArray *colorArray; // 颜色滑动缓存
@property (nonatomic,copy)ColorFilterBlock colorFilterBlock;
@end


@implementation LXColorFilterTool
@synthesize timeSpace = _timeSpace;

-(NSMutableArray *)colorArray{
    if (_colorArray == nil) {
        _colorArray = [[NSMutableArray alloc] init];
    }
    
    return _colorArray;
}

-(int)timeSpace{
    if (_timeSpace <= 0) {
        _timeSpace = 500; // 500ms
    }
    
    return _timeSpace;
}

-(void)setTimeSpace:(int)timeSpace{
    if (timeSpace != 0) {
         _timeSpace = timeSpace;
        
    }
   
    [self creatColorTimer];
    
}

-(void)creatColorTimer{
    colorTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeSpace*0.001 target:self selector:@selector(sendColor) userInfo:nil repeats:YES];
    [colorTimer fire];
}

/**
 * 过滤中间颜色
 */
-(NSMutableArray*)filterSomeColor:(UIColor*)color{
    if (self.colorArray.count < 2) {
        [self.colorArray addObject:color];
    }
    else{
        [self.colorArray removeObjectAtIndex:0];
        [self.colorArray addObject:color];
    }
    
    return self.colorArray;
}

/**
 * 开始颜色过滤定时器定时器
 */
-(void)startColorFilterTimerWithColor:(UIColor*)color{
    
    [self filterSomeColor:color];
    
    if (colorTimer == nil) {
        [self creatColorTimer];
    }
    
    
}

/**
 * 设置颜色
 */
-(void)sendColor{
    
    UIColor *colorValue = [[UIColor alloc] init];
    
    if (self.colorArray != nil && self.colorArray.count > 0) {
        colorValue = [[self.colorArray objectAtIndex:0] copy];
        [self.colorArray removeObjectAtIndex:0];
        
        if ( [self.delegate respondsToSelector:@selector(colorFilterTimeToSendColor:)]) {
            [self.delegate colorFilterTimeToSendColor:colorValue];
        }
        
        if (self.colorFilterBlock) {
            self.colorFilterBlock(colorValue);
        }
    }
    else{
        // 缓冲数据获取完，关闭定时器
//        self.colorValue = colorValueChange;
        [self stopColorFilterTimer];
    }
    
    
}

/**
 * 关闭定时器
 */
-(void)stopColorFilterTimer{
    [colorTimer invalidate];
    colorTimer = nil;
}


/**
 * block方式 回调颜色
 */
-(void)setColorFilterTimerWithColorWithColor:(UIColor*)color Block:(ColorFilterBlock)block{
    
    if (block) {
        self.colorFilterBlock = block;
    }
    
    [self filterSomeColor:color];
    
    if (colorTimer == nil) {
        [self creatColorTimer];
    }
    
   
}


@end
