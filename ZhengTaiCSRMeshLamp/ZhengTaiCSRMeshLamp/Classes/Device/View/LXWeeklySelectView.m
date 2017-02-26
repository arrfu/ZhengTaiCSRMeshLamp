//
//  LXWeeklySelectView.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXWeeklySelectView.h"

#import "UIImage+FlatUI.h"
#import "LXWeekTabCellView.h"

@interface LXWeeklySelectView(){
    UIView *coverView;
    UIView *bgView;
    UIView *tabView;
    
    LXWeeklySelectViewType selectType;
    NSInteger repeatValue;
}

@property (nonatomic,copy)LXWeeklySelectViewBlock weeklyBlock;
@end


@implementation LXWeeklySelectView

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
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200*kScaleW, 350*kScaleH)];
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
    
    CGFloat lineY = tabView.jf_height+5;
    // line
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, lineY, bgView.jf_width-30, 1)];
    line2.backgroundColor = mainBgColor;
    [bgView addSubview:line2];

    
    // 创建确认取消按钮
    [self addSureCancelButton];
    
    
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
    tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, bgView.jf_width, bgView.jf_height*0.8)];
//    tabView.center = CGPointMake(coverView.jf_width*0.5, coverView.jf_height*0.5);
    tabView.backgroundColor = [UIColor whiteColor];
    //    bgView.userInteractionEnabled = YES;
    [bgView addSubview:tabView];

    NSArray *titleArray = [NSArray arrayWithObjects:@"单次",@"每天",@"自定义", @"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];
    
    CGFloat maxH = tabView.jf_height*0.3/3;
    CGFloat minH = tabView.jf_height*0.7/7;
    
    CGFloat btnW = tabView.jf_width*0.8;
    CGFloat btnH = 20*kScaleW;
    CGFloat btnX = 20*kScaleW;
    
    CGFloat btnY = 0;
    
    NSString *imageNor = @"btn_tab_light_active";
    NSString *imageSelect = @"btn_time_clock_check_active";
    
    for (int i = 0; i < 10; i++) {
        
        
        
        if (i <= 2) {
            btnX = 20*kScaleW;
            btnH = maxH;
            btnY = btnH*i;
        }
        else{
            btnX = 40*kScaleW;
            btnH = minH;
            btnY = maxH*3+(i-3)*minH;
        }
        
        LXWeekTabCellView *tabCell =  [[LXWeekTabCellView alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        tabCell.tag = LXWeekTabCellTag+i;
        tabCell.font = i<=2? mainFontSize(17) : mainFontSize(12);
        
        tabCell.title = titleArray[i];
        
        
        
        [tabCell setImageNor:imageNor select:imageSelect];
        
        tabCell.isSelect = i==0? YES : NO; // 默认选中第一个
        
        tabCell.isDisSelect = i<=2?YES : NO;
        
        [tabView addSubview:tabCell];
        
        WEAKSELF_SS
        // 点击
        [tabCell setLXWeekTabCellViewBlockClick:^(NSInteger tag, BOOL isSelect) {
//            LXLog(@"tag = %d,isSelect = %d",tag,isSelect);
            [weakSelf updateUIWithTag:tag isSelect:isSelect];
            
        }];
    }

}
/**
 * 创建确认取消按钮
 */
-(void)addSureCancelButton{
    
    for (int i =0; i < 2; i++) {
        CGFloat btnW = 60*kScaleW;
        CGFloat btnX = bgView.jf_width*0.5-btnW-10*kScaleW;
        CGFloat btnH = 30*kScaleW;
        CGFloat btnY = bgView.jf_height*0.85;
        
        if (i == 1) {
            btnX = bgView.jf_width*0.5+10*kScaleW;
        }
        
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        btn.tag = 100+i;
        btn.titleLabel.font = mainFontSize(12);
        
        NSString *titleStr = i==0? @"确认" : @"取消";
        [btn setTitle:titleStr forState:UIControlStateNormal];
        //        btn.titleLabel.textColor = secMainTextColor;
        //        [btn setTitleColor:LXColor(46, 46, 46) forState:UIControlStateNormal];
        //        btn.backgroundColor = [UIColor blackColor];
        
        UIColor *btnColor = i==0? kCellColorC1:kCellColorC2;
        [btn setBackgroundImage:[UIImage imageWithColor:btnColor cornerRadius:0] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
        
        
        [btn addTarget:self action:@selector(sureCancelButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];
        
    }
}



#pragma mark - 确认取消按钮点击

-(void)sureCancelButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    
    if (sender.tag == 100) {
        
        if (selectType==LXWeeklySelectViewTypeUserDefie && repeatValue==0) {
            return ;
        }
        // 确认
        if (self.weeklyBlock) {
            self.weeklyBlock(selectType,repeatValue);
        }
    }
    [self closeView];
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

-(void)setLXWeeklySelectViewBlock:(LXWeeklySelectViewBlock)block{
    self.weeklyBlock = block;
}

#pragma mark 刷新界面

-(void)updateUIWithTag:(NSInteger)tag isSelect:(BOOL)isSelect{
    
    
    
    if (tag == 10 || tag == 11) {
        selectType = tag == 10? LXWeeklySelectViewTypeOnce: LXWeeklySelectViewTypeEveryDay;
        
        for (int i = 0; i < 10; i++) {
            LXWeekTabCellView *tabCell = [tabView viewWithTag:LXWeekTabCellTag+i];
            tabCell.isSelect = NO;
        }
        
        repeatValue = 0; // 复位
        
        LXWeekTabCellView *tabCell_0 = [tabView viewWithTag:tag];
        tabCell_0.isSelect = YES;
        
    }
    else{
        
        LXWeekTabCellView *tabCell_0 = [tabView viewWithTag:10];
        tabCell_0.isSelect = NO;
        LXWeekTabCellView *tabCell_1 = [tabView viewWithTag:11];
        tabCell_1.isSelect = NO;
        
        LXWeekTabCellView *tabCell_2 = [tabView viewWithTag:12];
        tabCell_2.isSelect = YES;

        selectType = LXWeeklySelectViewTypeUserDefie;
        
        if (tag == 12) {
            
            
        }
        else{ // 13 - 19
            NSInteger value = tag-13;
            if (isSelect) {
                repeatValue |= (1<<value);
            }
            else{
                repeatValue &= ~(1<<value);
            }
            
//            LXLog(@"repeatValue = %x",repeatValue);
        }

        
        
    }

    
}



@end
