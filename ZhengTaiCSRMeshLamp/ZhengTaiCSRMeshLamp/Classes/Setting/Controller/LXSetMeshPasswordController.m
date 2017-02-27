//
//  LXSetMeshPasswordController.m
//  ZhengTaiCSRMeshLamp
//
//  Created by hao123 on 2017/2/27.
//  Copyright © 2017年 arrfu. All rights reserved.
//

#import "LXSetMeshPasswordController.h"

#define LX_TextField_MaxLength 20 // 最大长度

@interface LXSetMeshPasswordController ()<UITextFieldDelegate>{
    UIView *bgView;
    UITextField *pswTextField;
    UITextField *repeatTextField; // 确认密码
    BOOL isEditStart;
}


@end

@implementation LXSetMeshPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = mainBgColor;
    
    self.title = LXLocalizedString(@"网络密码");
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
    
    CGFloat margValue = 15;
    bgView = [[UIView alloc] initWithFrame:CGRectMake(margValue, margValue, kScreenWidth-2*margValue, kScreenHeight*0.5)];
    
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bgView];
    
    CGFloat marFieldX = 25;
    // password
    pswTextField = [[UITextField alloc] initWithFrame:CGRectMake(marFieldX, 30*kScaleH, bgView.jf_width-2*marFieldX, 50)];
    pswTextField.placeholder = LXLocalizedString(@"  请输入网络密码");
        pswTextField.backgroundColor = mainBgColor;
    [pswTextField addTarget:self action:@selector(pswTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    pswTextField.font = mainFontSize(15);
    pswTextField.delegate = self;
    [bgView addSubview:pswTextField];
    //    userInforView.userInteractionEnabled = NO;
    pswTextField.textColor = kTextColorC2;
    pswTextField.tintColor = kTextColorC2;
    pswTextField.secureTextEntry = YES;
    
    // password
    repeatTextField = [[UITextField alloc] initWithFrame:CGRectMake(pswTextField.jf_x, pswTextField.jf_y+pswTextField.jf_height+20*kScaleH, pswTextField.jf_width, 50)];
    repeatTextField.placeholder = LXLocalizedString(@"   请再次输入网络密码");
        repeatTextField.backgroundColor = mainBgColor;
    //    [repeatTextField addTarget:self action:@selector(pswTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    repeatTextField.font = mainFontSize(15);
    repeatTextField.delegate = self;
    [bgView addSubview:repeatTextField];
    //    userInforView.userInteractionEnabled = NO;
    repeatTextField.textColor = kTextColorC2;
    repeatTextField.tintColor = kTextColorC2;
    repeatTextField.secureTextEntry = YES;

    
    
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


#pragma mark - 确认取消按钮点击

-(void)sureCancelButtonnClick:(UIButton*)sender{
    LXLog(@"%d",sender.tag);
    
    [self.view endEditing:YES];
    
}


#pragma mark - 密码输入
- (void)userTextFieldChanged:(UITextField *)textField {
    
}

- (void)pswTextFieldChanged:(UITextField *)textField {
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    isEditStart = YES;
//    [self updateUI];
//    
//    wrongTipsLabel.text = @"";
//    wrongTipsLabel.hidden = YES;
//    repeatTextField.textColor = mainTextColorSelect;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    isEditStart = NO;
//    [self updateUI];
    
    
    if (textField == repeatTextField) {
        if (![self isTheSameWithTwicePassword]) {
            LXShowToast(@"两次密码输入不一致");
//            wrongTipsLabel.text = LXLocalizedString( @"两次密码输入不一致");
//            wrongTipsLabel.hidden = NO;
//            repeatTextField.textColor = mainWarningColor;
        }
        else{
//            wrongTipsLabel.text = @"";
//            wrongTipsLabel.hidden = YES;
//            repeatTextField.textColor = mainTextColorSelect;
        }
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOOL isLegal = YES;
    NSInteger existedLength = textField.text.length;
    
    NSInteger selectedLength = range.length;
    
    NSInteger replaceLength = string.length;
    
    if(existedLength - selectedLength + replaceLength >LX_TextField_MaxLength) {
        
        isLegal = NO;
        
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    if (![string isEqualToString:filtered]) {
        //        LXShowToast(@"特殊符号");
        isLegal = NO;
    }
    
    if (isLegal == NO) {
        LXShowToast(@"请输入20位以内英文或数字");
//        wrongTipsLabel.text = LXLocalizedString(@"请输入6至20位英文或数字");
//        wrongTipsLabel.textColor = mainWarningColor;
//        wrongTipsLabel.hidden = NO;
    }
    else{
//        wrongTipsLabel.hidden = YES;
    }
    
    // 当输入确认密码时，实时检测
    if (textField==repeatTextField && repeatTextField.text!=nil && pswTextField.text!=nil
        && pswTextField.text.length >= repeatTextField.text.length && isLegal==YES) {
        
        if ([repeatTextField.text isEqualToString:[pswTextField.text substringToIndex:repeatTextField.text.length]]) {
//            wrongTipsLabel.hidden = YES;
        }
        else{
//            wrongTipsLabel.text = LXLocalizedString(@"两次密码输入不一致");
//            wrongTipsLabel.textColor = mainWarningColor;
//            wrongTipsLabel.hidden = NO;
        }
        
    }
    
    return isLegal;
    
}


#pragma mark - touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    isEditStart = NO;
//    [self updateUI];
}

/**
 * 判断账号密码是否符合要求
 */
-(BOOL)checkingAvailableWithUserAndPassword{
    
    if (!pswTextField.text || pswTextField.text.length==0) {
        LXShowToast(@"请输入密码");
//        wrongTipsLabel.text = LXLocalizedString(@"请输入密码");
        return NO;
    }
    else if (!repeatTextField.text || repeatTextField.text.length==0) {
        LXShowToast(@"请确认密码");
//        wrongTipsLabel.text = LXLocalizedString(@"请确认密码");
        return NO;
    }
    
    
    if (![self isTheSameWithTwicePassword]) {
        LXShowToast(@"两次密码输入不一致");
//        wrongTipsLabel.text = LXLocalizedString( @"两次密码输入不一致");
        return NO;
    }
    
    return YES;
}

/**
 * 判断两次输入密码是否一致
 */
-(BOOL)isTheSameWithTwicePassword{
    if (repeatTextField.text!=nil && [repeatTextField.text isEqualToString:pswTextField.text]) {
        return YES;
    }
    
    return NO;
}


@end
