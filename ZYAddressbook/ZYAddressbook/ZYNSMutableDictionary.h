//
//  ZYNSMutableDictionary.h
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @interface ZYNSMutableDictionary
 @abstract 自定义数字索引字典
 */
@interface ZYNSMutableDictionary : NSObject
{
    NSMutableArray *indexArray;
    NSMutableDictionary *dictionary;
}

-(NSMutableDictionary *)realDictionary;
-(void)setValue:(NSObject *)value forIndex:(NSInteger)index;
-(id)objectForIndex:(NSInteger)index;
-(id)initWithIndexedObjects:(NSArray *)objects forKeys:(NSArray *)keys;
-(id)objectAtIndexedSubscript:(NSUInteger)idx;
-(void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index;
-(id)keyForIndex:(NSInteger)index;

@end
