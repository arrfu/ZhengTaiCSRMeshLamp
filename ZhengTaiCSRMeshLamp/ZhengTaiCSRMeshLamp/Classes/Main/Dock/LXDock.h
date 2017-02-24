//
//  Dock.h
//  新浪微博
//
//  Created by yhl on 15/3/17.
//  Copyright (c) 2015年 yhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXDock;

@protocol DockDelegate <NSObject>
@optional
- (void)dock:(LXDock *)dock itemSelectedFrom:(int)from to:(int)to;
@end

@interface LXDock : UIView
// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected hightIcon:(NSString*)hightIcon title:(NSString *)title;

//添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected backIcon:(NSString*)backIcon selectedBack:(NSString*)selectedBack title:(NSString *)title;

// 代理
@property (nonatomic, weak) id<DockDelegate> delegate;

//选中按钮的索引
@property (nonatomic, assign) int selectedIndex;

@property(nonatomic,assign)BOOL isModelChange;

@end