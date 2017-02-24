//
//  DockController.m
//  新浪微博
//
//  Created by yhl on 15/3/17.
//  Copyright (c) 2015年 yhl. All rights reserved.
//

#import "LXDockController.h"
#import "LXDock.h"



@interface LXDockController () <DockDelegate>
@end

@implementation LXDockController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // 1.添加Dock
    [self addDock];
}

#pragma mark 添加Dock
- (void)addDock{
    LXDock *dock = [[LXDock alloc] init];
    dock.frame = CGRectMake(0, self.view.frame.size.height - kDockHeight, self.view.frame.size.width, kDockHeight);
    dock.delegate = self;
    [self.view addSubview:dock];
    _dock = dock;
}

#pragma mark dock的代理方法
- (void)dock:(LXDock *)dock itemSelectedFrom:(int)from to:(int)to{
    if (to < 0 || to >= self.childViewControllers.count) return;
    
    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[from];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[to];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    LXLog(@"%@",NSStringFromCGRect(newVc.view.frame));
    
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
    _selectedController = newVc;
}

-(void)setSelectVCWithIndex:(NSInteger)index{
    [_dock setSelectedIndex:(int)index];
}
@end
