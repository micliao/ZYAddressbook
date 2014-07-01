//
//  ZYCache.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-1.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYArchiveCache.h"

static NSString* contactCacheFileNameString = @"contactCache.archive";
static NSString* contactAvatarCacheFileNameString = @"contactAvatarCache.archive";

/*!
 @interface ZYArchiveCache
 @abstract 是否包含搜索文本
 */
@implementation ZYArchiveCache

-(id)init {
    self->cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ZhiyunCache"];
    return self;
}

-(void)writeCacheFile:(id)cacheData toFile:(NSString *)fileName {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:self->cachePath isDirectory:&isDir];
    if (!existed || !isDir) {
        [fileManager createDirectoryAtPath:self->cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [NSKeyedArchiver archiveRootObject:cacheData toFile:[self->cachePath stringByAppendingPathComponent:fileName]];
}

-(id)readCache:(NSString *)fileName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self->cachePath stringByAppendingPathComponent:fileName]];
}

+(NSString*)contactCacheFileName {
    return contactCacheFileNameString;
}

+(NSString*)contactAvatarCacheFileName {
    return contactAvatarCacheFileNameString;
}
@end
