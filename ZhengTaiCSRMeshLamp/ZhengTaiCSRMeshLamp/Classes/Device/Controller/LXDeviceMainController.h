//
//  LXDeviceMainController.h
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

//#import "LXBaseViewController.h"
#import "LXSecondBaseViewController.h"



typedef NS_ENUM(NSInteger,LXDeviceMeshType)
{
    LXDeviceMeshTypeLight = 0, // 灯具
    LXDeviceMeshTypeCurtain, // 窗帘
    
    LXDeviceMeshTypeSocket, // 无线插座
    LXDeviceMeshTypeSwitch, // 开关
    
    LXDeviceMeshTypeSensor, // 传感器 暂时不做
    
};

@interface LXDeviceMainController : LXSecondBaseViewController

@end
