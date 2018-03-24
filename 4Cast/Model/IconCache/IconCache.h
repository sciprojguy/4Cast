//
//  IconCache.h
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconCache : NSObject

+(instancetype)sharedCache;

-(UIImage *)iconNamed:(NSString *)iconName;
-(void)storeIcon:(NSData *)icon withName:(NSString *)iconName;

@end
