//
//  LXDeviceMainController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/23.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXDeviceMainController.h"
//#import "LXLampCircleView.h"
#import "LXDeviceTableCell.h"
#import "LXLampColorSettingController.h"
#import "LXLampRoomController.h"
#import "LXLampRoomController.h"
#import "LXCurtainController.h"
#import "LXSensorController.h"
#import "LXSocketController.h"
#import "LXSwitchSceneController.h"
#import "LXSwitchGroupController.h"

@interface LXDeviceMainController ()<UITableViewDelegate,UITableViewDataSource>{
//    LXLampCircleView * _lampCircleView;
    UIView *deviceTypeView;
    
    UIButton *deviceTypeBtn;
    UILabel *deviceTypeLabel;
    
    LXDeviceMeshType currentDeviceType; // 当前切换的类型
    NSArray *deviceTypeArray;
    NSArray *deviceTypeImag;
}

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArrays; //

@property (nonatomic,strong)NSMutableArray *devLightArrays; // 灯具
@property (nonatomic,strong)NSMutableArray *devCurtainArrays; // 窗帘
@property (nonatomic,strong)NSMutableArray *devSensorArrays; // 传感器
@property (nonatomic,strong)NSMutableArray *devSocketArrays; // 无线插座
@property (nonatomic,strong)NSMutableArray *devSwitchArrays; // 开关

@end

@implementation LXDeviceMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LXLocalizedString(@"设备中心");
    self.navLeftButton.image = nil;
    self.navRightButton.image = nil;
    
    // 初始化数据
    [self initDatasArrays];

    
    // 添加色盘
//    [self addLampCircleView];
    
    // 添加界面
    [self createUI];
    
    // 根据设备类型设置数据源
    [self updateDataArraysWithLXDeviceMeshType:currentDeviceType];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 * 初始化数据
 */
-(void)initDatasArrays{
    
    _dataArrays = [[NSMutableArray alloc] init];
    _devLightArrays = [[NSMutableArray alloc] init];
    _devCurtainArrays = [[NSMutableArray alloc] init];
    _devSensorArrays = [[NSMutableArray alloc] init];
    _devSocketArrays = [[NSMutableArray alloc] init];
    _devSwitchArrays = [[NSMutableArray alloc] init];
    
//    deviceTypeArray = [NSArray arrayWithObjects:@"灯具",@"窗帘",@"传感器",@"无线插座",@"开关", nil];
//    deviceTypeImag = [NSArray arrayWithObjects:@"Device-lights",@"Device-curtains",@"Device-Sensor",@"Device-socket",@"Device-switch", nil];
    
    deviceTypeArray = [NSArray arrayWithObjects:@"灯具",@"窗帘",@"无线插座",@"开关", nil];
    deviceTypeImag = [NSArray arrayWithObjects:@"Device-lights",@"Device-curtains",@"Device-socket",@"Device-switch", nil];
    
    _devLightArrays = [NSMutableArray arrayWithObjects:@"客厅大厅",@"客厅氛围灯",@"餐厅灯",@"调光调色灯", nil];
    
   _devCurtainArrays = [NSMutableArray arrayWithObjects:@"窗帘-01",@"窗帘-02",@"窗帘-03",@"窗帘-04", nil];
    
   _devSensorArrays = [NSMutableArray arrayWithObjects:@"光照度传感器-01",@"光照度传感器-02",@"光照度传感器-03",@"光照度传感器-04", nil];
    
   _devSocketArrays = [NSMutableArray arrayWithObjects:@"插座-01",@"插座-02",@"插座-03",@"插座-04", nil];
    
    _devSwitchArrays = [NSMutableArray arrayWithObjects:@"场景开光",@"分组开光", nil];
}

/**
 * 添加界面
 */
-(void)createUI{
    
    deviceTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight*0.42*kScaleH)];
    deviceTypeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:deviceTypeView];
    
    // 添加左右设备类型切换按钮
    [self createButton];
    
    // 添加图标
    deviceTypeBtn =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 134*kScaleH, 134*kScaleH)];
    deviceTypeBtn.center = CGPointMake(deviceTypeView.jf_width*0.5, deviceTypeView.jf_height*0.5);
    deviceTypeBtn.tag = 100+9;
    [deviceTypeBtn setImage:[UIImage imageNamed:@"Device-lights"] forState:UIControlStateNormal];
    //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
