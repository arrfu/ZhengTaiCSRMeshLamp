//
//  LXBaseViewController.h
//  bluetoothDemo
//
//  Created by hao123 on 16/8/12.
//  Copyright © 2016年 SCU. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LXBaseViewController : UIViewController

@property (nonatomic,weak)UIBarButtonItem *navLeftButton;
@property (nonatomic,weak)UIBarButtonItem *navRightButton;

- (void)leftButtonClick;

- (void)rightButtonClick;



/**
 * 显示加载完成弹框
 */
-(void)showCustomViewAnimationWithTitle:(NSString*)title TimesSec:(NSInteger)time;
@end
