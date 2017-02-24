//
//  AppDelegate.m
//  ColorBluetoothLampRedSparrow
//
//  Created by hao123 on 2017/2/3.
//  Copyright © 2017年 snaillove. All rights reserved.
//

#import "AppDelegate.h"
#import "LXMainViewController.h"
#import "Reachability.h"
#import "UMMobClick/MobClick.h"
#import "ZYWContainerViewController.h"
#import "LXMainViewController.h"

@interface AppDelegate  (){
    Reachability *_hostReach;
}
//当前的网络状态
@property(nonatomic,assign)NetworkStatus currentNetworkStatus;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // cocoalumberjack 初始化
    [self initWithCocoaLumberjackLog];
    
    // 1、主界面
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    // 直接进入主界面
//    ZYWContainerViewController *CVC=[[ZYWContainerViewController alloc]init];
     LXMainViewController *CVC=[[LXMainViewController alloc]init];
    
    self.window.rootViewController = CVC;
    [self.window makeKeyAndVisible];
    
    // 2、设置导航栏主题
    [LXNavigationController setupNavTheme];
    
    //3、开启网络状况的监听
    [self networkMonitoring];
    
    // 初始化网络请求配置信息
    [self initNetworkingConfig];
    
    //4、 添加友盟
//    [self startUMMengForKey:@"580aff57f43e4835dc002c54"];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 * cocoalumberjack 初始化
 */
-(void)initWithCocoaLumberjackLog{
    [DDLog addLogger:[DDASLLogger sharedInstance]];   // 发送到苹果的日志系统，他们显示到控制台上），个人建议没有必要
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];  //设置输出带颜色
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger     （把输出信息写进文件中）
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //      The above code tells the application to keep a week's worth of log files on the system.
    //      上面的代码是告诉应用程序保持一周的日志文件系统
    
    //    DDLogError(@"Paper jam");
    //    DDLogWarn(@"Toner is low");
    //    DDLogInfo(@"Warming up printer (pre-customization)");
}

#pragma mark - 初始化网络请求配置信息
-(void)initNetworkingConfig{
    // 通常放在appdelegate就可以了
    [HYBNetworking updateBaseUrl:LXNetworkBaseUrl];
    [HYBNetworking enableInterfaceDebug:YES];
    
    // 配置请求和响应类型，由于部分伙伴们的服务器不接收JSON传过去，现在默认值改成了plainText
    [HYBNetworking configRequestType:kHYBRequestTypePlainText
                        responseType:kHYBResponseTypeJSON
                 shouldAutoEncodeUrl:YES
             callbackOnCancelRequest:NO];
    
    // 设置GET、POST请求都缓存
    [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
}

#pragma mark - 网络监听
//网络监听
- (void)networkMonitoring{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    _hostReach = [Reachability reachabilityForInternetConnection];
    [_hostReach startNotifier];  //开始监听,会启动一个run loop
    
    [LXTool isNetWork];
}

//监听到网络状态改变
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    [self updateInterfaceWithReachability: curReach];
    
}

//处理连接改变后的情况
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    //对连接改变做出响应的处理动作。
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if(status == ReachableViaWWAN)
    {
        if(self.currentNetworkStatus == NotReachable){
            //
        }
        [self changeTo3GWWAN];
        printf("\n3g/2G\n");
    }
    else if(status == ReachableViaWiFi)
    {
        if(self.currentNetworkStatus == NotReachable){
            //
        }
        printf("\nwifi\n");
    }else
    {
        LXShowToast(@"无网络");
        printf("\n无网络\n");
    }
    self.currentNetworkStatus = status;
}

-(void)changeTo3GWWAN{
    
}

#pragma mark - 初始化友盟
-(void)startUMMengForKey:(NSString *)key
{
    UMConfigInstance.appKey = key;
    UMConfigInstance.channelId = @"App Store";
    UMConfigInstance.ePolicy = SEND_INTERVAL;
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}


@end
