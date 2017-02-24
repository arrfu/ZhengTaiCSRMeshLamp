//
//  UIView+JFExtension.m
//  ColorBluetoothLampRedSparrow
//
//  Created by hao123 on 2017/2/16.
//  Copyright © 2017年 snaillove. All rights reserved.
//

#import "UIView+JFExtension.h"

@implementation UIView (JFExtension)

-(void)setJf_x:(CGFloat)jf_x
//- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = jf_x;
    self.frame = frame;
}

-(CGFloat)jf_x
//- (CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setJf_y:(CGFloat)jf_y
//- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = jf_y;
    self.frame = frame;
}

-(CGFloat)jf_y
//- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setJf_centerX:(CGFloat)jf_centerX
//- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = jf_centerX;
    self.center = center;
}

-(CGFloat)jf_centerX
//- (CGFloat)centerX
{
    return self.center.x;
}

-(void)setJf_centerY:(CGFloat)jf_centerY
//- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = jf_centerY;
    self.center = center;
}

-(CGFloat)jf_centerY
//- (CGFloat)centerY
{
    return self.center.y;
}

-(void)setJf_width:(CGFloat)jf_width
//- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = jf_width;
    self.frame = frame;
}

-(CGFloat)jf_width
//- (CGFloat)width
{
    return self.frame.size.width;
}

-(void)setJf_height:(CGFloat)jf_height
//- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = jf_height;
    self.frame = frame;
}

-(CGFloat)jf_height
//- (CGFloat)height
{
    return self.frame.size.height;
}

-(void)setJf_size:(CGSize)jf_size
//- (void)setSize:(CGSize)size
{

    CGRect frame = self.frame;
    frame.size = jf_size;
    self.frame = frame;
}

-(CGSize)jf_size
//- (CGSize)size
{
    return self.frame.size;
}


@end
