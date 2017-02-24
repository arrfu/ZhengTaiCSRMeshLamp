//
//  LXScenseMainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSceneMainController.h"

@interface LXSceneMainController ()

@end

@implementation LXSceneMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LXLocalizedString(@"场景列表");
    self.navLeftButton.image = nil;
    self.navRightButton.image = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
