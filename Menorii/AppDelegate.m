//
//  AppDelegate.m
//  Menorii
//
//  Created by Ricardo Pereira on 12/08/2014.
//  Copyright (c) 2014 Ricardo Pereira. All rights reserved.
//

#import "AppDelegate.h"

#import <Crashlytics/Crashlytics.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"d8e4a998430741c25fc8939d85d1dee852ab2fb9"];
    return YES;
}

@end
