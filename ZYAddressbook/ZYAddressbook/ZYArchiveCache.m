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
static NSString* contactMappingCacheFileNameString = @"contactMappingCache.archive";

/*!
 @interface ZYArchiveCache
 @abstract 是否包含搜索文本
 */
@implementation ZYArchiveCache

/*!
    @method init
    @abstract 初始化
 */
-(id)init {
    self->cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"ZhiyunCache"];
    return self;
}

/*!
 @method writeCacheFile:toFile:
 @abstract 将数据写入缓存文件
 @param cacheData 数据
 @param fileName 文件名
 */
-(void)writeCacheFile:(id)cacheData toFile:(NSString *)fileName {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:self->cachePath isDirectory:&isDir];
    if (!existed || !isDir) {
        [fileManager createDirectoryAtPath:self->cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [NSKeyedArchiver archiveRootObject:cacheData toFile:[self->cachePath stringByAppendingPathComponent:fileName]];
}

/*!
 @method readCache:
 @abstract 读取缓存文件
 @param fileName 文件名
 @result 缓存文件数据，若未找到则返回nil
 */
-(id)readCache:(NSString *)fileName {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self->cachePath stringByAppendingPathComponent:fileName]];
}

/*!
 @method contactCacheFileName
 @abstract 通讯录缓存文件名称
 @result 通讯录缓存文件名称
 */
+(NSString*)contactCacheFileName {
    return contactCacheFileNameString;
}

/*!
 @method contactAvatarCacheFileName
 @abstract 通讯录头像缓存文件名称
 @result 通讯录头像缓存文件名称
 */
+(NSString*)contactAvatarCacheFileName {
    return contactAvatarCacheFileNameString;
}

/*!
 @method contactMappingCacheFileName
 @abstract 通讯录映射缓存文件名称
 @result 通讯录映射缓存文件名称
 */
+(NSString*)contactMappingCacheFileName {
    return contactMappingCacheFileNameString;
}
@end
