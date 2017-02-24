//
//  LXBaseViewController.m
//  bluetoothDemo
//
//  Created by hao123 on 16/8/12.
//  Copyright © 2016年 SCU. All rights reserved.
//

#import "LXBaseViewController.h"


@interface LXBaseViewController ()

@end

@implementation LXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBgColor;
    
    //左边按钮
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]
                                    initWithTitle:nil
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(leftButtonClick)];
    
    leftButton.image=[UIImage imageNamed:@"btn_nav_back_nor"];
    leftButton.tag = 1;
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navLeftButton = leftButton;
    
//
//    右边按钮
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:nil
                                     style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(rightButtonClick)];
    
    rightButton.image=[UIImage imageNamed:@"btn_nav_music_nor"];
    rightButton.tag = 2;
    
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navRightButton = rightButton;
    
    // ////
//    UIImage *backImg = [UIImage imageNamed:@"btn_nav_back_nor"];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(-10, 0, 44, 44);
//    backBtn.backgroundColor = [UIColor redColor];
////    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [backBtn addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setImage:backImg forState:UIControlStateNormal];
//    UIView *backBtnView = [[UIView alloc] initWithFrame:backBtn.bounds];
//    [backBtnView addSubview:backBtn];
//    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
//    self.navigationItem.leftBarButtonItem = backBarBtn;
//    self.navLeftButton = backBarBtn;
    // ////////
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightButtonClick
{
    LXLog(@"rightButtonClick");
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 * 加载动画
 */
- (void)showLoadingsAnimationWithTitle:(NSString*)title TimesSec:(NSInteger)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    if (time==0) {
        time = 2;
    }
    
    // Set the label text.
    hud.label.text = title;//LXLocalizedString(@"Loading...");
    hud.label.textColor = mainTextColor;
    hud.label.font = mainFontSize(13);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
    
}


/**
 * 显示加载完成弹框
 */
-(void)showCustomViewAnimationWithTitle:(NSString*)title TimesSec:(NSInteger)time{
    
    if (time == 0) {
        time  = 2;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeCustomView; // 设置为自定义样式
  
    UIImage *image = [[UIImage imageNamed:@"ic_lamp_list_check"] imageWithRenderingMode:UIImageRenderingModeAutomatic]; // 设置图片模式
    hud.customView = [[UIImageView alloc] initWithImage:image];

    hud.label.text = title;
    hud.label.textColor = mainTextColor; // 设置字体颜色
    hud.label.font = mainFontSize(13);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [hud hideAnimated:YES];
    });
    
}

@end
