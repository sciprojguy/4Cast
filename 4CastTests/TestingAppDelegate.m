//
//  TestingAppDelegate.m
//  4CastTests
//
//  Created by Chris Woodard on 4/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "TestingAppDelegate.h"

@implementation TestingAppDelegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.useMock = YES;
    return YES;
}


@end
