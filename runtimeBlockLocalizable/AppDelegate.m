//
//  AppDelegate.m
//  runtimeBlockLocalizable
//
//  Created by Alan on 2019/4/2.
//  Copyright © 2019年 Alan. All rights reserved.
//

#import "AppDelegate.h"
#import "ZQInternationalManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    //1.程序启动 , 获取用户设置的app语言
    NSString *userLanguage = [[NSUserDefaults standardUserDefaults]objectForKey:@"userLanguage"];
    
    //2.如果没有 , 则设定手机设置语言为app语言(系统会自动完成,读取@"appleLanguage") ,存储手机设置语言为app语言
    if (!userLanguage.length) {
        
        //2.1获取手机设置语言
        NSString *phoneLanguage = [[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"]firstObject];
        
        //2.2 存储app语言到沙盒
        [[NSUserDefaults standardUserDefaults]setObject: phoneLanguage forKey:@"userLanguage"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        //3.有app语言情况
    }else{
        
        //3.1设置app语言
        
        //3.11获取app语言对应的bundle
        NSString *userLanguagePath = [[NSBundle mainBundle]pathForResource:userLanguage ofType:@"lproj"];
        NSBundle *userLanguageBundle = [NSBundle bundleWithPath:userLanguagePath];
        
        //存储当前app内语言
        [ZQInternationalManager sharedInternationalManager].languageBunle = userLanguageBundle;
        
    }
    
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


@end
