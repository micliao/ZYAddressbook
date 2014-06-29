//
//  ZYContactInfo.m
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactInfo.h"

@implementation ZYContactInfo

/*!
 @method isContains:
 @abstract 是否包含搜索文本
 @param searchText 搜索文本
 */
-(BOOL)isContains:(NSString*)searchText {
    if ([self.propertyValue isMemberOfClass:[NSString class]]) {
        return [((NSString*)self.propertyValue) containsString:searchText];
    }
    return [[self.propertyValue description] containsString:searchText];
}

@end
