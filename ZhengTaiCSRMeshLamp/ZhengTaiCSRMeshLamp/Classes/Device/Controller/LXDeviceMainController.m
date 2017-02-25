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

@interface LXDeviceMainController ()<UITableViewDelegate,UITableViewDataSource>{
//    LXLampCircleView * _lampCircleView;
    UIView *deviceTypeView;
    
    UIButton *deviceTypeBtn;
    UILabel *deviceTypeLabel;
    
    NSInteger currentDeviceType; // 当前切换的类型
    NSArray *deviceTypeArray;
    NSArray *deviceTypeImag;
}

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArrays; //

@end

@implementation LXDeviceMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = LXLocalizedString(@"设备中心");
    self.navLeftButton.image = nil;
    self.navRightButton.image = nil;
    
    deviceTypeArray = [NSArray arrayWithObjects:@"灯具",@"窗帘",@"传感器",@"无线插座",@"开关", nil];
    deviceTypeImag = [NSArray arrayWithObjects:@"Device-lights",@"Device-curtains",@"Device-Sensor",@"Device-socket",@"Device-switch", nil];

    
    // 添加色盘
//    [self addLampCircleView];
    
    // 添加界面
    [self createUI];
    
    for (int i = 0; i < 10; i++) {
        [self.dataArrays addObject:[NSString stringWithFormat:@"示例%d",i]];
    }
    [self.tableview reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataArrays{
    if (_dataArrays == nil) {
        _dataArrays = [[NSMutableArray alloc] init];
    }
    return _dataArrays;
}

///**
// * 添加色盘
// */
//-(void)addLampCircleView{
//    
//    UIImage * image = [UIImage alloc];
//    image = [UIImage imageNamed:@"Control-dmg-Pointer"];
//    
//     _lampCircleView = [[LXLampCircleView alloc] initWithFrame: CGRectMake(50, 50, 240, 240)];
//    
//    _lampCircleView.delegate = self;
//    [self.view addSubview:_lampCircleView];
//    [_lampCircleView switchLampCircleWithType:LXColorStyleColorFull];
////    [_lampCircleView switchLampCircleWithType:LXColorStyleWarmAndWhite];
//    
// 
//}
//
//#pragma mark - 色盘颜色滑动回调
//-(void)scrollColorAndWhiteLampColor:(UIColor*)color colorStyle:(LXColorStyle)colorStyle GestureState:(LXGestureState)gestureState{
//    
////    circleGestureState = gestureState;
//
//    
//    //    LXLog(@"color = %@,colorStyle = %d",color,colorStyle);
//    if (colorStyle == LXColorStyleColorFull) {
//        //        degreeLabel.textColor = color;
//        
////        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
////        model.filterType = LXLampFilterColorType;
//        LXRGBType rgbArray = LXRGBTypeMakeWithColor(color);
//        int red = rgbArray.r;
//        int green = rgbArray.g;
//        int blue = rgbArray.b;
//        
//        LXLog(@"red = %d,green = %d,blue = %d",red,green,blue);
////        [filter startFilterTimerWith:model];
//    }
//    else{
//        LXRGBType rgb = LXRGBTypeMakeWithColor(color);
//        int red = rgb.r;
//         LXLog(@"red = %d",red);
////        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
////        model.filterType = LXLampFilterWarmType;
////        model.warm = rgb.r;
////        [filter startFilterTimerWith:model];
//    }
//    
//}

/**
 * 添加界面
 */
-(void)createUI{
    
    deviceTypeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight*0.42*kScaleH)];
    deviceTypeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:deviceTypeView];
    
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
    deviceTypeLabel.font = mainFontSize(11);
    [self.view addSubview:deviceTypeLabel];
    deviceTypeLabel.textColor = mainTextColor;
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
    CGFloat btnW = 44;
    
    
    for (int i = 0; i < 2; i++) {
        
        btnX = i==0?30:kScreenWidth-30-btnW;
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, 27)];
        btn.jf_centerY = deviceTypeView.jf_height*0.5;
        btn.tag = 100+i;
        
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
        if (currentDeviceType < 0) {
            currentDeviceType = 0;
        }
        
    }
    else if (sender.tag == 101){
       // 右
        currentDeviceType++;
        if (currentDeviceType >= 4) {
            currentDeviceType = 4;
        }
        
    }
   
    if (currentDeviceType > 4 || currentDeviceType < 0) {
        currentDeviceType = 0;
    }
    deviceTypeLabel.text = deviceTypeArray[currentDeviceType];
    [deviceTypeBtn setImage:[UIImage imageNamed:deviceTypeImag[currentDeviceType]] forState:UIControlStateNormal];
   
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

    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXLog(@"indexPath.row = %d",indexPath.row);
    
    
//    NSString *model = [NSString stringWithFormat:@"%d",indexPath.row];
    LXLampColorSettingController *vc = [[LXLampColorSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    [self.tableview reloadData];
}




@end
