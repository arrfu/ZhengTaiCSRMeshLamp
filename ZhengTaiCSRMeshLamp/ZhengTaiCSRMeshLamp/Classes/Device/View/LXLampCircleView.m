//
//  LXLampCircleView.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/24.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXLampCircleView.h"

#define k_LeftMinAngle (3.926) // 左边弧度位置
#define k_RightMinAngle (5.455) // 右边弧度位置
#define k_TotalAngle (2.0 * M_PI - (k_RightMinAngle-k_LeftMinAngle)) // 总弧度

@interface LXLampCircleView(){
    

    UIImageView *bgImageView;
    

    UIImageView *colorImageView; // 彩灯背景
    
    UIButton *sliderBtn; // 滑动块
    
    LXColorStyle lampColorStyle; // 灯模式 0:彩灯 1：白灯
    LXGestureState gestureState; // 手势状态
}

@end


@implementation LXLampCircleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // 初始化数据
//        [self initDatas];
        
        [self addLampCircleUIWithFrame:frame];
    }
    
    return self;
}

/**
 * 初始化数据
 */
//-(void)initDatas{
//    colorLampDegree = 100;
//    whiteLampDegree = 100;
//}

/**
 * 添加色盘
 */
-(void)addLampCircleUIWithFrame:(CGRect)frame{
    
    CGFloat percent_k = 1.0;
    
    if (Is4S) {
        percent_k = 480/568.0;
    }
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //    bgImageView.image = [UIImage imageNamed:@"img_lamp_plate_outer_ring"];
//    bgImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgImageView];
    bgImageView.userInteractionEnabled = YES;
    
    // 添加彩灯图片
//    CGFloat imageDW = 60*percent_k;
    
    colorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    colorImageView.image = [UIImage imageNamed:@"Control-dmg-color"];
    [self addSubview:colorImageView];
    


//    colorImageView.center = bgImageView.center;
    
    
    // 添加滑动块
    sliderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sliderBtn.frame = CGRectMake(0, 0, 140, 140);
//    sliderBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 140, 140);
    sliderBtn.center = bgImageView.center;
    [self moveSliderThumWithAngle:M_PI_2];
    [sliderBtn setImage:[UIImage imageNamed:@"Control-dmg-Pointer"] forState:UIControlStateNormal];
    [self addSubview:sliderBtn];
    sliderBtn.userInteractionEnabled = NO;
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [bgImageView addGestureRecognizer:panGesture];
    
}

#pragma mark - gesture手势
////拖动手势
-(void) panGesture:(id)sender
{
//    if (powerSwitchBtn.selected == YES) {
//        // 关灯下不获取颜色
//        return ;
//    }
//    
//    if ((lampColorStyle == LXColorStyleWarmAndWhite) && (self.isSupportWarmLevel == NO)) {
//        // 白灯下，不支持冷暖白，不获取颜色
//        return ;
//    }
    
    
    UIPanGestureRecognizer *panGesture = sender;
    
    CGPoint touchpoint = [panGesture locationInView:bgImageView];
    
    //    LXLog(@"%f,%f",touchpoint.x,touchpoint.y);
    //    sliderBtn.center = touchpoint;
    
    // 手势处理
    if (([panGesture state] == UIGestureRecognizerStateBegan) || ([panGesture state] == UIGestureRecognizerStateChanged)) {
        gestureState = LXGestureStateBegan;
    }
    else  {
        gestureState = LXGestureStateEnd;
    }
    
    [self moveSliderThumWithAngle:[self mapPointToCirclePoint:touchpoint]];
    
    
}

/**
 * 将滑动点转化为圆周上的弧度
 */
-(double)mapPointToCirclePoint:(CGPoint)point{
    
    CGPoint center = bgImageView.center;
    //    double radius = (bgImageView.frame.size.width-30) * 0.5;
    double dx = ABS(point.x - center.x);
    double dy = ABS(point.y - center.y);
    double angle = atan(dy / dx);
    if (isnan(angle))
        angle = 0.0;
    
    if (point.x < center.x)
        angle = M_PI - angle;
    
    if (point.y > center.y)
        angle = 2.0 * M_PI - angle;
    
//        LXLog(@"angle = %f",angle);
    
    return angle;
}

/**
 * 滑块滑动处理
 */
