//
//  LXSetpasswordViewController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/27.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSetpasswordViewController.h"
#import "AliPayViews.h"
#import "KeychainData.h"

@interface LXSetpasswordViewController ()

@end

@implementation LXSetpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AliPayViews *alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
//    alipay.backgroundColor = mainBgColor;
    
    if ([self.string isEqualToString:@"验证密码"]) {
        alipay.gestureModel = ValidatePwdModel;
    } else if ([self.string isEqualToString:@"修改密码"]) {
        alipay.gestureModel = AlertPwdModel;
    } else if ([self.string isEqualToString:@"重置密码"]) {
        alipay.gestureModel = SetPwdModel;
    } else {
        alipay.gestureModel = NoneModel;
    }
    alipay.block = ^(NSString *pswString) {
        NSLog(@"设置密码成功-----你的密码为 = 【%@】\n\n", pswString);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self.view addSubview:alipay];
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
