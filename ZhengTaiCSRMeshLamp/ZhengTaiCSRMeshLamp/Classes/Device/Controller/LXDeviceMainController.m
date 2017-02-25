//
//  LXDeviceMainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXDeviceMainController.h"
#import "LXLampCircleView.h"

@interface LXDeviceMainController ()<LXLampCircleViewDelegate>{
    LXLampCircleView * _lampCircleView;
}

@end

@implementation LXDeviceMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LXLocalizedString(@"设备中心");
    self.navLeftButton.image = nil;
    self.navRightButton.image = nil;
    
    [self addKnobUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 添加滑块
 */
-(void)addKnobUI{
    
    UIImage * image = [UIImage alloc];
    image = [UIImage imageNamed:@"Control-dmg-Pointer"];
    
     _lampCircleView = [[LXLampCircleView alloc] initWithFrame: CGRectMake(50, 50, 240, 240)];
    
    _lampCircleView.delegate = self;
    [self.view addSubview:_lampCircleView];
    [_lampCircleView switchLampCircleWithType:LXColorStyleColorFull];
//    [_lampCircleView switchLampCircleWithType:LXColorStyleWarmAndWhite];
    
 
}

#pragma mark - 色盘颜色滑动回调
-(void)scrollColorAndWhiteLampColor:(UIColor*)color colorStyle:(LXColorStyle)colorStyle GestureState:(LXGestureState)gestureState{
    
//    circleGestureState = gestureState;

    
    //    LXLog(@"color = %@,colorStyle = %d",color,colorStyle);
    if (colorStyle == LXColorStyleColorFull) {
        //        degreeLabel.textColor = color;
        
//        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
//        model.filterType = LXLampFilterColorType;
        LXRGBType rgbArray = LXRGBTypeMakeWithColor(color);
        int red = rgbArray.r;
        int green = rgbArray.g;
        int blue = rgbArray.b;
        
        LXLog(@"red = %d,green = %d,blue = %d",red,green,blue);
//        [filter startFilterTimerWith:model];
    }
    else{
        LXRGBType rgb = LXRGBTypeMakeWithColor(color);
        int red = rgb.r;
         LXLog(@"red = %d",red);
//        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
//        model.filterType = LXLampFilterWarmType;
//        model.warm = rgb.r;
//        [filter startFilterTimerWith:model];
    }
    
}

@end
