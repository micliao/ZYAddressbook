//
//  ZYNSMutableDictionary.m
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYNSMutableDictionary.h"

@implementation ZYNSMutableDictionary

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self->dictionary forKey:@"dictionary"];
    [aCoder encodeObject:self->indexArray forKey:@"indexArray"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self->dictionary = [aDecoder decodeObjectForKey:@"dictionary"];
        self->indexArray = [aDecoder decodeObjectForKey:@"indexArray"];
    }
    
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        self->dictionary = [[NSMutableDictionary alloc]init];
        self->indexArray = [[NSMutableArray alloc]init];
    }
    return self;
}

/*!
 @method setValue:forIndex:
 @abstract 设置数字索引值
 @param value 索引值
 @param forIndex 索引
 */
-(void)setValue:(NSObject *)value forIndex:(NSInteger)index
{
    if (index < [self->indexArray count] && index >= 0) {
        [self->dictionary setObject:value forKey:self->indexArray[index]];
    }
}

/*!
 @method setValue:forKey:
 @abstract 设置键索引值
 @param value 索引值
 @param forKey 键索引
 */
-(void)setValue:(NSObject *)value forKey:(id<NSCopying>)key {
    if([self->dictionary objectForKey:key] == nil) {
        [self->indexArray addObject:key];
    }
    [self->dictionary setObject:value forKey:key];
}

/*!
 @method objectForIndex:
 @abstract 获取数字索引值
 @param index 索引
 @return 索引值
 */
-(id)objectForIndex:(NSInteger)index
{
    return [self->dictionary objectForKey:self->indexArray[index]];
}

/*!
 @method initWithIndexedObjects:forKeys:
 @abstract 初始化字典并生成数字索引
 @param objects 值
  @param keys 键
 */
-(id)initWithIndexedObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    self = [super init];
    if (self) {
        self->dictionary = [[NSMutableDictionary alloc]initWithObjects:objects forKeys:keys];
        self->indexArray = [[NSMutableArray alloc]initWithArray:keys copyItems:YES];
    }
    return self;
}

/*!
 @method objectAtIndexedSubscript:
 @abstract 数字索引器访问实现
 @param idx 索引
 */
-(id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return [self->dictionary objectForKey:self->indexArray[idx]];
}

/*!
 @method setObject:atIndexedSubscript:
 @abstract 数字索引器访问实现
 @param anObject 值
 @param index 索引
 */
-(void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index
{
    [self->dictionary setObject:anObject forKey:self->indexArray[index]];
    
}

/*!
 @method removeObjectForKey:
 @abstract 移除指定键
 @param key 键
 */
-(void)removeObjectForKey:(id)key {
    
    if ([self->indexArray containsObject:key]) {
        [self->indexArray removeObject:key];
    }
    [self->dictionary removeObjectForKey:key];
}

/*!
 *@method removeObjectForIndex:
 *@abstract 移除指定数字索引
 *@param index 键
 */
-(void)removeObjectForIndex:(int)index {
    if (index < [self->indexArray count] && index >= 0) {
        NSObject *key = self->indexArray[index];
        [self->dictionary removeObjectForKey:key];
        [self->indexArray removeObjectAtIndex:index];
    }
}

/*!
 @method keyForIndex:
 @abstract 获取索引位置键
 @param index 索引
 @result 键
 */
-(id)keyForIndex:(NSInteger)index
{
    return self->indexArray[index];
}

/*!
 @method realDictionary:
 @abstract 获取真实字典
 @result 真实字典
 */
-(NSMutableDictionary *)realDictionary
{
    return self->dictionary;
}

@end
