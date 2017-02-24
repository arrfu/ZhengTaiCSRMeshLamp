//
//  LXTool.h
//  snailbulb
//
//  Created by lxz on 16/1/26.
//  Copyright © 2016年 TRP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXTool : NSObject
+ (void)showText:(NSString *)text;
//file
+ (NSString *)documentPathWithPathName:(NSString *)path;
+ (NSString *)cachePathWithPathName:(NSString *)pathName;
+ (NSString *)DPLocalizedString:(NSString *)translation_key;
+(BOOL)isLanguageZh;
+(NSString *)languageSign;

+(BOOL)isLanguageHasPrefix:(NSString*)str;

/**
 * 设置图片大小
 */
+(UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size;

//判断当前是否有网
+(BOOL)isNetWork;

/**
 * 字典转json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 * 数组转json字符串
 */
+(NSString*)arrayToJson:(NSArray*)array;

/**
 * uint8_t 转 NSString
 */
+(NSString*)uint8ToStringWith:(uint8_t*)data Length:(int)len WithoutZero:(BOOL)isWithout;
@end
