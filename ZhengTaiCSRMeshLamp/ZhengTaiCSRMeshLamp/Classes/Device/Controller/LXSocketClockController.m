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
#import "LXWeeklySelectView.h"
#import "LXPowerSwitchSelectView.h"

@interface LXSocketClockController (){
    UIView *bgView;
    LXTimeSelectPickerView *timeSelectPickerView;
    LXWeeklySelectView *weeklySelectView;
    LXPowerSwitchSelectView *powerSwitchSelectView;
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
    
    WEAKSELF_SS
    [weekCell cellClickBlock:^{
        LXLog(@"%s",__func__);
        
        weeklySelectView = [[LXWeeklySelectView alloc] init];
        
        [weeklySelectView setLXWeeklySelectViewBlock:^(LXWeeklySelectViewType type, NSInteger repeat) {
            LXLog(@"type = %d,repeatValue = %02x",type,repeat);
            
            if (type == LXWeeklySelectViewTypeOnce) {
                weekCell.secTitle = LXLocalizedString(@"单次");
            }
            else if (type == LXWeeklySelectViewTypeEveryDay) {
                weekCell.secTitle = LXLocalizedString(@"每天");
            }
            else{
               weekCell.secTitle = [weakSelf getStringWithRepet:repeat];
                
            }
        }];

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
        
        powerSwitchSelectView = [[LXPowerSwitchSelectView alloc] init];
        
        [powerSwitchSelectView setLXPowerSwitchSelectViewBlock:^(NSInteger index) {
            LXLog(@"index = %d",index);
            switchCell.secTitle = index==0? LXLocalizedString(@"打开"):LXLocalizedString(@"关闭");
        }];

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

/**
 * 根据重复周期获取文字
 */
-(NSString*)getStringWithRepet:(NSInteger)repeatValue{
    NSMutableString *title = [NSMutableString stringWithFormat:@"%@",@"星期"];
    
    Byte repeat = repeatValue;
    NSString *marginStr = @"、";
    // 周一
    if(repeat & 0x02){
        [title appendFormat:@"%@%@",LXLocalizedString(@"一"),marginStr];
    }
    // 周二
    if(repeat & 0x04){
        [title appendFormat:@"%@%@",LXLocalizedString(@"二"),marginStr];
    }
    // 周三
    if(repeat & 0x08){
        [title appendFormat:@"%@%@",LXLocalizedString(@"三"),marginStr];
    }
    // 周四
    if(repeat & 0x10){
        [title appendFormat:@"%@%@",LXLocalizedString(@"四"),marginStr];
    }
    // 周五
    if(repeat & 0x20){
        [title appendFormat:@"%@%@",LXLocalizedString(@"五"),marginStr];
    }
    // 周六
    if(repeat & 0x40){
        [title appendFormat:@"%@%@",LXLocalizedString(@"六"),marginStr];
    }
    // 周日
    if(repeat & 0x01){
        [title appendFormat:@"%@%@",LXLocalizedString(@"日"),marginStr];
    }
    NSLog(@"%d",title.length);
    if (title.length > 3) {
        title = [NSMutableString stringWithString:[title substringWithRange:NSMakeRange(0, title.length-marginStr.length)]];
    }
    
    
//    // 工作日
//    if(repeat == 0x3e){
//        title = [[NSMutableString alloc] initWithFormat:@"%@",LXLocalizedString(@"工作日")];
//    }
    
    // 每天
    if(repeat == 0x7f){
        title = [[NSMutableString alloc] initWithFormat:@"%@",LXLocalizedString(@"每天")];
    }
    
    
    //    NSString *newTitle = [NSString stringWithString:title];
    
    return title;
    
}


@end
