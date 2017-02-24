//
//  LXLogTools.h
//  bluetoothDemo
//
//  Created by hao123 on 16/8/13.
//  Copyright © 2016年 SCU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXLogTools : NSObject


+(void)logArray:(uint8_t*)buffer length:(NSInteger)len;

+(void)logArray:(uint8_t*)buffer length:(NSInteger)len Tips:(NSString*)tips;

+(void)logNSData:(NSData*)data;

@end
