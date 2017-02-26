//
//  LXMoreMainCell.h
//  BluetoothColorLampMeshLamp
//
//  Created by hao123 on 16/8/16.
//  Copyright © 2016年 snaillove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LXMoreMainCellStyle){
    LXMoreMainCellStyleNor,// 主标题
    LXMoreMainCellStyleArrow,// 标题1+箭头
    LXMoreMainCellStyleInfo,// 标题1+标题2
    LXMoreMainCellStyleInfoArrow,// 标题1+标题2+箭头
};

typedef void (^LXMoreMainCellBlock)();

@interface LXMoreMainCell : UIView


@property (nonatomic,assign)LXMoreMainCellStyle style; // 样式
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *secTitle;
@property (nonatomic,strong)UIImage *infoImage; // 图标 副标题图标
@property (nonatomic,strong)UIColor *titleColor;
@property (nonatomic,strong)UIColor *secTitleColor;
@property (nonatomic,strong)UIView *lineTop;
@property (nonatomic,assign)BOOL isClickDisable; // 是否不可点击


-(void)cellClickBlock:(LXMoreMainCellBlock)block;

/**
 * 设置箭头图片
 */
-(void)setArrowImageWithNor:(UIImage*)imageNor SelectImage:(UIImage*)imageSelect;

@end
