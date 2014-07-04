//
//  ZYJsonSerialization.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYJsonSerialization.h"

@implementation ZYJsonSerialization

/*!
 * @method serialize:error:
 * 序列化对象为json字符串
 * @param object 被序列化的对象
 * @param error 序列化发生错误的错误信息
 * @result 序列化结果，若发生错误返回nil
 */
+(NSString *)serialize:(id)object error:(NSError **)error {
    id jsonObj = nil;
    if ([object isKindOfClass:[NSArray class]]) {
        jsonObj = [[[NSMutableArray alloc]init] autorelease];
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
        if (jsonData == nil) {
            return nil;
        }
        NSString *json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
}

/*!
 * @method getObjectProperties:
 * 获取对象的字典数据
 * 对象需实现 ZYJsonSerializationProtocol 协议
 * @param object 需转换的对象
 * @result 对象对应的属性字典数据
 */
+(NSMutableDictionary*)getObjectProperties:(id)object {
    NSMutableDictionary *objProperties = nil;
    unsigned int count;
    objc_property_t* properties = class_copyPropertyList([object class],&count);
    if (count > 0) {
        NSMutableArray *ocproperties = [[[NSMutableArray alloc]init]autorelease];
        for (int i = 0; i < count; i++) {
            [ocproperties addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
        }
        objProperties = [[[NSMutableDictionary alloc]initWithDictionary:[object dictionaryWithValuesForKeys:ocproperties]] autorelease];
        free(properties);
    }
    else {
        objProperties = [[[NSMutableDictionary alloc]init] autorelease];
    }
    SEL encodeSelector = @selector(encodePropertiesValue:);
    if ([object respondsToSelector:encodeSelector]) {
        [object performSelector:encodeSelector withObject:objProperties];
    }
    return objProperties;
}

/*!
 * @method deserialize:targetType:error:
 * 将json字符串反序列化为对象
 * 对象需实现 ZYJsonSerializationProtocol 协议
 * @param object 被序列化的对象
 * @param error 序列化发生错误的错误信息
 * @param targetType 对象类型
 * @result 对象实例，若发生错误返回nil
 */
+(id)deserialize:(NSString*)jsonString targetType:(Class)targetType error:(NSError **)error {
    id result = nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:error];
    if (jsonObject == nil) {
        return nil;
    }
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        result = [[[NSMutableArray alloc]init]autorelease];
        for (id subObj in jsonObject) {
            id obj = [[ZYJsonSerialization getObjectWithProperties:subObj targetType:targetType] autorelease];
            if (obj != nil) {
                [result addObject:obj];
            }
        }
    }
    else {
        result = [[ZYJsonSerialization getObjectWithProperties:jsonObject targetType:targetType]autorelease];
    }
    
    return result;
}

/*!
 * @method getObjectWithProperties:targetType:
 * 根据字典数据实例化对象
 * 对象需实现 ZYJsonSerializationProtocol 协议
 * @param properties 字典数据
 * @param targetType 对象类型
 * @result 对象实例，若发生错误返回nil
 */
+(id)getObjectWithProperties:(NSMutableDictionary*)properties targetType:(Class)targetType {
    id target = class_createInstance(targetType, class_getInstanceSize(targetType));
    SEL decodeSelector = @selector(decodePropertiesValue:);
    [target setValuesForKeysWithDictionary:properties];
    if([target respondsToSelector:decodeSelector]) {
        [target performSelector:decodeSelector withObject:properties];
    }
    return target;
}

@end