//    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deviceTypeView addSubview:deviceTypeBtn];
    
    deviceTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, deviceTypeView.jf_height-30*kScaleH, kScreenWidth, 30*kScaleH)];
    deviceTypeLabel.textAlignment = NSTextAlignmentCenter;
    deviceTypeLabel.font = mainFontSize(13);
    [self.view addSubview:deviceTypeLabel];
    deviceTypeLabel.textColor = kTextColorC2;
    deviceTypeLabel.text = deviceTypeArray[0];
    
    // tableview
    [self.view addSubview:self.tableview];
    
    /**
     * 创建自测和添加设备按钮
     */
    [self createCheckAndAddDeviceButton];

}

/**
 * 创建左右按钮
 */
-(void)createButton{
    
    CGFloat btnX = 30;
    CGFloat btnW = 84*kScaleW;
    CGFloat btnH = deviceTypeView.jf_height;
    
    for (int i = 0; i < 2; i++) { // 44 27
        
        btnX = i==0?0:kScreenWidth-btnW;
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, btnH)];
        btn.jf_centerY = deviceTypeView.jf_height*0.5;
        btn.tag = 100+i;
//        btn.backgroundColor = [UIColor yellowColor];
        if (i == 0) {
            btn.contentMode = UIViewContentModeRight;
        }
        else{
            btn.contentMode = UIViewContentModeLeft;
        }
        
        NSString *imgStr = i==0? @"Device-rotatio-left" : @"Device-rotatio-right";
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
        
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [deviceTypeView addSubview:btn];
        
    }
    
}

/**
 * 创建自测和添加设备按钮
 */
