//
//  LXTool.m
//  snailbulb
//
//  Created by lxz on 16/1/26.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import "LXTool.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"

@implementation LXTool
+ (void)showText:(NSString *)text {
    //    [MBProgressHUD showWithText:text];
    [self showPlayModelWithText:text];
}

+(void)showPlayModelWithText:(NSString*)text{
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setImage:[UIImage imageNamed:@"icon_tick"] forState:UIControlStateNormal];
    btn.enabled = NO;
    btn.adjustsImageWhenDisabled = NO; //当按钮不可用时，不要调节图片
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:LXColor(63, 181, 226) forState:UIControlStateNormal];
    //249, 133, 38
    [btn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.94]];
    CGFloat btnW = [[UIScreen mainScreen] bounds].size.width;
    btn.titleLabel.font  = [UIFont systemFontOfSize:16];
    btn.titleLabel.lineBreakMode = 0;
    btn.frame = CGRectMake(0, -64, btnW, 64);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    CGFloat inset = 30;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    //添加图片
    UIImageView *imgaeView= [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 15, 15)];
    imgaeView.image = [UIImage imageNamed:@"icon_tick"];
    [btn addSubview:imgaeView];
    [currentWindow addSubview:btn];
    
    CGFloat duration = 2;
    [UIView animateWithDuration:0.3 animations:^{
        
        
        btn.transform = CGAffineTransformMakeTranslation(0, 64);
        
    } completion:^(BOOL finished)
     {
         [UIView animateKeyframesWithDuration:0.3 delay:1.0  options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
             btn.transform = CGAffineTransformIdentity;
         } completion:^(BOOL finished) {
             [btn removeFromSuperview];
         }];
         
     }];
    
}



//file
//文档目录
+ (NSString *)documentPathWithPathName:(NSString *)path {
    //    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *docDir = documents[0];
    NSString *paths = [docDir stringByAppendingPathComponent:path];
    return paths;
}

//缓存目录
+ (NSString *)cachePathWithPathName:(NSString *)pathName {
    NSArray *caches = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = caches[0];
    NSString *paths = [cacheDir stringByAppendingPathComponent:pathName];
    return paths;
}

+ (NSString *)DPLocalizedString:(NSString *)translation_key {
    
    NSString * s = NSLocalizedString(translation_key, nil);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    
    NSString * CURR_LANG = [allLanguages objectAtIndex:0];
    //    MyLog(@"CURR_LANG %@",CURR_LANG);
    
    if (![CURR_LANG hasPrefix:@"en"] && ![CURR_LANG hasPrefix:@"zh"]) {
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }
    
    return s;
    
}

+(NSString *)languageSign
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    
    NSString * CURR_LANG = [allLanguages objectAtIndex:0];
    if ([CURR_LANG hasPrefix:@"zh"]) {
        return @"1";
    }else
    {
        return @"2";
    }
    
}
+(BOOL)isLanguageZh{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    
    NSString * CURR_LANG = [allLanguages objectAtIndex:0];
    if ([CURR_LANG hasPrefix:@"zh"]) {
        return YES;
    }else
    {
        return NO;
    }
}

+(BOOL)isLanguageHasPrefix:(NSString*)str{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    
    NSString * CURR_LANG = [allLanguages objectAtIndex:0];
    if ([CURR_LANG hasPrefix:str]) {
        return YES;
    }else
    {
        return NO;
    }
}

/**
 * 设置图片大小
 */
+(UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

//判断当前是否有网
+(BOOL)isNetWork {
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //DDLogVerbose(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //DDLogVerbose(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //DDLogVerbose(@"3G");
            break;
    }
    
    return isExistenceNetwork;
}




/**
 * 字典转json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


/**
 * 数组转json字符串
 */
+(NSString*)arrayToJson:(NSArray*)array

{
    
    NSError* parseError =nil;
    
    //options=0转换成不带格式的字符串
    
    //options=NSJSONWritingPrettyPrinted格式化输出
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:array options:0 error:&parseError];
    
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/**
 * uint8_t 转 NSString
 */
+(NSString*)uint8ToStringWith:(uint8_t*)data Length:(int)len WithoutZero:(BOOL)isWithout{
    NSMutableString *temStr = [[NSMutableString alloc] init];
    for (int i = 0; i < len; i++) {
        if (isWithout == YES) {
            if (data[i] != 0) {
                [temStr appendFormat:@"%c",data[i]];
            }
        }
        else{
            [temStr appendFormat:@"%c",data[i]];
        }
        
    }
    
    return temStr;
}



@end
