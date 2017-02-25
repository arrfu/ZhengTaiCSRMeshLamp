//
//  LXSocketController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSocketController.h"

@interface LXSocketController (){
    UIImageView *bgImageView;
    
//    UILabel *label
}

@end

@implementation LXSocketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = LXColor(40,40,40);
    
    self.title = self.title!=nil? self.title : LXLocalizedString(@"窗帘");
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
    
    // 创建电压等数据图
    [self addDatasView];
    
    bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 364*kScaleW, 273*kScaleH)];
    bgImageView.image = [UIImage imageNamed:@"Device-wiset-on"];
    //    bgImageView.backgroundColor = [UIColor whiteColor];
    bgImageView.center = CGPointMake(kScreenWidth*0.5, (kScreenHeight-kNavHeight)*0.5);
    [self.view addSubview:bgImageView];
    
    // 创建开关按钮
    [self createPowerSwitchButton];
    
    // 创建定时按钮
    [self createClockButton];
    
}

/**
 * 创建电压等数据图
 */
-(void)addDatasView{
    
    CGFloat viewX = 50*kScaleH;
    UIView *datasView = [[UIView alloc] initWithFrame:CGRectMake(viewX, 20*kScaleH, kScreenWidth-2*viewX, 113*kScaleH)];
    //    datasView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datasView];
    
    for (int i = 0; i < 2; i++) {
        UIView *lineW = [[UIView alloc] initWithFrame:CGRectMake(0, (datasView.jf_height-0.5)*i, datasView.jf_width, 0.5)];
        lineW.backgroundColor = mainTextColorSelect;
        [datasView addSubview:lineW];
        
        UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake((datasView.jf_width-0.5)*i, 0, 0.5, datasView.jf_height)];
        lineH.backgroundColor = mainTextColorSelect;
        [datasView addSubview:lineH];
    }
    
    // image
    UIImageView *timImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-(24+10)*kScaleW, 10, 24*kScaleW, 24*kScaleW)];
    timImageView.image = [UIImage imageNamed:@"Wifisocket-tim-icon"];
    [self.view addSubview:timImageView];

    
    CGFloat margLabel = (datasView.jf_height/8);
    
    for (int i = 0; i < 5; i++) {
        
        CGFloat labelH = i==0? (margLabel*2):margLabel;
        CGFloat labelY = i==0? (margLabel):(margLabel*(2+i));
        CGFloat labelX = 10;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, datasView.jf_width-labelX, labelH)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = i==0? mainFontSize(13): mainFontSize(11);
        [datasView addSubview:label];
        label.textColor = mainTextColorSelect;
        label.text = @"实时数据";
        
        if (i == 1) {
            label.text = [NSString stringWithFormat:@"电流：%fA",11.534];
        }
        else if (i == 2) {
            label.text = [NSString stringWithFormat:@"电压：%fV",11.534];
        }
        else if (i == 3) {
            label.text = [NSString stringWithFormat:@"当前功率：%fkw",11.534];
        }
        else if (i == 4) {
            label.text = [NSString stringWithFormat:@"累计电能：%fkwh",11.534];
        }
    }

}

/**
 * 创建开关按钮
 */
-(void)createPowerSwitchButton{
    
    CGFloat btnW = 130*kScaleW;
    CGFloat btnX = kScreenWidth*0.5-btnW+20*kScaleW;
    CGFloat btnH = 54*kScaleH;
    CGFloat btnY = kContentHeight-btnH-15;
    
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
//    btn.jf_centerX = kScreenWidth*0.5;
    btn.tag = 103;
    
    
    [btn setImage:[UIImage imageNamed:@"Device-switch-on"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Device-switch-off"] forState:UIControlStateSelected];
    //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
    
    
    [btn addTarget:self action:@selector(powerSwitchButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

/**
 * 创建定时按钮
 */
-(void)createClockButton{
    
    CGFloat btnW = 54*kScaleH;
    CGFloat btnX = kScreenWidth-btnW-80*kScaleW;
    CGFloat btnH = 54*kScaleH;
    CGFloat btnY = kContentHeight-btnH-15;
    
    UIButton *btn =  [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
    //    btn.jf_centerX = kScreenWidth*0.5;
    btn.tag = 104;
    

    [btn setTitle:@"定时" forState:UIControlStateNormal];
    [btn setTitleColor:LXColor(72, 114, 228) forState:UIControlStateNormal];
    btn.titleLabel.font = mainFontSize(13);
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Wifisocket-timing-btn"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"Device-switch-off"] forState:UIControlStateSelected];
    //        [btn setImage:[UIImage imageNamed:@"Device-rotatio-left"] forState:UIControlStateHighlighted];
    
    
    [btn addTarget:self action:@selector(clockButtonnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}



#pragma mark - 开关灯

-(void)powerSwitchButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        bgImageView.image = [UIImage imageNamed:@"Device-wiset-off"];
    }
    else{
        bgImageView.image = [UIImage imageNamed:@"Device-wiset-on"];
    }
}

#pragma mark - 定时

-(void)clockButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
//    sender.selected = !sender.selected;
}


@end
