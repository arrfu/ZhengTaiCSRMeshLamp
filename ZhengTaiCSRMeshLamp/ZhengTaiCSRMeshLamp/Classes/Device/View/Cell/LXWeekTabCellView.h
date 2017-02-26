//
//  LXWeekTabCellView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LXWeekTabCellTag 10

typedef void (^LXWeekTabCellViewBlock)(NSInteger tag,BOOL isSelect);

@interface LXWeekTabCellView : UIView

@property(nonatomic,copy)NSString *title;
@property(nonatomic,weak)UIFont *font;
@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,assign)BOOL isDisSelect; // 选中时，是否不能取消

-(void)setImageNor:(NSString*)nor select:(NSString*)select;

-(void)setLXWeekTabCellViewBlockClick:(LXWeekTabCellViewBlock)block;

@end
