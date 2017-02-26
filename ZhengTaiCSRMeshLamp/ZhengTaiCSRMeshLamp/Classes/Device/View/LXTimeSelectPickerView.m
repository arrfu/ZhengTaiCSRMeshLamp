//
//  LXTimeSelectPickerView.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXTimeSelectPickerView.h"
#import "UIImage+FlatUI.h"
#import "LXClockPickerView.h"

@interface LXTimeSelectPickerView()<LXClockPickerViewDelegate>{
    UIView *coverView;
    UIView *bgView;
    LXClockPickerView *clockPickerView;
    NSInteger hourValue;
    NSInteger minuteValue;
   
}

@property (nonatomic,copy)LXTimeSelectPickerViewBlock timeSelectPickerBlock;
@end


@implementation LXTimeSelectPickerView

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
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200*kScaleW, 290*kScaleH)];
    bgView.center = CGPointMake(coverView.jf_width*0.5, coverView.jf_height*0.5);
    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.userInteractionEnabled = YES;
    [coverView addSubview:bgView];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bgView.jf_width, 30*kScaleH)];
    titleLabel.backgroundColor = kCellColorC1;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = mainFontSize(13);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = LXLocalizedString(@"  时间选择");
    [bgView addSubview:titleLabel];
    

    // 创建时间Picker
    clockPickerView = [[LXClockPickerView alloc] initWithFrame:CGRectMake(0, titleLabel.jf_height, bgView.jf_width, bgView.jf_height*0.7)];
    clockPickerView.lxdelegate = self;
    [bgView addSubview:clockPickerView];
    
    
    NSInteger row0 = hourValue = 7;
    NSInteger row1 = minuteValue = 25;
    row0 = row0 + 24 *50;
    row1 = row1 + 60 *50;
    
    [clockPickerView reloadDidSelectRow1:row0 inComponent1:0];
    [clockPickerView reloadDidSelectRow2:row1 inComponent2:1];
    [clockPickerView selectRow:row0 inComponent:0 animated:NO];
    [clockPickerView selectRow:row1 inComponent:1 animated:NO];
    
    CGFloat lineY = clockPickerView.jf_y+clockPickerView.jf_height+5*kScaleH;
    // line
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, lineY, bgView.jf_width-30, 1)];
    line1.backgroundColor = mainBgColor;
    [bgView addSubview:line1];
    
    // 添加时分
    for (int i = 0; i < 2; i++) {
        CGFloat mLabelX = clockPickerView.jf_width*0.4;
        
        if (i == 1) {
            mLabelX = clockPickerView.jf_width*0.85;
        }
        UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(mLabelX, 0, 30*kScaleW, 50*kScaleH)];
        mLabel.jf_centerY = clockPickerView.jf_height*0.5;
        mLabel.textAlignment = NSTextAlignmentLeft;
        mLabel.font = mainFontSize(18);
        mLabel.textColor = mainTextColor;
        mLabel.text = i==0? LXLocalizedString(@"时") : LXLocalizedString(@"分");
        [clockPickerView addSubview:mLabel];
    }
    
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
        // 确认
        self.timeSelectPickerBlock(hourValue,minuteValue);
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


#pragma mark 选择时间回调 UIPickerViewDelegate
-(void)lxpickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        
        hourValue = (row%24);
        
    }else if (component == 1){
        minuteValue = (row%60);
    }
    
//    LXLog(@"hour = %d,minute = %d",hour,minute);
}

-(void)setTimeSelectPickerViewBlock:(LXTimeSelectPickerViewBlock)block{
    self.timeSelectPickerBlock = block;
}


@end
