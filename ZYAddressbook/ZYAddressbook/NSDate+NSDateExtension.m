//
//  NSDate+NSDateExtension.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "NSDate+NSDateExtension.h"

@implementation NSDate (NSDateExtension)

/*!
 *  @method toString
 *  将日期转换为文本 格式：“yyyy-MM-dd HH:mm:ss”
 */
-(NSString*)toString {
    return [self toString:@"yyyy-MM-dd HH:mm:ss"];
}

/*!
 *  @method toString:
 *  将日期转换为指定格式文本
 */
-(NSString*)toString:(NSString*)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatString];
    return [dateFormatter stringFromDate:self];
}

/*!
 *  @method fromString:
 *  将文本转换为日期 文本格式：“yyyy-MM-dd HH:mm:ss”
 */
+(instancetype)fromString:(NSString*)dateString {
    return [NSDate fromString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
}

/*!
 *  @method fromString:format:
 *  将指定格式文本转换为日期
 */
+(instancetype)fromString:(NSString*)dateString format:(NSString*)formatString {
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:dateString];
}

@end
