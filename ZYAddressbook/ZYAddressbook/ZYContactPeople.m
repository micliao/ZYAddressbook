//
//  ZYContactPeople.m
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactPeople.h"

@implementation ZYContactPeople

/*!
    @method getAllContacts
    @abstract 获取所有通讯录成员
 */
+(NSMutableArray*)getAllContacts {
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
    ABAddressBookRef tmpAddressBook = nil;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 6.0) {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
        case kABAuthorizationStatusNotDetermined:
                ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error){});
                break;
        case kABAuthorizationStatusAuthorized:
                tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                break;
        default:
                break;
        }
    }
    else {
        tmpAddressBook = ABAddressBookCreate();
    }
    
    NSArray* addressBooks = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    if (addressBooks != nil && [addressBooks count] > 0){
        for(NSObject *people in addressBooks) {
            ZYContactPeople *contact = [[ZYContactPeople alloc]init];
            contact.firstName = (__bridge NSString *)(ABRecordCopyValue((__bridge ABRecordRef)(people), kABPersonFirstNameProperty));
            contact.middleName = (__bridge NSString *)(ABRecordCopyValue((__bridge ABRecordRef)(people), kABPersonMiddleNameProperty));
            contact.lastName = (__bridge NSString *)(ABRecordCopyValue((__bridge ABRecordRef)(people), kABPersonLastNameProperty));
            [contacts addObject:contact];
        }
    }

    return contacts;
}

/*!
 @method isContains:
 @abstract 是否包含搜索文本
 @param searchText 搜索文本
 */
-(BOOL)isContains:(NSString*)searchText {
    return (self.firstName !=nil && [self.firstName containsString:searchText]) || (self.middleName != nil && [self.middleName containsString:searchText]) || (self.lastName != nil && [self.lastName containsString:searchText]) || [self isPropertyInfosContains:searchText];
}

/*!
 @method isPropertyInfosContains:
 @abstract 是属性否包含搜索文本
 @param searchText 搜索文本
 */
-(BOOL)isPropertyInfosContains:(NSString*)searchText {
    BOOL result = NO;
    if (self.propertyInfos != nil && self.propertyInfos.realDictionary != nil && [self.propertyInfos.realDictionary count] > 0) {
        for (NSObject *infoType in self.propertyInfos.realDictionary) {
            for (ZYContactInfo *info in self.propertyInfos.realDictionary[infoType]) {
                result = [info isContains:searchText];
                if (result) {
                    return result;
                }
            }
        }
    }
    return result;
}

@end
