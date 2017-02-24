//
//  ZYWSideView.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWSideView.h"
#import "ZYWSideTableView.h"


@interface ZYWSideView()<UIActionSheetDelegate>
@property(nonatomic,weak)UIView *blackView;
@property(nonatomic,copy)NSString *name;
@end



@implementation ZYWSideView

-(NSString *)name{
    if (_name==nil) {
        _name=@"跳转1";
    }
    
    return _name;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //添加更多
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 20.0, [UIScreen mainScreen].bounds.size.width, 40.0)];
        label.text = LXLocalizedString(@"更多");
        label.textColor = mainTextColor;
        [self addSubview:label];
        
        //创建透明view上的tableview
        ZYWSideTableView *sbv=[[ZYWSideTableView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height*0.1,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*0.6-48)];
        sbv.backgroundColor = secBgColor;
        [self addSubview:sbv];
    }
    
    //    注册通知观察者（接受通知，将记录跳转界面的值从主控制器传过来）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhuchuanzuo:) name:@"主传左" object:nil];
    return  self ;
}

-(void)dealloc
{
    // 移除通知观察者.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    LXLog(@"移除主传左通知对象");
}

//接受从主控制器传过来的值
-(void)zhuchuanzuo:(NSNotification *)notify{
    
    self.name=notify.object;
}

@end
