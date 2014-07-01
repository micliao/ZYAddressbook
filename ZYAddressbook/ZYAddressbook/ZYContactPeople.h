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
#import "ChineseToPinyin.h"

/*!
    @interface ZYContactPeople
    @abstract 通讯录成员定义
 */
@interface ZYContactPeople : NSObject<NSCoding>
{
    NSString *nameLetters;
    NSString *_firstName;
    NSString *_middleName;
    NSString *_lastName;
    NSString *viewName;
}

//名
@property NSString *firstName;
//中名
@property NSString *middleName;
//姓
@property NSString *lastName;
//属性
@property ZYNSMutableDictionary *propertyInfos;
//唯一标识
@property NSInteger phoneKey;

-(BOOL)isContains:(NSString*)searchText;

-(NSString*)nameLetters;

-(NSString*) viewName;

@end
