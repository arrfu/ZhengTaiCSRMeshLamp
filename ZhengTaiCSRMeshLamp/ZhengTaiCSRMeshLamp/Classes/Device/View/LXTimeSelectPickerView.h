//
//  LXTimeSelectPickerView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LXTimeSelectPickerViewBlock)(NSInteger hour,NSInteger minute);

@interface LXTimeSelectPickerView : UIView

-(void)setTimeSelectPickerViewBlock:(LXTimeSelectPickerViewBlock)block;

@end
