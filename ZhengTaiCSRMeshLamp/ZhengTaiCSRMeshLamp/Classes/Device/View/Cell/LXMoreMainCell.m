//
//  LXMoreMainCell.m
//  BluetoothColorLampMeshLamp
//
//  Created by hao123 on 16/8/16.
//  Copyright © 2016年 snaillove. All rights reserved.
//

#import "LXMoreMainCell.h"

@interface LXMoreMainCell(){

    UIButton *_contentView;
    UIButton *_stateIcon;
}


@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *infoButton;
@property (nonatomic,copy)LXMoreMainCellBlock cellBlock;

@end
@implementation LXMoreMainCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 创建视图
        [self createUI:frame];
    }
    
    return self;
}

-(void)createUI:(CGRect)frame{
    
    // 背景
    _contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//    [_contentView setTitle:@"登录" forState:UIControlStateNormal];
    //        [btn setTitle:norStr forState:UIControlStateSelected];
    [_contentView setTitleColor: mainTextColor forState:UIControlStateNormal];
    //    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.tag = 1;
    [_contentView addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_contentView];
    
    for (int i = 0;  i < 2; i++) {
        // line
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, i*(_contentView.jf_height-1), _contentView.jf_width-20, 1)];
        line1.backgroundColor = mainBgColor;
        [_contentView addSubview:line1];
        
        if (i == 0) {
            self.lineTop = line1;
        }
        

    }
    
    
    // 标题1
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 44, _contentView.jf_height)];
    self.titleLabel.text = @"标题1";
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = mainFontSize(15);
    self.titleLabel.textColor = kTextColorC1;
    [_contentView addSubview:self.titleLabel];
//    _titleLabel.backgroundColor = [UIColor yellowColor];
    
    // 标题2
    self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.infoButton.frame = CGRectMake(_titleLabel.jf_x+_titleLabel.jf_width, 0, _contentView.jf_width-_titleLabel.jf_x-_titleLabel.jf_width, _contentView.jf_height);
    [self.infoButton setTitle:@"标题2" forState:UIControlStateNormal];
    [self.infoButton setTitleColor: mainTextColor forState:UIControlStateNormal];
    self.infoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.infoButton.titleLabel.font = mainFontSize(15);
//    self.infoButton.backgroundColor = [UIColor redColor];
    [_contentView addSubview:self.infoButton];
    self.infoButton.userInteractionEnabled = NO;
    
    // ///

    // 箭头
    _stateIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    _stateIcon.frame = CGRectMake(_contentView.jf_width-44, 0, 44, _contentView.jf_height);
//        [_stateIcon setTitle:@">" forState:UIControlStateNormal];
    //        [btn setTitle:norStr forState:UIControlStateSelected];
//    [_stateIcon setTitleColor: mainTextColor forState:UIControlStateNormal];
    //    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_nor")] forState:UIControlStateNormal];
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_pressed")] forState:UIControlStateSelected];
    _stateIcon.backgroundColor = [UIColor clearColor]; //  btn_lamp_list_other_nor ic_more_list_other_nor
    [_contentView addSubview:_stateIcon];
    _stateIcon.userInteractionEnabled = NO; // 关闭点击
    
    
}

-(void)setStyle:(LXMoreMainCellStyle)style{
    _style = style;
    
    switch (style) {
        case LXMoreMainCellStyleNor:// 主标题
            self.titleLabel.hidden = YES;
            self.infoButton.hidden = YES;
            _stateIcon.hidden = YES;
            break;
            
        case LXMoreMainCellStyleArrow:// 标题1+箭头
           
            self.infoButton.hidden = YES;
            
            break;
            
        case LXMoreMainCellStyleInfo:// 标题1+标题2
            _stateIcon.hidden = YES;
            self.infoButton.jf_x = _titleLabel.jf_x+_titleLabel.jf_width;
            break;
            
        case LXMoreMainCellStyleInfoArrow:// 标题1+标题2+箭头
            ;
            break;
            
        default:
            break;
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
//
    if (self.style == LXMoreMainCellStyleNor) {
        [_contentView setTitle:title forState:UIControlStateNormal];
    }
    else{
        self.titleLabel.text = title;
    }

}

-(void)setSecTitle:(NSString *)secTitle{
    _secTitle = secTitle;
    [self.infoButton setImage:nil forState:UIControlStateNormal];
    [self.infoButton setTitle:secTitle forState:UIControlStateNormal];
//    self.infoLabel.text = secTitle;
}

-(void)setInfoImage:(UIImage *)infoImage{
    _infoImage = infoImage;
    [self.infoButton setTitle:nil forState:UIControlStateNormal];
    [self.infoButton setImage:infoImage forState:UIControlStateNormal];
}

/**
 * 设置箭头图片
 */
-(void)setArrowImageWithNor:(UIImage*)imageNor SelectImage:(UIImage*)imageSelect{
    
    [_stateIcon setImage:imageNor forState:UIControlStateNormal];
    [_stateIcon setImage:imageSelect forState:UIControlStateSelected];
}

/**
 * 不可点击，箭头默认为灰色
 */
-(void)setIsClickDisable:(BOOL )isClickDisable{
    _isClickDisable = isClickDisable;
    
    if (isClickDisable) {
        [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"ic_more_list_other_nor")] forState:UIControlStateNormal];
        [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"ic_more_list_other_nor")] forState:UIControlStateSelected];
    }
    else{
        [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_nor")] forState:UIControlStateNormal];
        [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_pressed")] forState:UIControlStateSelected];
    }
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    
    if (self.style == LXMoreMainCellStyleNor) {
        [_contentView setTitleColor: titleColor forState:UIControlStateNormal];
    }
    else{
        self.titleLabel.textColor = titleColor;
    }
}

-(void)setSecTitleColor:(UIColor *)secTitleColor{
    _secTitleColor = secTitleColor;
    if (secTitleColor == nil) {
        return ;
    }
    [self.infoButton setTitleColor: secTitleColor forState:UIControlStateNormal];
}



#pragma mark - 点击
-(void)buttonClick:(UIButton*)btn{
    LXLog(@"%s",__func__);
    
    if (self.cellBlock) {
        self.cellBlock();
    }
}

-(void)cellClickBlock:(LXMoreMainCellBlock)block{
    self.cellBlock = block;
}

@end
