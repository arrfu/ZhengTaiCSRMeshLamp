//
//  LXLampRoomController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXLampRoomController.h"

@interface LXLampRoomController (){
     UIImageView *bgImageView;
}

@end

@implementation LXLampRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LXColor(40,40,40);
    
    self.title = self.title!=nil? self.title : LXLocalizedString(@"客厅大厅");
    self.navRightButton.image = nil;
    
    // 创建界面
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 创建界面
 */
-(void)createUI{
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 375*kScaleW, 555*kScaleH)];
    bgImageView.image = [UIImage imageNamed:@"Lights-sng-on"];
    //    bgImageView.backgroundColor = [UIColor whiteColor];
//    bgImageView.center = CGPointMake(kScreenWidth*0.5, (kScreenHeight-kNavHeight)*0.5-50*kScaleH);
    [self.view addSubview:bgImageView];
    
    // 创建开关按钮
    [self createPowerSwitchButton];
    
}

/**
 * 创建开关按钮
 */
-(void)createPowerSwitchButton{
    
    CGFloat btnW = 130;
    CGFloat btnX = 0;
    CGFloat btnH = 54;
    CGFloat btnY = kContentHeight-btnH-15;
    
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    btn.jf_centerX = kScreenWidth*0.5;
    btn.tag = 103;
    
    
    [btn setImage:[UIImage imageNamed:@"Device-switch-on"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Device-switch-off"] forState:UIControlStateSelected];
    //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
    
    
    [btn addTarget:self action:@selector(powerSwitchButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


#pragma mark - 开关灯

-(void)powerSwitchButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    sender.selected = !sender.selected;
    
    //  155 344
    if (sender.selected) {
        
        bgImageView.image = [UIImage imageNamed:@"Lights-sng-off"];
        bgImageView.frame = CGRectMake(0, -7*kScaleH, 155*kScaleW, 344*kScaleH);
        bgImageView.jf_centerX = kScreenWidth*0.5;
    }
    else{

        bgImageView.image = [UIImage imageNamed:@"Lights-sng-on"];
        bgImageView.frame = CGRectMake(0, -14*kScaleH, 375*kScaleW, 555*kScaleH);
    }
}


@end
