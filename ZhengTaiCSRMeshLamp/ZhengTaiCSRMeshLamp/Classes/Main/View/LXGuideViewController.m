//
//  LXGuideViewController.m
//  colorBluetoothLampV3
//
//  Created by hao123 on 16/7/7.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXGuideViewController.h"
#import "LXTool.h"
#import "ZYWContainerViewController.h"



typedef NS_ENUM(NSInteger,LXLanguageType){
    LXLanguageEnglish,// 英文
    LXLanguageSimplified,// 中文简体
    LXLanguageTraditional,// 中文繁体
};

@interface LXGuideViewController ()<UIScrollViewDelegate>{
    LXLanguageType languageType; // 语言类型
}

@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation LXGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    languageType = [self getLanguageType];
    [self creatGuideUI];
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        [self.view addSubview:_scrollView];
        
    }
    
    return _scrollView;
}


/**
 * 获取语言类型
 */
-(NSInteger)getLanguageType{
    if ([LXTool isLanguageHasPrefix:@"zh-Hans"]) {
        return LXLanguageSimplified;// 中文简体
        
    }
    else if ([LXTool isLanguageHasPrefix:@"zh-Hant"]){
        return LXLanguageTraditional;// 中文繁体
    }
    else if ([LXTool isLanguageHasPrefix:@"en"]){
        return LXLanguageEnglish;// 英文
    }
    else {
        return LXLanguageEnglish;// 英文
    }

}

/**
 * 创建界面
 */
-(void)creatGuideUI{
    CGFloat imageW = self.scrollView.frame.size.width;
    CGFloat imageH = self.scrollView.frame.size.height;

    NSInteger totalCount = 4;
    
    NSString *skipNor;
    NSString *skipDown;
    
    if (languageType == LXLanguageSimplified) {
        skipNor = @"btn_guide_skip01_nor";// 中文简体
        skipDown = @"btn_guide_skip01_down";
    }
    else if (languageType == LXLanguageTraditional){
        skipNor = @"btn_guide_skip02_nor";// 中文繁体
        skipDown = @"btn_guide_skip02_down";
        
    }
    else{
        skipNor = @"btn_guide_skip03_nor";// 英文
        skipDown = @"btn_guide_skip03_down";
    }


    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
      
        CGFloat imageX = i * imageW;
       
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        imageView.userInteractionEnabled = YES;
       
        NSString *name = [NSString stringWithFormat:@"img_guide_bg_0%d", i + 1];
        if (i == 1) {
            if (languageType != LXLanguageEnglish) {
                name = [name stringByAppendingString:@"_cn"];
            }
            else{
                name = [name stringByAppendingString:@"_en"];
            }
            
        }
        imageView.image = [UIImage imageNamed:name];
        // 隐藏指示条
        self.scrollView.showsHorizontalScrollIndicator = NO;

        [self.scrollView addSubview:imageView];
        
        // 添加跳过按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(imageW-50, 0, 50, 50);
        [btn setImage:[UIImage imageNamed:skipNor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:skipDown] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(jumpOutClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        // 添加描述控件
        CGFloat descW = 175.5;
        CGFloat descH = 60.5;
        CGFloat descX = (imageW-descW)*0.5;
        CGFloat descY = imageH*0.68;
        
        UIImageView *descriptionView = [[UIImageView alloc] initWithFrame:CGRectMake(descX, descY, descW, descH)];
        NSString *descName = @"img_description_";
        if (languageType == LXLanguageSimplified) {
            descName = [descName stringByAppendingString:@"simplified"];
        }
        else if (languageType == LXLanguageTraditional){
            descName = [descName stringByAppendingString:@"traditional"];
        }
        else{
            descName = [descName stringByAppendingString:@"english"];
        }

        descName = [NSString stringWithFormat:@"%@_0%d", descName,i + 1];
        descriptionView.image = [UIImage imageNamed:descName];
        [imageView addSubview:descriptionView];
        
        // 添加发现按钮
        if (i == 3) {
            NSString *findOutNor = @"btn_guide_start_nor_0";
            NSString *findOutDown = @"btn_guide_start_down_0";
            
            if (languageType == LXLanguageSimplified) {
                findOutNor = [findOutNor stringByAppendingString:@"1"];
                findOutDown = [findOutDown stringByAppendingString:@"1"];
            }
            else if (languageType == LXLanguageTraditional){
                findOutNor = [findOutNor stringByAppendingString:@"2"];
                findOutDown = [findOutDown stringByAppendingString:@"2"];
            }
            else{
                findOutNor = [findOutNor stringByAppendingString:@"3"];
                findOutDown = [findOutDown stringByAppendingString:@"3"];
            }

            
            UIButton *findBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            findBtn.frame = CGRectMake(imageW*0.5-49, imageH-90, 98, 22);
            [findBtn setImage:[UIImage imageNamed:findOutNor] forState:UIControlStateNormal];
            [findBtn setImage:[UIImage imageNamed:findOutDown] forState:UIControlStateHighlighted];
            [findBtn addTarget:self action:@selector(findOutClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:findBtn];
        }
        
        // 添加分页线
        CGFloat pageW = 190;
        CGFloat pageX = (imageW-pageW)*0.5;
        CGFloat pageY = imageH-40;
        
        UIImageView *pageView = [[UIImageView alloc] initWithFrame:CGRectMake(pageX, pageY, pageW, 2)];
        pageView.image = [UIImage imageNamed:@"ic_guide_slider_line"];
        [imageView addSubview:pageView];
        
        UIImageView *sliderView = [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*pageW/5-10, -10, 20, 20)];
        sliderView.image = [UIImage imageNamed:@"ic_guide_slider"];
        [pageView addSubview:sliderView];
        
        
    }
   
    //   2.设置scrollview的滚动范围
    CGFloat contentW = totalCount *imageW;
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    self.scrollView.pagingEnabled = YES;
}

/**
 * 跳过
 */
-(void)jumpOutClick:(UIButton*)sender{
    LXLog(@"jumpOutClick");
    [self enterMainController];
}

/**
 * 发现
 */
-(void)findOutClick:(UIButton*)sender{
    LXLog(@"findOutClick");
    [self enterMainController];
}

/**
 * 进入主界面
 */
-(void)enterMainController{
    ZYWContainerViewController *CVC=[[ZYWContainerViewController alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = CVC;
}

- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}
@end
