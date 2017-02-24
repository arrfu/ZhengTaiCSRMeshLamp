//
//  LXRGBTools.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/7/5.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGB-HSL.h"

@interface LXRGBTools : NSObject

typedef struct {CGFloat r, g, b;} LXRGBType;
typedef struct {CGFloat h, s, v;} LXHSVType;


LXRGBType LXRGBTypeMakeWithRGB(CGFloat r, CGFloat g, CGFloat b);

LXRGBType LXRGBTypeMakeWithColor(UIColor *color);

LXHSVType LXHSVTypeMake(CGFloat h, CGFloat s, CGFloat v);


/**
 * 转化成符合色盘规则的颜色
 */
+(LXRGBType)changedVaildColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;
@end
