//
//  DockItem.m
//  新浪微博
//
//  Created by yhl on 15/3/17.
//  Copyright (c) 2015年 yhl. All rights reserved.
//  一个选项卡标签

#import "LXDockItem.h"

#define kDockItemSelectedBG @"tabbar_slider.png"

// 文字的高度比例
#define kTitleRatio 0.3

#define imaWidth 22
#define imaHeight 22


@implementation LXDockItem

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // 4.图片的内容模式
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
         //self.imageView.contentMode = UIViewContentModeCenter;
        
        // 5.设置选中时的背景
//        [self setBackgroundImage:[UIImage imageNamed:kDockItemSelectedBG] forState:UIControlStateSelected];
    }
    return self;
    
    
}



#pragma mark 覆盖父类在highlighted时的所有操作
//- (void)setHighlighted:(BOOL)highlighted {
////    [super setHighlighted:highlighted];
//}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
     //CGFloat imageWidth = contentRect.size.width;
    CGFloat imageWidth = imaWidth;
    CGFloat imageX = (contentRect.size.width - imageWidth)/2;
    CGFloat imageY = 0;
   
    //图片高度比例
    float imgRatio = 0;
    if(self.titleLabel.text == nil || self.titleLabel.text.length == 0)
    {
        imgRatio = 1.0;
    }else
    {
        imgRatio = 1- kTitleRatio ;
    }
    
    CGFloat imageHeight = contentRect.size.height * imgRatio-3;
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}


- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected backIcon:(NSString*)backIcon selectedBack:(NSString*)selectedBack title:(NSString *)title{
    // 1.创建item
    LXDockItem *item = [[LXDockItem alloc] init];
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:UIColorFromRGB(0xcdcdcd) forState:UIControlStateNormal];
    [item setTitleColor:UIColorFromRGB(0xe0814b) forState:UIControlStateSelected];
    
    // 图标
    UIImage *normalImage = [UIImage imageNamed:icon];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
 
}

@end
