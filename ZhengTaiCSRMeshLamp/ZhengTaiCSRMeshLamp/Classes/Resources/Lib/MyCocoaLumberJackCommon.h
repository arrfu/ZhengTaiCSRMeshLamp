//
//  Common.h
//  Logtest
//
//  Created by Vincent Wang on 16/5/11.
//  Copyright © 2016年 subvin.inc. All rights reserved.
//

#ifndef MyCocoaLumberJackCommon_h
#define MyCocoaLumberJackCommon_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#define LOG_LEVEL_DEF ddLogLevel

#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["


#if 0
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_MAC
#endif

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelError;
#endif

/*
 如果你设置的日志级别为 LOG_LEVEL_ERROR那么你只会看到DDlogError语句的输出。
 如果你将日志的级别设置为LOG_LEVEL_WARN那么你只会看到DDLogError和DDLogWarn语句。
 如果您将日志级别设置为 LOG_LEVEL_INFO,您将看到error、Warn和信息报表。
 如果您将日志级别设置为LOG_LEVEL_VERBOSE,您将看到所有DDLog语句。
 如果您将日志级别设置为 LOG_LEVEL_OFF,你不会看到任何DDLog语句。
 */


#endif /* MyCocoaLumberJackCommon_h */
