
//
//  LXColckPickerView.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/5/3.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXClockPickerView.h"

@interface LXClockPickerView ()<UIPickerViewDataSource,UIPickerViewDelegate,UIPickerViewAccessibilityDelegate>{
    int rowIndex1;
    int componentIndex1;
    
    int rowIndex2;
    int componentIndex2;
    
    bool isSelect;
}

@end

@implementation LXClockPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
//        self.backgroundColor = [UIColor redColor];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return  self;
}


#pragma mark --------------- UIPickerViewDelegate -------------------------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
//    return 3;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    if (component == 0) {
//        return 24 *100;
//    }
//    else if (component == 1) {
//        return 1;
//    }
//    else //if (component == 2)
//    {
//        return 60*100;
//    }
    if (component == 0) {
        return 24 *100;
    }
    else //if (component == 2)
    {
        return 60*100;
    }

    
}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.jf_width*0.5, self.jf_height*0.2)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = views.frame;
    btn.tag = 100*(1+component)+row;
    btn.titleLabel.font = mainFontSize(18);
    
    if (isSelect == NO) {
        if ((row == rowIndex1) && (component == componentIndex1)) {
            btn.selected = YES;
        }
        else if ((row == rowIndex2) && (component == componentIndex2)) {
            btn.selected = YES;
        }
    }
    
//    [pickerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UIView *view = (UIView*)obj;
//        
//        if (view.frame.size.height < 5) {
//            view.backgroundColor = [UIColor clearColor];
//        }
//    }];

    
    
    if (component == 0) {
//        frame.origin.x = self.jf_width*0.25;
//        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:[NSString stringWithFormat:@"%02ld",(long)(row%24)] forState:UIControlStateNormal];
        [btn setTitleColor:mainTextColor forState:UIControlStateNormal];
        [btn setTitleColor:mainTextColor forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"btn_fun_clock_edit_time"] forState:UIControlStateSelected];

    }
//    else if (component == 1) {
//        frame.origin.x = 0;
//        [btn setTitle:@":" forState:UIControlStateNormal];
//        [btn setTitleColor:mainTextColor forState:UIControlStateNormal];
////        btn.titleLabel.font = mainFontSize(13);
//    }
    else{
        frame.origin.x = -10;
//        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:[NSString stringWithFormat:@"%02ld",(long)(row%60)] forState:UIControlStateNormal];
        [btn setTitleColor:mainTextColor forState:UIControlStateNormal];
        [btn setTitleColor:mainTextColor forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"btn_fun_clock_edit_time"] forState:UIControlStateSelected];


    }
    
    btn.frame = frame;
    [views addSubview:btn];
    


    return views;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:component];
    isSelect = YES;

    DDLogVerbose(@"select row = %d,component = %d",row,component);
    
    UIView *views = [pickerView viewForRow:row forComponent:component];
    UIButton *btn = (UIButton*)[views viewWithTag:100*(1+component)+row];
    btn.selected = YES;
    DDLogVerbose(@"views = %@ ,subviews = %@",views,views.subviews);
    
    if (self.lxdelegate && [self.lxdelegate respondsToSelector:@selector(lxpickerView:didSelectRow:inComponent:)]) {
        [self.lxdelegate lxpickerView:pickerView didSelectRow:row inComponent:component];
    }

}

- (void)reloadDidSelectRow1:(NSInteger)row inComponent1:(NSInteger)component{
    rowIndex1 = row;
    componentIndex1 = component;
}

- (void)reloadDidSelectRow2:(NSInteger)row inComponent2:(NSInteger)component{
    rowIndex2 = row;
    componentIndex2 = component;
}



@end
