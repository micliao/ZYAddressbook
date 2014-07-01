//
//  ZYContactInfo.h
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+NSStringExtension.h"

/*!
    @interface ZYContactInfo
    @abstract 通讯录属性
 */
@interface ZYContactInfo : NSObject<NSCoding>

//属性名称
@property NSString *propertyLabel;
//属性值
@property NSObject *propertyValue;

-(BOOL)isContains:(NSString*)searchText;

@end

/*!
 @enum ZYContactInfoType
 @abstract 通讯录属性类型
 */
enum ZYContactInfoType {
    TelephoneNumber,
    Email,
    Birthday
};
