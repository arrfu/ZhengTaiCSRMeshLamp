//
//  LXPowerSwitchSelectView.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXPowerSwitchSelectView.h"

#import "LXWeekTabCellView.h"

@interface LXPowerSwitchSelectView(){
    UIView *coverView;
    UIView *bgView;
    UIView *tabView;
    

    NSInteger indexValue;
}

@property (nonatomic,copy)LXPowerSwitchSelectViewBlock powerSwitchBlock;
@end



@implementation LXPowerSwitchSelectView

-(instancetype)init{
    if (self = [super init]) {
        [self initTimesPickerView];
    }
    return self;
}


-(void)initTimesPickerView{
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    // 添加遮罩
    coverView = [[UIView alloc] initWithFrame:currentWindow.frame];
    coverView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0x0c/255.0 blue:0x1b/255.0 alpha:0.5];
    [currentWindow addSubview:coverView];
    
    
    // 背景
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200*kScaleW, 100*kScaleH)];
    bgView.center = CGPointMake(coverView.jf_width*0.5, coverView.jf_height*0.5);
    bgView.backgroundColor = [UIColor whiteColor];
    //    bgView.userInteractionEnabled = YES;
    [coverView addSubview:bgView];
    
    
    // line
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.jf_width, 5)];
    line1.backgroundColor = kCellColorC1;
    [bgView addSubview:line1];
    
    /**
     * 添加 表格
     */
    [self addTabView];
    
    CGFloat lineY = tabView.jf_height*0.5;
    // line
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, lineY, bgView.jf_width-30, 1)];
    line2.backgroundColor = mainBgColor;
    [tabView addSubview:line2];
    
    

    
    
    // 弹框动画
    [self addViewAnimation];
}

/**
 * 添加动画
 */
-(void)addViewAnimation{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [bgView.layer addAnimation:popAnimation forKey:nil];
}

/**
 * 添加 表格
 */
-(void)addTabView{
    
    // 表格
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, bgView.jf_width, bgView.jf_height-5)];
    //    tabView.center = CGPointMake(coverView.jf_width*0.5, coverView.jf_height*0.5);
    tabView.backgroundColor = [UIColor whiteColor];
    //    bgView.userInteractionEnabled = YES;
    [bgView addSubview:tabView];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"打开",@"关闭",nil];
    
    
    
    CGFloat btnW = tabView.jf_width*0.8;
    CGFloat btnH = tabView.jf_height*0.5;
    CGFloat btnX = 20*kScaleW;
    
    CGFloat btnY = 0;
    
    NSString *imageNor = @"btn_tab_light_active";
    NSString *imageSelect = @"btn_time_clock_check_active";
    
    for (int i = 0; i < 2; i++) {
        
        
        btnY = btnH*i;
        
        if (i == 1) {
            
            
        }
        
        LXWeekTabCellView *tabCell =  [[LXWeekTabCellView alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        tabCell.tag = LXWeekTabCellTag+i;
        tabCell.font = mainFontSize(17);
        
        tabCell.title = titleArray[i];
        
        
        
        [tabCell setImageNor:imageNor select:imageSelect];
        
        tabCell.isSelect = i==0? YES : NO; // 默认选中第一个
        
//        tabCell.isDisSelect =  YES;
        
        [tabView addSubview:tabCell];
        
        WEAKSELF_SS
        // 点击
        [tabCell setLXWeekTabCellViewBlockClick:^(NSInteger tag, BOOL isSelect) {
//            LXLog(@"tag = %d,isSelect = %d",tag,isSelect);

            if (weakSelf.powerSwitchBlock) {
                weakSelf.powerSwitchBlock(tag-LXWeekTabCellTag);
            }
            [weakSelf closeView];
            
        }];
    }
    
}

-(void)setLXPowerSwitchSelectViewBlock:(LXPowerSwitchSelectViewBlock)block{
    self.powerSwitchBlock = block;
}



/**
 *  关闭视图
 */
-(void)closeView
{
    [UIView animateWithDuration:0.3f animations:^{
        coverView.alpha = 0;
        bgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
        [self removeFromSuperview];
    }];
}



/**
 * 关闭窗口
 */
-(void)dismissAlertView{
    [self closeView];
}


@end
