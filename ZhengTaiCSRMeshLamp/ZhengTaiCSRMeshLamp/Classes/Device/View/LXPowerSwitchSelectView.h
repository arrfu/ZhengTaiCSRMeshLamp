//
//  LXPowerSwitchSelectView.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LXPowerSwitchSelectViewBlock)(NSInteger index);




@interface LXPowerSwitchSelectView : UIView


-(void)setLXPowerSwitchSelectViewBlock:(LXPowerSwitchSelectViewBlock)block;

@end
