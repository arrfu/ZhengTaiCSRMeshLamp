//
//  LXWeekTabCellView.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/26.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXWeekTabCellView.h"

@interface LXWeekTabCellView(){
    
    UIButton *_contentView;
    UIButton *_stateIcon;
    UILabel *_titleLabel;
}

@property (nonatomic,copy)LXWeekTabCellViewBlock cellBlock;

@end


@implementation LXWeekTabCellView

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
    
    // 箭头
    _stateIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    _stateIcon.frame = CGRectMake(0, 0, 10, 10);
    _stateIcon.jf_centerY = _contentView.jf_height*0.5;
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_nor")] forState:UIControlStateNormal];
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"btn_lamp_list_other_pressed")] forState:UIControlStateSelected];
    _stateIcon.backgroundColor = [UIColor clearColor]; //  btn_lamp_list_other_nor ic_more_list_other_nor
    [_contentView addSubview:_stateIcon];
    _stateIcon.userInteractionEnabled = NO; // 关闭点击
    
        
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_stateIcon.jf_x+_stateIcon.jf_width+5*kScaleW, 0, _contentView.jf_width-_stateIcon.jf_width, _contentView.jf_height)];
    _titleLabel.text = @"客厅大厅";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = mainFontSize(19);
    _titleLabel.textColor = kTextColorC1;
    [_contentView addSubview:_titleLabel];
    
    
    
    
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

-(void)setFont:(UIFont *)font{
    _font = font;
    _titleLabel.font = font;
}

-(void)setImageNor:(NSString*)nor select:(NSString*)select{
    [_stateIcon setImage:[UIImage imageNamed:nor] forState:UIControlStateNormal];
    [_stateIcon setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
}

#pragma mark - 点击
-(void)buttonClick:(UIButton*)btn{
//    LXLog(@"%s",__func__);
//    _stateIcon.selected = !_stateIcon.selected;
    
//    if (((self.tag >=LXWeekTabCellTag) && (self.tag <=(LXWeekTabCellTag+2))) &&  _stateIcon.selected) {
//        // 三大类型只能点击，不能取消
//        return ;
//    }
    
    if (self.isDisSelect &&  _stateIcon.selected) {
        // 只能点击，不能取消
        return ;
    }
    
    _stateIcon.selected = !_stateIcon.selected;
    self.isSelect = _stateIcon.selected;
    
    if (self.cellBlock) {
        self.cellBlock(self.tag,_stateIcon.selected);
    }
}

-(void)setLXWeekTabCellViewBlockClick:(LXWeekTabCellViewBlock)block{
    self.cellBlock = block;
}

-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    _stateIcon.selected = isSelect;
    
}

@end
