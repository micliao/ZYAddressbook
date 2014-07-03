//
//  ZYJsonSerialization.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYJsonSerialization.h"

@implementation ZYJsonSerialization

+(NSString *)serialize:(id)object error:(NSError **)error {
    id jsonObj = nil;
    if ([object isMemberOfClass:[NSArray class]]) {
        jsonObj = [[NSMutableArray alloc]init];
        for (id subObject in object) {
            NSMutableDictionary *objProperties = [ZYJsonSerialization getObjectProperties:subObject];
            if (objProperties != nil && [objProperties count] > 0) {
                [jsonObj addObject:objProperties];
            }
        }
    }
    else{
        jsonObj = [ZYJsonSerialization getObjectProperties:object];
    }
    
    if (jsonObj == nil) {
        return @"null";
    }
    else {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj options:NSJSONWritingPrettyPrinted error:error];
        NSString *json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
}

+(NSMutableDictionary*)getObjectProperties:(id)object {
    NSMutableDictionary *objProperties = nil;
    if ([object conformsToProtocol:@protocol(ZYJsonSerializationProtocol)]) {
        NSArray *nomalProperties = [object propertyForKey:@"nomalProperties"];
        if (nomalProperties != nil && [nomalProperties count] > 0) {
            objProperties = [[NSMutableDictionary alloc]initWithDictionary:[object dictionaryWithValuesForKeys:nomalProperties]];
        }
        else {
            objProperties = [[NSMutableDictionary alloc]init];
        }
        [object performSelector:@selector(encodePropertiesValue:) withObject:objProperties];
    }
    return objProperties;
}

+(id)deserialize:(NSString*)jsonString error:(NSError **)error {
    return nil;
}

@end
