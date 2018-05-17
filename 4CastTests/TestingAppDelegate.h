//
//  TestingAppDelegate.h
//  4CastTests
//
//  Created by Chris Woodard on 4/13/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

@import UIKit;

@interface TestingAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL useMock;
@property (nonatomic, strong) NSString *statusProfileName;

@end
