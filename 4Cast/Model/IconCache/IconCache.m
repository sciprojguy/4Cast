//
//  IconCache.m
//  4Cast
//
//  Created by Chris Woodard on 3/24/18.
//  Copyright © 2018 SampleSoft. All rights reserved.
//

#import "IconCache.h"

@interface IconCache ()
@property (nonatomic, strong) NSString *iconCachePath;
@end

@implementation IconCache

-(NSString *)cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[NSString alloc] initWithFormat:@"%@/Icons", paths[0]];
}

+(instancetype)sharedCache {
    static IconCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[IconCache alloc] init];
        cache.iconCachePath = [cache cachePath];
        [[NSFileManager defaultManager] createDirectoryAtPath:cache.iconCachePath withIntermediateDirectories:YES attributes:nil error:nil];
    });
    return cache;
}

-(UIImage *)iconNamed:(NSString *)iconName {
    NSString *iconPath = [[NSString alloc] initWithFormat:@"%@/%@.png", self.iconCachePath, iconName];
    return [[UIImage alloc] initWithContentsOfFile:iconPath];
}

-(void)storeIcon:(NSData *)icon withName:(NSString *)iconName {
    //construct path - cache.iconCachePath + "/iconName".jpg
    NSString *iconPath = [[NSString alloc] initWithFormat:@"%@/%@.png", self.iconCachePath, iconName];
    [icon writeToFile:iconPath atomically:NO];
}

@end
