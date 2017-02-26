//
//  LXCurtainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXCurtainController.h"

@interface LXCurtainController (){
    UIImageView *bgImageView;
}

@end

@implementation LXCurtainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LXColor(56,91,182);
    
    self.title = self.title!=nil? self.title : LXLocalizedString(@"窗帘");
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
    
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 364*kScaleW, 273*kScaleH)];
    bgImageView.image = [UIImage imageNamed:@"Device-win-on"];
    //    bgImageView.backgroundColor = [UIColor whiteColor];
    bgImageView.center = CGPointMake(kScreenWidth*0.5, (kScreenHeight-kNavHeight)*0.5-50*kScaleH);
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
    
    if (sender.selected) {
        bgImageView.image = [UIImage imageNamed:@"Device-win-off"];
    }
    else{
        bgImageView.image = [UIImage imageNamed:@"Device-win-on"];
    }
}


@end
