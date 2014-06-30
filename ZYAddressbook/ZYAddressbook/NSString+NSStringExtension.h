//
//  NSString+NSStringExtension.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @interface NSString (NSStringExtension)
 @abstract 扩展nsstring
 */
@interface NSString (NSStringExtension)

/*!
    @method containsString:
    @abstract 是否包含字符串（不区分大小写）
    @param string 被检索的字符串
    @result 包含返回YES 否则NO
 */
-(BOOL)containsString:(NSString *)string;

@end
