//
//  LXLampColorSettingController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXLampColorSettingController.h"
#import "LXLampCircleView.h"

#import "XJComboBoxView.h"
#import "UIView+ITTAdditions.h"

@interface LXLampColorSettingController ()<LXLampCircleViewDelegate,XJComboBoxViewDelegate>{
    LXLampCircleView * _lampCircleView;
    XJComboBoxView *_downSelectedView;
    UIButton *colorButton;
    UIButton *whiteButton;
    
    LXColorStyle currentLampType;
    
}
//@property (nonatomic, weak) HWDownSelectedView *down;
@end

@implementation LXLampColorSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LXColor(40,40,40);
    
    self.title = LXLocalizedString(@"调光调色");
//    self.navLeftButton.image = nil;
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
    // 添加下拉框
    [self addDownSelectView];
    
    // 添加色盘
    [self addLampCircleView];
    
    // 添加调色 调光 按钮
    [self addColorAndWhiteButton];
    
    // 创建开关按钮
    [self createPowerSwitchButton];
}

#pragma mark - 下拉框选项
-(void)comboBoxView:(XJComboBoxView *)comboBoxView didSelectRowAtValueMember:(NSString *)valueMember displayMember:(NSString *)displayMember{
    NSLog(@"valueMember = %@, displayMember=%@", valueMember, displayMember);
}

/**
 * 添加色盘
 */
-(void)addLampCircleView{
    
    UIImage * image = [UIImage alloc];
    image = [UIImage imageNamed:@"Control-dmg-Pointer"];
    
    _lampCircleView = [[LXLampCircleView alloc] initWithFrame: CGRectMake(0, 90, 240, 240)];
    _lampCircleView.jf_centerX = kScreenWidth*0.5;
    _lampCircleView.delegate = self;
    [self.view addSubview:_lampCircleView];
    [_lampCircleView switchLampCircleWithType:LXColorStyleColorFull];
    //    [_lampCircleView switchLampCircleWithType:LXColorStyleWarmAndWhite];
    
    
}

/**
 * 添加下拉框
 */
-(void)addDownSelectView{
    CGFloat labelW = 90;
    CGFloat labelX = kScreenWidth*0.5-labelW-25;
    

    
    UILabel *downLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 30*kScaleH, labelW, 44*kScaleH)];
    downLabel.textAlignment = NSTextAlignmentLeft;
    downLabel.font = mainFontSize(13);
    [self.view addSubview:downLabel];
    downLabel.textColor = [UIColor whiteColor];
    downLabel.text = @"模式选择";
    
    // 添加下拉框
    NSArray *listArray =@[@{@"display":@"RGB光",@"value":@"0"},@{@"display":@"黄光",@"value":@"1"},@{@"display":@"混合光",@"value":@"2"}];
    _downSelectedView = [[XJComboBoxView alloc]initWithFrame:CGRectMake(downLabel.x+downLabel.width-5, downLabel.jf_y+5, 140, 35*kScaleH)];
    _downSelectedView.displayMember = @"display";
    //    comboBox.valueMember = @"value";
    _downSelectedView.dataSource = listArray;
    _downSelectedView.borderColor =[UIColor whiteColor];
    _downSelectedView.borderWidth = 0.5;
    _downSelectedView.cornerRadius = 5;
    _downSelectedView.leftTitle = @"";//@"描述";
    _downSelectedView.defaultTitle = @"RGB光";
    _downSelectedView.delegate = self;
    [self.view addSubview:_downSelectedView];

    
    
}

/**
 * 添加调色 调光 按钮
 */
