//
//  UISlider+touch.h
//  WIColorLamp
//
//  Created by lxz on 15/10/17.
//  Copyright © 2015年 chipsguide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (touch)

// 单击手势
- (void)addTapGestureWithTarget: (id)target
                         action: (SEL)action;
@end
