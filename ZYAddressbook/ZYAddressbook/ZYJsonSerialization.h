//
//  ZYJsonSerialization.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYJsonSerializationProtocol.h"
#import <objc/runtime.h>

@interface ZYJsonSerialization : NSObject

/*!
 * @method serialize:error:
 * 序列化对象为json字符串
 * @param object 被序列化的对象
 * @param error 序列化发生错误的错误信息
 * @result 序列化结果，若发生错误返回nil
 */
+(NSString *)serialize:(id)object error:(NSError **)error;
/*!
 * @method getObjectProperties:
 * 获取对象的字典数据
 * 对象需实现 ZYJsonSerializationProtocol 协议
 * @param object 需转换的对象
 * @result 对象对应的属性字典数据
 */
+(NSMutableDictionary*)getObjectProperties:(id)object;
/*!
 * @method deserialize:targetType:error:
 * 将json字符串反序列化为对象
 * 对象需实现 ZYJsonSerializationProtocol 协议
 * @param object 被序列化的对象
 * @param error 序列化发生错误的错误信息
 * @param targetType 对象类型
 * @result 对象实例，若发生错误返回nil
 */
+(id)deserialize:(NSString*)jsonString targetType:(Class)targetType error:(NSError **)error;

@end
