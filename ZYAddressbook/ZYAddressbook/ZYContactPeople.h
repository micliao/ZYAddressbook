//
//  ZYContactPeople.h
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYContactInfo.h"
#import "ZYNSMutableDictionary.h"
#import <AddressBook/AddressBook.h>
#import "NSString+NSStringExtension.h"

/*!
    @interface ZYContactPeople
    @abstract 通讯录成员定义
 */
@interface ZYContactPeople : NSObject

//姓
@property NSString *firstName;
//中名
@property NSString *middleName;
//名
@property NSString *lastName;
//属性
@property ZYNSMutableDictionary *propertyInfos;

+(NSArray*)getAllContacts;
-(BOOL)isContains:(NSString*)searchText;

@end
