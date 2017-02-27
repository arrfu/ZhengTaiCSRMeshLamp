//
//  LXSettingMainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSettingMainController.h"
#import "LXDeviceTableCell.h"
#import "AliPayViews.h"
#import "KeychainData.h"

#import "LXSetpasswordViewController.h"
#import "MBProgressHUD.h"
#import "LXSetMeshPasswordController.h"

@interface LXSettingMainController ()<UITableViewDelegate,UITableViewDataSource>{


    NSArray *deviceTypeImag;
}

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArrays; //




@end

@implementation LXSettingMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LXLocalizedString(@"设置");
    self.navLeftButton.image = nil;
    self.navRightButton.image = nil;
    
    deviceTypeImag = [NSArray arrayWithObjects:@"Setting-gse-icon",@"Setting-pwd-icon",@"Setting-dgg-icon",@"Setting-file-icon", nil];
    
    self.dataArrays = [NSMutableArray arrayWithObjects:@"设置手势密码",@"设置网络密码",@"调试设备",@"网络配置文件", nil];
    
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview
-(UITableView *)tableview{
    if (_tableview == nil) {
//        float devViewH = kContentHeight*0.42*kScaleH;
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, LXDeviceTableCellHeight*4) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = mainBgColor;
        //        _tableview.backgroundColor = [UIColor redColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableview];
        
        _tableview.scrollEnabled = NO;
        
    }
    
    return _tableview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LXDeviceTableCellHeight;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cellIdentifier";
    LXDeviceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LXDeviceTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //    cell.delegate = self;
    
    
    NSString *model = self.dataArrays[indexPath.row];
    cell.title = model;
    cell.imageStr = deviceTypeImag[indexPath.row];
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXLog(@"indexPath.row = %d",indexPath.row);
    
    if (indexPath.row == 0) {
        // 设置密码
        [self setPassword];
    }
    else if (indexPath.row == 1){
        LXSetMeshPasswordController *vc = [[LXSetMeshPasswordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self.tableview reloadData];
}


#pragma mark - 设置手势密码接口
/**
 *  设置密码
 */
- (void)setPassword
{
    [self forgotPassword];
    LXSetpasswordViewController *setpass = [[LXSetpasswordViewController alloc] init];
    setpass.string = @"重置密码";
    [self presentViewController:setpass animated:YES completion:nil];
}

/**
 *  忘记密码
 */
- (void)forgotPassword
{
    [KeychainData forgotPsw];

    [self hudAction:@"忘记密码"];
}
/**
 *  修改密码
 */
- (void)alertPassword
{
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        LXSetpasswordViewController *setpass = [[LXSetpasswordViewController alloc] init];
        setpass.string = @"修改密码";
        [self presentViewController:setpass animated:YES completion:nil];
    } else {
        [self hudAction:@"还没有设置密码，不能修改密码"];
    }
}
/**
 *  验证密码
 */
- (void)validatePassword
{
    BOOL isSave = [KeychainData isSave]; //是否有保存
    if (isSave) {
        
        LXSetpasswordViewController *setpass = [[LXSetpasswordViewController alloc] init];
        setpass.string = @"验证密码";
        [self presentViewController:setpass animated:YES completion:nil];
        
    } else {
        [self hudAction:@"还没有设置密码，不能直接登录"];
    }
}

/**
 *  hud
 */

- (void)hudAction:(NSString *)contextStr
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = contextStr;
    hud.animationType = MBProgressHUDAnimationZoom;
    [hud showAnimated:YES];
    [self.view addSubview:hud];
    [self performSelector:@selector(removeHUB:) withObject:hud afterDelay:1];
    
}
- (void)removeHUB:(MBProgressHUD *)hud
{
    if (hud) {
        [hud  hideAnimated:YES];
        [hud removeFromSuperview];
        hud = nil;
    }
}




@end
