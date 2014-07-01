//
//  ZYCache.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-1.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYArchiveCache : NSObject
{
    NSString *cachePath;
}

-(id)init;
-(void)writeCacheFile:(id)cacheData toFile:(NSString*)fileName;
-(id)readCache:(NSString*)fileName;

+(NSString*)contactCacheFileName;
+(NSString*)contactAvatarCacheFileName;

@end


