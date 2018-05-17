//
//  AppDelegate.h
//  4Cast
//
//  Created by Chris Woodard on 3/23/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL useMock;
@property (nonatomic, strong) NSString *statusProfileName;
@end