-(void)addColorAndWhiteButton{
    

    CGFloat btnW = 60;
    CGFloat btnX = kScreenWidth*0.5-btnW;
    CGFloat btnH = 40;
    CGFloat btnY = _lampCircleView.jf_y+_lampCircleView.jf_height+25*kScaleH;
    
    for (int i = 0; i < 2; i++) {
        
        if (i == 1) {
            btnX = kScreenWidth*0.5;
        }
        UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        btn.tag = 100+i;
        
        NSString *titleStr = i==0? @"调色 " : @"调光";
        [btn setTitle:titleStr forState:UIControlStateNormal];
//        btn.titleLabel.textColor = secMainTextColor;
        [btn setTitleColor:LXColor(46, 46, 46) forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor blackColor];
//        btn.backgroundColor = [UIColor darkGrayColor];
        
        if (i == 0) {
            colorButton = btn;
        }
        else{
            whiteButton = btn;
            
        }
        
        [btn addTarget:self action:@selector(colorAndWhiteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
    [self updateColorAndWhiteButtonWithType:currentLampType];
}

/**
 * 创建开关按钮
 */
-(void)createPowerSwitchButton{
    
    CGFloat btnW = 130;
    CGFloat btnX = 0;
    CGFloat btnH = 54;
    CGFloat btnY = kScreenHeight-kNavHeight-btnH-15;
    
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    btn.jf_centerX = kScreenWidth*0.5;
    btn.tag = 103;
    
    
    [btn setImage:[UIImage imageNamed:@"Device-switch-on"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Device-switch-off"] forState:UIControlStateSelected];
    //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
    
    
    [btn addTarget:self action:@selector(powerSwitchButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

#pragma mark - 开关灯

-(void)powerSwitchButtonnClick:(UIButton*)sender{
     LXLog(@"%d",sender.tag);
    sender.selected = !sender.selected;
}

#pragma mark - 彩灯，白灯按钮点击切换

-(void)colorAndWhiteButtonClick:(UIButton*)sender{
    
     LXLog(@"%d",sender.tag);
    if (sender.tag == 100) {
        currentLampType = LXColorStyleColorFull;
        
    }
    else if (sender.tag == 101){
        currentLampType = LXColorStyleWarmAndWhite;
    }
    
    [self updateColorAndWhiteButtonWithType:currentLampType];

    [_lampCircleView switchLampCircleWithType:currentLampType];

}



#pragma mark - 色盘颜色滑动回调
-(void)scrollColorAndWhiteLampColor:(UIColor*)color colorStyle:(LXColorStyle)colorStyle GestureState:(LXGestureState)gestureState{
    
    //    circleGestureState = gestureState;
    
    
    //    LXLog(@"color = %@,colorStyle = %d",color,colorStyle);
    if (colorStyle == LXColorStyleColorFull) {
        //        degreeLabel.textColor = color;
        
        //        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
        //        model.filterType = LXLampFilterColorType;
        LXRGBType rgbArray = LXRGBTypeMakeWithColor(color);
        int red = rgbArray.r;
        int green = rgbArray.g;
        int blue = rgbArray.b;
        
        LXLog(@"red = %d,green = %d,blue = %d",red,green,blue);
        //        [filter startFilterTimerWith:model];
    }
    else{
        LXRGBType rgb = LXRGBTypeMakeWithColor(color);
        int red = rgb.r;
        LXLog(@"red = %d",red);
        //        LXSendLampCodeModel *model = [[LXSendLampCodeModel alloc] init];
        //        model.filterType = LXLampFilterWarmType;
        //        model.warm = rgb.r;
        //        [filter startFilterTimerWith:model];
    }
    
}

/**
 * 切换灯界面刷新
 */
-(void)updateColorAndWhiteButtonWithType:(LXColorStyle)type{
    
    if (type == LXColorStyleColorFull) {
        
        colorButton.backgroundColor = LXColor(32, 32, 32);
        [colorButton setTitleColor:LXColor(101, 101, 101) forState:UIControlStateNormal];
        whiteButton.backgroundColor = LXColor(46, 46, 46);
        [whiteButton setTitleColor:LXColor(74, 74, 74) forState:UIControlStateNormal];
    }
    else{
        
        colorButton.backgroundColor = LXColor(46, 46, 46);
        [colorButton setTitleColor:LXColor(74, 74, 74) forState:UIControlStateNormal];
        whiteButton.backgroundColor = LXColor(32, 32, 32);
        [whiteButton setTitleColor:LXColor(101, 101, 101) forState:UIControlStateNormal];
    }
}


@end
