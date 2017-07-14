//
//  AppDelegate.m
//  ObjcSample
//
//  Created by Julian Gruber on 14/07/2017.
//  Copyright © 2017 Julian Gruber. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@import TwitterSearchKit;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Set Twitter credentials
    TSTwitterSearchKit.tokenCredentials = @"R0l4N1ZoZ1J0Z1YzTjk5Z2VPOHVNZzFzNTpJR2lEUXhubmpXMExSNkVMSVVqNEo4T0VwSTZRbG12ZGJNWE9QVGNNS0Y5aDNBR3dIRA==";
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = nav;
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
