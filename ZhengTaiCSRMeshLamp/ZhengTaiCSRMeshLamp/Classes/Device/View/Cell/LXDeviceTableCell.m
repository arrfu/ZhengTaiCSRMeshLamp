//
//  LXDeviceTableCell.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/25.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXDeviceTableCell.h"

@interface LXDeviceTableCell(){
    UIView *bgView;
    UILabel *titleLabel;
    UIButton *editButton;
    UIButton *_stateIcon;
}


@end

@implementation LXDeviceTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addCellUI];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}


/**
 * 创建界面
 */
-(void)addCellUI{
    // 背景
    bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-20, LXDeviceTableCellHeight-10)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    [self.contentView addSubview:bgView];
    //    [self addSubview:bgView];
    
    // 图标
    editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(15, 0, 40, 40);
    editButton.jf_centerY = bgView.jf_height*0.5;
//    editButton.imageEdgeInsets = UIEdgeInsetsMake(0, 17*kScaleH, 0, 0);
    [editButton setImage:[UIImage imageNamed:LXLocalizedString(@"Device-dmg-icon")] forState:UIControlStateNormal];
    [editButton setImage:[UIImage imageNamed:LXLocalizedString(@"Device-dmg-icon")] forState:UIControlStateSelected];
    editButton.tag = 101;
    //    [editButton addTarget:self action:@selector(editButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    editButton.backgroundColor = [UIColor clearColor];
    [bgView addSubview:editButton];
    editButton.userInteractionEnabled = NO;
    
    // 标题
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(editButton.jf_x+editButton.jf_width+15, 0, kScreenWidth-80, bgView.jf_height)];
    titleLabel.text = @"客厅大厅";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = mainFontSize(19);
    titleLabel.textColor = mainTextColor;
    [bgView addSubview:titleLabel];
    
    
    // 箭头
    _stateIcon = [UIButton buttonWithType:UIButtonTypeCustom]; //  12 19
    _stateIcon.frame = CGRectMake(bgView.jf_width-44-10, 0, 44, bgView.jf_height);
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"Device-tie-arw")] forState:UIControlStateNormal];
    [_stateIcon setImage:[UIImage imageNamed:LXLocalizedString(@"Device-tie-arw")] forState:UIControlStateSelected];
    _stateIcon.backgroundColor = [UIColor clearColor]; //  btn_lamp_list_other_nor ic_more_list_other_nor
    [bgView addSubview:_stateIcon];
    _stateIcon.userInteractionEnabled = NO; // 关闭点击
    

    
}

//#pragma mark - 选中点击
//-(void)editButtonClick:(UIButton*)sender{
//    LXLog(@"%s",__func__);
//
//    sender.selected = !sender.selected;
//
//
//
//}



-(void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = title;

}






@end
