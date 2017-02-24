//
//  LXLogTools.m
//  bluetoothDemo
//
//  Created by hao123 on 16/8/13.
//  Copyright © 2016年 SCU. All rights reserved.
//

#import "LXLogTools.h"

@implementation LXLogTools

+(void)logArray:(uint8_t*)buffer length:(NSInteger)len{
    NSMutableString *tempMStr=[[NSMutableString alloc] init];
    for (int i=0;i<len;i++)
        [tempMStr appendFormat:@"%02x ",buffer[i]];
    LXLog(@"cmd = %@ , len = %ld",tempMStr,(long)len);
}

+(void)logNSData:(NSData*)data{
    uint8_t *tempData=(uint8_t *)[data bytes];
    [self logArray:tempData length:data.length];
}

+(void)logArray:(uint8_t *)buffer length:(NSInteger)len Tips:(NSString *)tips{
    NSMutableString *tempMStr=[[NSMutableString alloc] init];
    
    [tempMStr appendFormat:@"%@ ",tips ];
    
    for (int i=0;i<len;i++)
        [tempMStr appendFormat:@"%02x ",buffer[i]];
    LXLog(@"cmd = %@ , len = %ld",tempMStr,(long)len);
}

@end
