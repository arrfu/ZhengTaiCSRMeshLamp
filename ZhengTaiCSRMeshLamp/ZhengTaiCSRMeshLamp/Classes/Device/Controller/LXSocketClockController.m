//
//  LXSocketClockController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSocketClockController.h"
#import "LXMoreMainCell.h"
#import "LXTimeSelectPickerView.h"

@interface LXSocketClockController (){
    UIView *bgView;
    LXTimeSelectPickerView *timeSelectPickerView;
}

@end

@implementation LXSocketClockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBgColor;
    
    self.title = self.title!=nil? self.title : LXLocalizedString(@"无线插座定时");
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
    
    CGFloat margValue = 10;
    bgView = [[UIView alloc] initWithFrame:CGRectMake(margValue, margValue, kScreenWidth-2*margValue, kScreenHeight*0.5)];

    bgView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:bgView];
    
    // 添加设置时间弹框
    [self addLXTimeSelectPickerView];
    
    CGFloat cellHeight = bgView.jf_height*0.2;
    // 时间
    LXMoreMainCell *timeCell = [[LXMoreMainCell alloc] initWithFrame:CGRectMake(0, 0, bgView.jf_width, cellHeight)];
    timeCell.style = LXMoreMainCellStyleInfo;
    timeCell.lineTop.hidden = YES;
    timeCell.title = LXLocalizedString(@"时间：");
    timeCell.secTitle = LXLocalizedString(@"16时28分");
    timeCell.titleColor = kTextColorC1;
    timeCell.secTitleColor = kTextColorC1;
    [bgView addSubview: timeCell];
    [timeCell cellClickBlock:^{
        LXLog(@"%s",__func__);
        timeSelectPickerView = [[LXTimeSelectPickerView alloc] init];
        [timeSelectPickerView setTimeSelectPickerViewBlock:^(NSInteger hour, NSInteger minute) {
            LXLog(@"hour = %d,minute = %d",hour,minute);
            timeCell.secTitle = [NSString stringWithFormat:@"%02d 时 %02d 分",hour,minute];
        }];
         
        
//        if (![self isBTConnected]) {
//            LXShowToast(@"蓝牙未连接");
//            return ;
//        }
//        
//        LXTimingLightController *vc = [[LXTimingLightController alloc ] init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    // 重复
    LXMoreMainCell *weekCell = [[LXMoreMainCell alloc] initWithFrame:CGRectMake(0, cellHeight, bgView.jf_width, cellHeight)];
    weekCell.style = LXMoreMainCellStyleInfo;
    weekCell.lineTop.hidden = YES;
    weekCell.title = LXLocalizedString(@"重复：");
    weekCell.secTitle = LXLocalizedString(@"星期一、二、三、四、五、六、日");
    weekCell.titleColor = kTextColorC1;
    weekCell.secTitleColor = kTextColorC1;
    [bgView addSubview: weekCell];
    [weekCell cellClickBlock:^{
        LXLog(@"%s",__func__);
        
        //        if (![self isBTConnected]) {
        //            LXShowToast(@"蓝牙未连接");
        //            return ;
        //        }
        //
        //        LXTimingLightController *vc = [[LXTimingLightController alloc ] init];
        //        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];

    
    // 动作
    LXMoreMainCell *switchCell = [[LXMoreMainCell alloc] initWithFrame:CGRectMake(0, cellHeight*2, bgView.jf_width, cellHeight)];
    switchCell.style = LXMoreMainCellStyleInfo;
    switchCell.lineTop.hidden = YES;
    switchCell.title = LXLocalizedString(@"动作：");
    switchCell.secTitle = LXLocalizedString(@"打开");
    switchCell.titleColor = kTextColorC1;
    switchCell.secTitleColor = kTextColorC1;
    [bgView addSubview: switchCell];
    [switchCell cellClickBlock:^{
        LXLog(@"%s",__func__);
        
        //        if (![self isBTConnected]) {
        //            LXShowToast(@"蓝牙未连接");
        //            return ;
        //        }
        //
        //        LXTimingLightController *vc = [[LXTimingLightController alloc ] init];
        //        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];


    // 创建确认取消按钮
    [self addSureCancelButton];
}

/**
 * 创建确认取消按钮
 */
-(void)addSureCancelButton{
    
    for (int i =0; i < 2; i++) {
        CGFloat btnW = 60*kScaleW;
        CGFloat btnX = bgView.jf_width*0.5-btnW-10*kScaleW;
        CGFloat btnH = 60*kScaleW;
        CGFloat btnY = bgView.jf_height*0.7;
        
        if (i == 1) {
            btnX = bgView.jf_width*0.5+10*kScaleW;
        }
        
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        btn.tag = 100+i;
        
        NSString *imagStr = i==0? @"Btn-yes":@"Btn-no";
        [btn setImage:[UIImage imageNamed:imagStr] forState:UIControlStateNormal];
        //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
        
        
        [btn addTarget:self action:@selector(sureCancelButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:btn];

    }
}

/**
 * 添加设置时间弹框
 */
-(void)addLXTimeSelectPickerView{
    
    CGFloat cellHeight = bgView.jf_height*0.2;
    
//    timeSelectPickerView = [[LXTimeSelectPickerView alloc] init];

//     [bgView addSubview:timeSelectPickerView];
    
}
#pragma mark - 确认取消按钮点击

-(void)sureCancelButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    
    
    
}

@end
