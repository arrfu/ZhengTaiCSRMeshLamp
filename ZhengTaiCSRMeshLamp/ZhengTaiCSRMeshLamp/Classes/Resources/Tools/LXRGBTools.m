//
//  LXRGBTools.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/7/5.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXRGBTools.h"

@implementation LXRGBTools

inline LXRGBType LXRGBTypeMakeWithRGB(CGFloat r, CGFloat g, CGFloat b)
{
    LXRGBType rgb = {r, g, b};
    return rgb;
}

inline LXRGBType LXRGBTypeMakeWithColor(UIColor *color)
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    int r = 255*components[0];
    int g = 255*components[1];
    int b = 255*components[2];

    LXRGBType rgb = {r, g, b};
    return rgb;
}



inline LXHSVType HSVTypeMake(CGFloat h, CGFloat s, CGFloat v)
{
    LXHSVType hsv = {h, s, v};
    return hsv;
}

/**
 * 转化成符合色盘规则的颜色
 */
+(LXRGBType)changedVaildColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue{
    LXRGBType rgb;
    
    if (red > green) {
        if (green > blue) {
            blue = 0;
        }
        else{
            green = 0;
        }
    }
    else{
        if (red > blue) {
            blue = 0;
        }
        else{
            red = 0;
        }
    }
    
    rgb = LXRGBTypeMakeWithRGB(red,green,blue);
    
    return rgb;
}


@end
