//
//  Dock.m
//  新浪微博
//
//  Created by yhl on 15/3/17.
//  Copyright (c) 2015年 yhl. All rights reserved.
//
   
#import "LXDock.h"
#import "LXDockItem.h"


//背景图片
//#define kBgImage @"tabbar_background"

@interface LXDock()
{
    LXDockItem *_selectedItem;
}
@end

@implementation LXDock

-(id)init{
    if (self = [super init]) {
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tap.png"]];
        _selectedIndex = -1;
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = LXColor(67, 67, 67);
    }
    return self;
}

#pragma mark 添加一个选项卡


- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected backIcon:(NSString*)backIcon selectedBack:(NSString*)selectedBack hightIcon:(NSString*)hightIcon title:(NSString *)title{
    // 1.创建item
    LXDockItem *item = [[LXDockItem alloc] init];
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.75] forState:UIControlStateNormal];
    [item setTitleColor:LXColor(255,112,0) forState:UIControlStateSelected];

    // 图标
    UIImage *normalImage = [UIImage imageNamed:icon];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed: hightIcon] forState:UIControlStateHighlighted];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    
    //背景图标
//    [item setBackgroundImage:[UIImage imageNamed:backIcon] forState:UIControlStateNormal];
//    [item setBackgroundImage:[UIImage imageNamed:selectedBack] forState:UIControlStateSelected];
    
    // 监听item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.添加item
    [self addSubview:item];
    int count = (int)self.subviews.count;
    // 默认选中第一个item
    
    
    // 3.调整所有item的frame
    CGFloat height = self.frame.size.height  ; // 高度
    CGFloat width = self.frame.size.width / count; // 宽度
    for (int i = 0; i<count; i++) {
        LXDockItem *dockItem = self.subviews[i];
        dockItem.tag = 20+i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
    
    if (count == 1) {
        [self itemClick:item];
    }
}

- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected hightIcon:(NSString*)hightIcon title:(NSString *)title{
    [self addItemWithIcon:icon selectedIcon:selected backIcon:nil selectedBack:nil hightIcon:hightIcon title:title];
}



#pragma mark 监听item点击
- (void)itemClick:(LXDockItem *)item{
//    item.backgroundColor = LXColor(67, 67, 67); // 选中颜色
    item.backgroundColor = [UIColor whiteColor]; // 选中颜色
    //选中的控制器的索引
    int Index = (int)item.tag;
    if(_selectedIndex == Index)
    {
        return;
    }
    
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
        if (_selectedItem) {
            [_delegate dock:self itemSelectedFrom:(int)_selectedItem.tag-20 to:Index-20];
        }else{
            [_delegate dock:self itemSelectedFrom:0 to:Index-20];

        }
        
    }
    
    // 1.取消选中当前选中的item
    _selectedItem.selected = NO;

    // 2.选中点击的item
    item.selected = YES;
    
    // 3.赋值
    _selectedItem = item;
    _selectedIndex = Index;
}


-(void)setSelectedIndex:(int)selectedIndex{
//    _selectedIndex = selectedIndex +20;
    
    //遍历子控件，显示选中的item
    for (UIControl *ctrol in self.subviews) {
        if (![ctrol isKindOfClass:[LXDockItem class]]) return;
        LXDockItem *item = (LXDockItem*)ctrol;
        
        if (item.tag == selectedIndex +20) {
            [self itemClick:item];
            break;
        }
    }
}

-(void)drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"bg_tap.png"];
    [image drawInRect:rect];
}
@end
