//
//  ZYWSideTableView.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWSideTableView.h"

@interface ZYWSideTableView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *arrayM;
@property(nonatomic,strong) LXNotifiCationObject * notifiCation;

@end

@implementation ZYWSideTableView
//    实例化
-(NSMutableArray *)arrayM{
    if (_arrayM==nil) {
        _arrayM=[NSMutableArray array];
    }
    return _arrayM;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    //    设置代理和数据源
    self.delegate=self;
    self.dataSource=self;
    
    self.rowHeight=50;
    self.backgroundColor = secBgColor;
    
    self.separatorStyle=NO;
    _isShowGroup = NO;
    self.notifiCation = [[LXNotifiCationObject alloc] init];
    
    //添加通知监听
    [self addObserve];
    return  self;
}

//实现数据源方法
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(_isShowGroup)
    {
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"ic_more_siderbar_bt"];
            cell.textLabel.text=LXLocalizedString(@"bluetooth_conn");
        }else if (indexPath.row==1){
            cell.imageView.image=[UIImage imageNamed:@"ic_more_siderbar_group"];
            cell.textLabel.text = LXLocalizedString(@"grouping_manager");
        }else if (indexPath.row==2){
            cell.imageView.image=[UIImage imageNamed:@"ic_more_siderbar_feedback"];
            cell.textLabel.text = LXLocalizedString(@"help_feedback");
        }else if (indexPath.row==3){
            cell.imageView.image=[UIImage imageNamed:@"ic_more_siderbar_update"];//空18个
            cell.textLabel.text = [LXLocalizedString(@"version_code") stringByAppendingString:[@"                  V" stringByAppendingString:VERSION]];
            

            
        }
    }else
    {
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"ic_sider_bt"];
            cell.textLabel.text=LXLocalizedString(@"蓝牙连接");
        }else if (indexPath.row==1){
            cell.imageView.image=[UIImage imageNamed:@"ic_sider_feedback"];
            cell.textLabel.text = LXLocalizedString(@"问题反馈");
        }else if (indexPath.row==2){
            cell.imageView.image=[UIImage imageNamed:@"ic_sider_about"];
            cell.textLabel.text = LXLocalizedString(@"关于领婴");
            
            
        }
    }
   
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
//    if ([cell.textLabel.text isEqualToString:LXLocalizedString(@"bluetooth_conn")]
//        || [cell.textLabel.text isEqualToString:LXLocalizedString(@"help_feedback")]) {
//        cell.selectedBackgroundView.backgroundColor = LXColor(221, 232, 238);
//    }
    
    cell.textLabel.textColor= mainTextColor;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self notifiZYWSide:indexPath];
    LXLog(@"jnkjn");
}

-(void)notifiZYWSide:(NSIndexPath *) indexPath
{
    self.notifiCation.notifiIndex = indexPath.row;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification" object:self.notifiCation];
}

-(void) addObserve
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectState:) name:@"connectStateNotification" object:nil];

}
//蓝牙连接成功
//-(void)connectSuccess
//{
//    LXBluetoothDeviceType bluetoothDeviceType = [LXDeviceConnectionManager sharedLXDeviceConnectionManager].bluetoothDeviceType;
//    if ( bluetoothDeviceType == LXBluetoothDeviceTypeR433 || bluetoothDeviceType == LXBluetoothDeviceType24G)
//    {
//        _isShowGroup = YES;
//    }else
//    {
//        _isShowGroup = NO;
//    }
//    [self reloadData];
//}

-(void)connectFail
{
    _isShowGroup = NO;
    [self reloadData];
}

-(void)connectState:(NSNotification*)notification
{
    
//    ConnectState *notifiObject = (ConnectState*)[notification object];
//    if(notifiObject.state)
//    {
//        [self connectSuccess];
//    }else
//    {
//        [self connectFail];
//    }
    
}


//设备搜到的蓝牙设备
-(void)lXBlueDeviceConnectWith:(NSMutableArray*)PeripheralArray{}

@end
