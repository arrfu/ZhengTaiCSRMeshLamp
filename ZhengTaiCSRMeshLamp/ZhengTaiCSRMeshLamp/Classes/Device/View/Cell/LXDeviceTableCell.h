//
//  LXDeviceTableCell.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LXDeviceTableCellHeight (80*kScaleH)

@interface LXDeviceTableCell : UITableViewCell

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *imageStr;

@end
