//
//  LXClockPickerView.h
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/5/3.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXClockPickerViewDelegate <NSObject>

-(void)lxpickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface LXClockPickerView : UIPickerView

@property (nonatomic,weak)id<LXClockPickerViewDelegate> lxdelegate;

- (void)reloadDidSelectRow1:(NSInteger)row inComponent1:(NSInteger)component;

- (void)reloadDidSelectRow2:(NSInteger)row inComponent2:(NSInteger)component;
@end
