//
//  LXMainViewController.h
//  snailbulb
//
//  Created by lxz on 16/1/26.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXDockController.h"
//#import "LXLightStateViewController.h"
#import "LXNavigationController.h"
//#import "LXGropManagerViewController.h"
//#import "LXFeedBackViewController.h"
#import "LXNotifiCationObject.h"


@interface LXMainViewController : LXDockController
{
    BOOL _isShowGroup;
}
@property(nonatomic,strong) LXNavigationController *currentNavigationController;
@end
