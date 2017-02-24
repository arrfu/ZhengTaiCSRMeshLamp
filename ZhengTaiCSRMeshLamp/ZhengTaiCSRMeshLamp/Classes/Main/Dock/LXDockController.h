//
//  DockController.h
//  新浪微博
//
//  Created by yhl on 15/3/17.
//  Copyright (c) 2015年 yhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXDock.h"
#import "LXBaseViewController.h"

@interface LXDockController : LXBaseViewController{
    LXDock *_dock;
}
@property(nonatomic,readonly) UINavigationController *selectedController;

-(void)setSelectVCWithIndex:(NSInteger)index;
@end
