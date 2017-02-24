//
//  LXMainViewController.m
//  snailbulb
//
//  Created by lxz on 16/1/26.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXMainViewController.h"
#import "LXNavigationController.h"

#import "LXDeviceMainController.h"
#import "LXSceneMainController.h"
#import "LXEreaMainController.h"
#import "LXSettingMainController.h"

@interface LXMainViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    
}
@property(nonatomic,assign) UInt32 currentModel;
@end

@implementation LXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _isShowGroup = NO;
    // 2.创建并添加childViewController
    [self createChildViewControllers];
    
    // 3.初始化Dock
    [self addDockItem];
    
    //添加通知监听
    [self addObserver];

    LXLog(@"mainFrame %@",NSStringFromCGRect(self.view.frame));
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(modeDidChangeState:) name:kbluetoothDeviceModeDidChangeState object:nil];
}



-(void)modeDidChangeState:(NSNotification*)noti{

    
}

#pragma mark - 初始化dock
- (void)addDockItem{
    //2.往dock里填充内容
    // 设备中心
    [_dock addItemWithIcon:@"Tab-device-off.png" selectedIcon:@"Tab-device-on.png" hightIcon:@"Tab-device-on.png"
                     title:LXLocalizedString(@"")];
    
    // 场景列表
    [_dock addItemWithIcon:@"Tab-scene-off.png" selectedIcon:@"Tab-scene-on.png" hightIcon:@"Tab-scene-on.png"
                     title:LXLocalizedString(@"")];
    
    // 区域列表
    [_dock addItemWithIcon:@"Tab-erea-off.png" selectedIcon:@"Tab-erea-on.png" hightIcon:@"Tab-erea-on.png"
                     title:LXLocalizedString(@"")];
    
    // 设置
    [_dock addItemWithIcon:@"Tab-setting-off.png" selectedIcon:@"Tab-setting-on.png" hightIcon:@"Tab-setting-on.png"
                     title:LXLocalizedString(@"")];
}


#pragma mark 创建所有的子控制器
- (void)createChildViewControllers{

    // 1.设备中心
    LXDeviceMainController *deviceMainController = [[LXDeviceMainController alloc] init];
    [self addChildViewController:deviceMainController];
    
    // 2.场景列表
    LXSceneMainController *scenceMainController = [[LXSceneMainController alloc]init];
    [self addChildViewController:scenceMainController];
    
    // 3.区域列表
    LXEreaMainController *moreMainController = [[LXEreaMainController alloc]init];
    [self addChildViewController:moreMainController];
    
    // 4.设置
    LXSettingMainController *locationMainController = [[LXSettingMainController alloc]init];
    [self addChildViewController:locationMainController];
    //
    
}

#pragma mark 重写父类方法，给childController包装成为导航控制器
- (void)addChildViewController:(UIViewController *)childController{
    //包装的目的是：需要一个导航栏
    LXNavigationController *nav = [[LXNavigationController alloc] initWithRootViewController:childController];
    
    /**
     *  设置导航控制器中得Controller 通过手势就能返回上一个控制器 by luyonghe
     */
    nav.interactivePopGestureRecognizer.delegate = self;
    
    /**
     *  给导航控制器设代理,监听整个项目中得导航事件 by luyonghe
     */
    nav.delegate = self;
    [super addChildViewController:nav];
}

#pragma mark NavigateDelegate by luyonghe
/**
 *  监听整个应用的导航：当即将push 到新的控制器  luyonghe
 *
 *  @param navigationController 当前导航控制器
 *  @param viewController       即将要导航到的控制器
 *  @param animated
 */

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //1.取出根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root!= viewController) {
        
        
        //2.将导航控制器的height拉长
        CGRect frame = navigationController.view.frame;
        frame.size.height = self.view.frame.size.height;
        navigationController.view.frame = frame;
        
        //3.将dock 添加到即将要导航到得新的控制器中
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.frame.size.height-kDockHeight;
        if ([root.view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scroll = (UIScrollView*)root.view;
            dockFrame.origin.y  += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        
    }
}

/**
 *  监听整个应用的导航：已经push到新的控制器 luyonghe
 *
 *  @param navigationController 当前导航控制器
 *  @param viewController       即将要导航到的控制器
 *  @param animated
 */
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //1.取出根控制器
    UIViewController *root = navigationController.viewControllers[0];
    
    self.currentNavigationController = navigationController;
    if (root == viewController)
    {
        //1.还原导航控制器的高度
        CGRect frame = navigationController.view.frame;
        frame.size.height = self.view.frame.size.height - kDockHeight;
        navigationController.view.frame = frame;
        
        //把dock 添加回去
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = self.view.frame.size.height -kDockHeight;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
        
        //取消手势就能返回到返回到上一个控制器
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        //通过手势就能返回到返回到上一个控制器
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}

- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"ChangeNameNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectState:) name:@"connectStateNotification" object:nil];
}

//蓝牙连接成功
-(void)connectSuccess
{

}

-(void)connectFail
{
    _isShowGroup = NO;
}

-(void)connectState:(NSNotification*)notification
{
    
}

-(void)ChangeNameNotification:(NSNotification*)notification{
   

//    LXNotifiCationObject *notifiObject = (LXNotifiCationObject*)[notification object];
//    if(_isShowGroup)
//    {
//        switch (notifiObject.notifiIndex) {
//                //蓝牙连接
//            case 0:
//            {
//                LXBluetoothConnectController *connectControlle = [[LXBluetoothConnectController alloc] init];
//                [self.currentNavigationController pushViewController: connectControlle animated:YES];
//            }
//                break;
//
//            case 1:
//            {
//                LXLog(@"帮助反馈");
//                LXFeedBackViewController *feedBackViewControlle = [[LXFeedBackViewController alloc] init];
//                [self.currentNavigationController pushViewController: feedBackViewControlle animated:YES];
//            }
//                break;
//            case 3:
//                LXLog(@"版本号");
//                LXApplicationAboutController *aboutControlle = [[LXApplicationAboutController alloc] init];
//                [self.currentNavigationController pushViewController: aboutControlle animated:YES];
//                break;
//                
//
//        }
//        
//    }else
//    {
//        switch (notifiObject.notifiIndex) {
//                //蓝牙连接
//            case 0:
//            {
//                LXBluetoothConnectController *connectControlle = [[LXBluetoothConnectController alloc] init];
//                [self.currentNavigationController pushViewController: connectControlle animated:YES];
//            }
//                break;
//                
//            case 1:
//            {
//                LXLog(@"帮助反馈");
//                LXFeedBackViewController *feedBackViewControlle = [[LXFeedBackViewController alloc] init];
//                [self.currentNavigationController pushViewController: feedBackViewControlle animated:YES];
//            }
//                break;
//            case 2:
//                LXLog(@"关于");
//                LXApplicationAboutController *aboutControlle = [[LXApplicationAboutController alloc] init];
//                [self.currentNavigationController pushViewController: aboutControlle animated:YES];
//                break;
//                
//        }
//    }

    
}



@end
