//
//  CBNavigationController.m
//  colorBluetoothLampV2
//
//  Created by yhl on 15/5/13.
//  Copyright (c) 2015年 luyonghe. All rights reserved.
//

#import "LXNavigationController.h"
#import "UIImage+FlatUI.h"

@interface LXNavigationController ()

@end

@implementation LXNavigationController



#pragma mark 一个类只会调用一次
+(void)initialize{
    
}

#pragma mark - 设置导航栏的主题
+(void)setupNavTheme{
    // 2.设置导航栏UI
    UINavigationBar *navBar = [UINavigationBar appearance];
    //[navBar setBackgroundColor:[UIColor redColor]];//不起作用
    //设置导航栏背景 ios系统默认 nav会影响statusbar
    UIImage *navBackImg = [[UIImage imageNamed:@"bg_nav"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
//    [navBar setBackgroundImage:navBackImg forBarMetrics:UIBarMetricsDefault];
    
    [navBar setBackgroundImage:[UIImage imageWithColor:LXColor(72, 114, 228) cornerRadius:0] forBarMetrics:UIBarMetricsDefault];

    
    navBar.shadowImage = [[UIImage alloc] init]; // 去掉边框黑线
    
    // 设置导航栏上面文字属性
#ifdef __IPHONE_7_0
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
#else
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
#endif
    //使导航的渲染颜色设置为白色。
    [navBar setTintColor:[UIColor whiteColor]];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
