//
//  AppDelegate.m
//  auto
//
//  Created by bangong on 15/6/1.
//  Copyright (c) 2015年 车质网. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "CZWAppPrompt.h"
#import "Appirater.h"

#import "JPEngine.h"

@interface AppDelegate ()
{
   UIScrollView *_scrollView;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];

    CZWAppPrompt *prompt = [CZWAppPrompt sharedInstance];
    prompt.appId = THE_APPID;
    [prompt shouAlert:AppPromptStyleScore];
    [prompt shouAlert:AppPromptStyleUpdate];

    //统一设置导航栏标题颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    //电池条颜色
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    CustomTabBarController *custom = [[CustomTabBarController alloc] init];

    self.window.rootViewController = custom;

    //友盟统计
    [self um_analyics];
    /**友盟分享*/
    [self um_social];
  
     self.window.backgroundColor = [UIColor whiteColor];
    [NSThread sleepForTimeInterval:2.0];
    [_window makeKeyAndVisible];
 
    return YES;
}

- (UIView *)genView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    view.backgroundColor = [UIColor redColor];
    return view;

}

/**友盟统计*/
- (void)um_analyics{
#if DEBUG
    return;
#endif
   
    UMConfigInstance.appKey = @"55f913b2e0f55aaf49003031";
    UMConfigInstance.channelId = @"http://www.12365auto.com/zhuanti/app/index.aspx";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
    
}

/**友盟分享*/
- (void)um_social{

    [[UMSocialManager defaultManager] setUmSocialAppkey:@"55f913b2e0f55aaf49003031"];
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1104736184" appSecret:@"PfKmY8sIFec4zQdE" redirectURL:@"http://www.12365auto.com"];
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxa8074491f7b6fba6" appSecret:@"b6d0bb0d1473fc5c126f800ec39a3a70" redirectURL:@"http://www.12365auto.com"];
    //新浪微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"269405812" appSecret:@"92de194ff9af2e808537dfdb587de3be" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];

}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
