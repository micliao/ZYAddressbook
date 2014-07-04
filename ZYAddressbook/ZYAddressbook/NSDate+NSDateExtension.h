//
//  NSDate+NSDateExtension.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateExtension)

/*!
 *  @method toString
 *  将日期转换为文本 格式：“yyyy-MM-dd HH:mm:ss”
 */
-(NSString*)toString;

/*!
 *  @method toString:
 *  将日期转换为指定格式文本
 */
-(NSString*)toString:(NSString*)formatString;

/*!
 *  @method fromString:
 *  将文本转换为日期 文本格式：“yyyy-MM-dd HH:mm:ss”
 */
+(instancetype)fromString:(NSString*)dateString;

/*!
 *  @method fromString:format:
 *  将指定格式文本转换为日期
 */
+(instancetype)fromString:(NSString*)dateString format:(NSString*)formatString;

@end
