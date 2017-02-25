//
//  LXSensorController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSensorController.h"

@interface LXSensorController ()

@end

@implementation LXSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBgColor;
    
    self.title = self.title!=nil? self.title : LXLocalizedString(@"光照度传感器配置");

    self.navRightButton.image = nil;
    
    // 创建界面
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 创建界面
 */
-(void)createUI{
    
        
}
@end