-(void)moveSliderThumWithAngle:(double)angle{
    
    
    if (lampColorStyle == LXColorStyleWarmAndWhite) {
        
        CGFloat leftMinAngle = k_LeftMinAngle;
        CGFloat rightMinAngle = k_RightMinAngle;

        // 设置左右两边边界位置
        if ((angle > leftMinAngle) && (angle < rightMinAngle)) {
            
            if (angle > 3*M_PI_2) {
                angle = rightMinAngle;
            }
            else{
                angle = leftMinAngle;
            }
            
            return ;
        }

    }
    
    // 根据角度设置滑块位置
    [self setSliderButtonWithAngle:angle];
    
    
    // 获取对应位置的颜色
//    int degree = lampColorStyle == LXColorStyleColorFull? colorLampDegree:whiteLampDegree;
    [self mapColorWithAngle:angle andBrightness:100];
}

/**
 * 根据角度设置滑块位置
 */
-(void)setSliderButtonWithAngle:(double)angle{
    double radius = (bgImageView.frame.size.width-30) * 0.5;
    
//    CGFloat x1 = bgImageView.center.x + radius*cos(angle);
//    CGFloat y1 = bgImageView.center.y - radius*sin(angle);
    
    // 根据弧度旋转滑块角度
    sliderBtn.transform = CGAffineTransformMakeRotation(0.5 * M_PI-angle);
    
//    sliderBtn.center = CGPointMake(x1, y1);
    
}

#pragma mark - 界面

/**
 * 切换彩灯或白灯
 */
-(void)switchLampCircleWithType:(LXColorStyle)colorStyle{
    
    lampColorStyle = colorStyle;
    
    // 切换为彩色
    if (colorStyle == LXColorStyleColorFull) {
        colorImageView.image = [UIImage imageNamed:@"Control-dmg-color"];
    }
    else{
        // 切换为白灯
        colorImageView.image = [UIImage imageNamed:@"Control-dmg-bacolor"];
    }
}

#pragma mark - 滑动取色

/**
 * 将角度和亮度转化为RGB
 */
-(UIColor*)mapColorWithAngle:(double)angle andBrightness:(CGFloat)brightness{
    
    UIColor *color;
    
    if (lampColorStyle == LXColorStyleColorFull) {
        // 彩灯
        color = [self colorLampFormAngle:angle andBrightness:brightness];
        
    }
    else{
        // 白灯
        
        color = [self whiteLampFormAngle:angle andBrightness:brightness];
        
    }
    

    
    if ([self.delegate respondsToSelector:@selector(scrollColorAndWhiteLampColor:colorStyle:GestureState:)]) {
        [self.delegate scrollColorAndWhiteLampColor:color colorStyle:lampColorStyle GestureState:gestureState];
    }
    
//        bgImageView.backgroundColor = color;
    
//        LXLog(@"color = %@",color);
    
    return color;
}

/**
 * 根据角度转换为彩灯颜色
 */
-(UIColor*)colorLampFormAngle:(double)angle andBrightness:(CGFloat)brightness{
    
    //    brightness = brightness<=1? 1:brightness;
    
    float sat = brightness/100.0f;
    float hue = angle / (2 * M_PI);
    float ver = brightness/100.0f;
    
    //     UIColor *color =  [UIColor colorWithHue:hue saturation:1.0f brightness:1.0f alpha:1.0f];
    
    UIColor *color =  [UIColor colorWithHue:hue saturation:1.0f brightness:ver alpha:1.0f];
    
    
    
    return color;
}

/**
 * 根据角度转换为白灯颜色
 */
-(UIColor*)whiteLampFormAngle:(double)angle andBrightness:(CGFloat)brightness{
    
    UIColor *color = [UIColor whiteColor];
    
    angle = [self transformToFanAngle:angle];
    
    CGFloat value = angle / k_TotalAngle; // 获得
    
    value = 1-value;
    color = [UIColor colorWithRed:value green:0 blue:0 alpha:0];
    
    //    LXLog(@"color == %@",color);
    //    LXLog(@"brfore angle == %f",angle);
    //
    //    LXLog(@"after angle == %f",[self angleFromWhiteLampColor:color]);
    return color;
}

/**
 * 将标准圆角度转换成扇形起始角度
 */
-(double)transformToFanAngle:(double)angle{
    
    CGFloat leftMinAngle = k_LeftMinAngle;
    CGFloat rightMinAngle = k_RightMinAngle;
    //    CGFloat totalAngle = 2.0 * M_PI - (rightMinAngle-leftMinAngle);
    
    if (angle >= rightMinAngle && angle <=2.0 * M_PI) {
        angle = angle-rightMinAngle;
    }
    else if (angle <= leftMinAngle){
        angle += (2.0 * M_PI - rightMinAngle);
    }
    else{
        angle = 0;
    }
    
    //    LXLog(@"angle == %f",angle);
    
    return angle;
}



@end
