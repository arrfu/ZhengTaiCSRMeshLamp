//
//  LXDeviceMainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXDeviceMainController.h"
#import "LXLampCircleView.h"

@interface LXDeviceMainController (){
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
    
//    _lampCircleView.delegate = self;
    [self.view addSubview:_lampCircleView];
//    [_lampCircleView switchLampCircleWithType:LXColorStyleColorFull];
    [_lampCircleView switchLampCircleWithType:LXColorStyleWarmAndWhite];
    
 
}
@end
