//
//  NSString+NSStringExtension.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "NSString+NSStringExtension.h"

@implementation NSString (NSStringExtension)

/*!
 @method containsString:
 @abstract 是否包含字符串（不区分大小写）
 @param string 被检索的字符串
 @result 包含返回YES 否则NO
 */
-(BOOL)containsString:(NSString *)string {
    return [self rangeOfString:string options:NSCaseInsensitiveSearch].location != NSNotFound;
}

@end
