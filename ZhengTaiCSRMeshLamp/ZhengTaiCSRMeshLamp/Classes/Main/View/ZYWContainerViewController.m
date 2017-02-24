//
//  ZYWContainerViewController.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWContainerViewController.h"
#import "ZYWSideView.h"
#import "UIView+SHCZExt.h"
#import "LXMainViewController.h"
#import "LXNavigationController.h"
//#import "LXColorLampViewController.h"
//#import "LXMusicViewController.h"
//#import "LXFunViewController.h"


@interface ZYWContainerViewController ()<UIGestureRecognizerDelegate>
{
   LXMainViewController *_mainVC;
    BOOL isOpen;
}

//@property(nonatomic,strong)UIView *MV;


@end

@implementation ZYWContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isOpen = YES;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    [self addSubViews];
    
    [self addRecognizer];
    
    [self addObserver];

}

//添加子视图
-(void)addSubViews{

    //在self.view上创建一个透明的View
    ZYWSideView *mainView=[[ZYWSideView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width*0.25,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    mainView.backgroundColor = secBgColor;
    
    //设置冰川背景图
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_bg"]];
    img.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height*0.4);
    
    [self.view addSubview:img];
    
    //添加
    [self.view addSubview:mainView];
    
    [self addTabbarController];
    
}

//添加主控制器（tabbarcontroller）的View

-(void)addTabbarController{

    LXMainViewController *main = [[LXMainViewController alloc]init];
    _mainVC = main;
    
    //  添加子控制器 - 保证响应者链条的正确传递
    [self addChildViewController:main];
    
//    LXLog(@"%@", self.childViewControllers);
    
    //  将 MVC 的视图，添加到 self.view 上
    [self.view addSubview:main.view];
    
//    LXLog(@"%@",self.view.subviews);
    main.view.frame = self.view.bounds;

}

//添加手势
-(void)addRecognizer{
    //    添加拖拽
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    pan.cancelsTouchesInView = NO;
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    UIViewController *vc =  [_mainVC.currentNavigationController.viewControllers lastObject];
//    if ([vc isKindOfClass:[LXColorLampViewController class]] ||
//        [vc isKindOfClass:[LXMusicViewController class]] ||
//        [vc isKindOfClass:[LXFunViewController class]]) {
//        
//         CGPoint point = [touch locationInView:vc.view ];
//        if(point.y > 200 && point.y < 320)
//        {
//            return  NO;
//        }
//        return YES;
//    }
//    return  NO;
return YES;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:[window subviews].count -1];
    id nextResponder = [frontView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


//实现拖拽
-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{

    
    // 1. 获取手指拖拽的时候, 平移的值
    CGPoint translation = [recognizer translationInView:[self.view.subviews objectAtIndex:2]];
    
    // 2. 让当前控件做响应的平移
    [self.view.subviews objectAtIndex:2].transform = CGAffineTransformTranslate([self.view.subviews objectAtIndex:2].transform, translation.x, 0);
    
    [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
 
    // 3. 每次平移手势识别完毕后, 让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:[self.view.subviews objectAtIndex:2]];
    
    //获取最右边范围
    CGAffineTransform  rightScopeTransform=CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    
    //    当移动到右边极限时
    if ([self.view.subviews objectAtIndex:2].transform.tx>rightScopeTransform.tx) {
        
        //        限制最右边的范围
        [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
        //        限制透明view最右边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
        //        当移动到左边极限时
    }else if ([self.view.subviews objectAtIndex:2].transform.tx<0.0){
        
        //        限制最左边的范围
        [self.view.subviews objectAtIndex:2].transform=CGAffineTransformTranslate(self.view.transform,0, 0);
        //    限制透明view最左边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
           
            if ([self.view.subviews objectAtIndex:2].transform.tx >[UIScreen mainScreen].bounds.size.width*0.5) {
                
                [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
                isOpen= NO;
                
            }else{
                
                [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
                isOpen = YES;
            }
        }];
    }
}



- (void) addObserver
{
    //用于关闭侧边栏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"ChangeNameNotification" object:nil];
    
    //用于打开侧边栏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(opentheSidebarNotification:) name:kNotiOpentheSidebar object:nil];
}

-(void)ChangeNameNotification:(NSNotification*)notification{
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
        
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        isOpen = NO;
    }];

    

    
}

-(void)opentheSidebarNotification:(NSNotification*)notification{
    //获取最右边范围
    CGAffineTransform  rightScopeTransform=CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    [UIView animateWithDuration:0.2 animations:^{
//        if (isOpen) {
//            [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
//            
//            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
//            isOpen = NO;
//        }else{
//            isOpen = YES;
//            [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
//            
//            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
//        }
        
        if (isOpen) {
            [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
            
            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;

            isOpen = NO;
        }else{
            isOpen = YES;
            
            [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
            
            [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
            
        }

     }];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}
@end