-(void)createCheckAndAddDeviceButton{
    
    CGFloat margin = 0;
    CGFloat btnW = 60;
    CGFloat btnX = kScreenWidth-2*btnW-margin-15;
    CGFloat btnH = 70;
    CGFloat btnY = kContentHeight-btnH-10;
    
    for (int i = 0; i < 2; i++) {
        
        if (i == 1) {
            btnX = btnX+btnW+margin;
        }
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
//        btn.jf_centerY = deviceTypeView.jf_height*0.5;
        btn.tag = 100+2+i;
        
        NSString *imgStr = i==0? @"Device-self" : @"Device-add";
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
        
        
        [btn addTarget:self action:@selector(checkAndAddDeviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
}

/**
 * 左右切换按钮
 */
-(void)buttonClick:(UIButton*)sender{
    
    LXLog(@"%d",sender.tag);
    if (sender.tag == 100) {
        // 左
        currentDeviceType--;
        if (currentDeviceType < LXDeviceMeshTypeLight) {
            currentDeviceType = LXDeviceMeshTypeLight;
        }
        
    }
    else if (sender.tag == 101){
       // 右
        currentDeviceType++;
        if (currentDeviceType >= LXDeviceMeshTypeSwitch) {
            currentDeviceType = LXDeviceMeshTypeSwitch;
        }
        
    }
   
    if (currentDeviceType > LXDeviceMeshTypeSwitch || currentDeviceType < LXDeviceMeshTypeLight) {
        currentDeviceType = LXDeviceMeshTypeLight;
    }
    deviceTypeLabel.text = deviceTypeArray[currentDeviceType];
    [deviceTypeBtn setImage:[UIImage imageNamed:deviceTypeImag[currentDeviceType]] forState:UIControlStateNormal];
    
    // 根据设备类型设置数据源
    [self updateDataArraysWithLXDeviceMeshType:currentDeviceType];
}

#pragma mark - 自测和添加设备按钮
-(void)checkAndAddDeviceButtonClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    if (sender.tag == 102) {
        // 左
        
        
    }
    else if (sender.tag == 103){
        // 右
        
    }

}

#pragma mark - tableview
-(UITableView *)tableview{
    if (_tableview == nil) {
        float devViewH = kContentHeight*0.42*kScaleH;
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, devViewH+10, kScreenWidth, kContentHeight-devViewH-10) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = mainBgColor;
//        _tableview.backgroundColor = [UIColor redColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [self.view addSubview:_tableview];
        
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
    cell.imageStr = [self getImageStringWithLXDeviceMeshType:currentDeviceType index:0];
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXLog(@"indexPath.row = %d",indexPath.row);

    
    switch (currentDeviceType) {
            // 灯具
        case LXDeviceMeshTypeLight:
            
            if (indexPath.row == 0) {
                
                
                LXLampRoomController *vc = [[LXLampRoomController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                LXLampColorSettingController *vc = [[LXLampColorSettingController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }

            break;
           // 窗帘
        case LXDeviceMeshTypeCurtain:
            
            if (1) {
                LXCurtainController *vc = [[LXCurtainController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
           
            
            break;
            
            // 传感器
        case LXDeviceMeshTypeSensor:
            
            if (1) {
                LXSensorController *vc = [[LXSensorController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
            break;
            
            // 无线插座
        case LXDeviceMeshTypeSocket:
            
            if (1) {
                LXSocketController *vc = [[LXSocketController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;

             // 开关
        case LXDeviceMeshTypeSwitch:
            
            if (indexPath.row == 0) {
                LXSwitchSceneController *vc = [[LXSwitchSceneController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                LXSwitchGroupController *vc = [[LXSwitchGroupController alloc] init];
                NSString *model = self.dataArrays[indexPath.row];
                vc.title = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            break;

            
        default:
            break;
    }
    
//    NSString *model = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    [self.tableview reloadData];
}

#pragma mark - 设置设备类型对应数据
/**
 * 根据设备类型设置数据源
 */
-(void)updateDataArraysWithLXDeviceMeshType:(LXDeviceMeshType)type{
    
    switch (type) {
            // 灯具
        case LXDeviceMeshTypeLight:
            
            self.dataArrays = [_devLightArrays mutableCopy];
            break;
            // 窗帘
        case LXDeviceMeshTypeCurtain:
            
            self.dataArrays = [_devCurtainArrays mutableCopy];
            break;
            
            // 传感器
        case LXDeviceMeshTypeSensor:
            
            self.dataArrays = [_devSensorArrays mutableCopy];
            break;
            
            // 无线插座
        case LXDeviceMeshTypeSocket:
            
            self.dataArrays = [_devSocketArrays mutableCopy];
            break;
            
            // 开关
        case LXDeviceMeshTypeSwitch:
            
            self.dataArrays = [_devSwitchArrays mutableCopy];
            break;
            
            
        default:
            break;
    }
    
    [self.tableview reloadData];
}

/**
 * 根据设备类型获取对应的图片
 */
-(NSString*)getImageStringWithLXDeviceMeshType:(LXDeviceMeshType)type index:(NSInteger)index{
    
    NSString *imageStr = nil;
    switch (type) {
            // 灯具
        case LXDeviceMeshTypeLight:
            
            if (index == 0) {
                imageStr = @"Device-sng-icon";
            }
            else if (index == 1) {
                imageStr = @"Device-ape-icon";
            }
            else if (index == 2) {
                imageStr = @"Device-rst-icon";
            }
            else if (index == 3) {
                imageStr = @"Device-dmg-icon";
            }
            break;
            // 窗帘
        case LXDeviceMeshTypeCurtain:
            
            imageStr = @"Device-win-icon";
            break;
            
            // 传感器
        case LXDeviceMeshTypeSensor:
            
            imageStr = @"Device-sno-icon";
            break;
            
            // 无线插座
        case LXDeviceMeshTypeSocket:
            
            imageStr = @"Device-set-icon";
            
            break;
            
            // 开关
        case LXDeviceMeshTypeSwitch:
            
            if (index == 0) {
                imageStr = @"Device-swh-icon";
            }
            else if (index == 1) {
                imageStr = @"Device-pwh-icon";
            }
            break;
            
            
        default:
            break;
    }
    
    return imageStr;

    
}

@end
