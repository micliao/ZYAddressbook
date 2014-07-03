//
//  ZYJsonSerialization.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYJsonSerializationProtocol.h"

@interface ZYJsonSerialization : NSObject

+(NSString *)serialize:(id)object error:(NSError **)error;
+(id)deserialize:(NSString*)jsonString error:(NSError **)error;

@end
