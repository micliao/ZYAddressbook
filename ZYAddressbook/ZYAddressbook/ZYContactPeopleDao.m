//
//  ZYContactPeopleDao.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactPeopleDao.h"

@implementation ZYContactPeopleDao

-(int)insert:(NSObject*)object {
    return 0;
}

-(void)delete:(NSObject*)object {

}

-(int)update:(NSObject*)object {
    return 0;
}

-(NSObject*)select:(int)indentity {
    return nil;
}

/*!
 @method readAddressBook
 @abstract 读取通讯录通讯录成员
 @result 所有通讯录成员
 */
-(NSArray*)readAddressBook {
    ABAddressBookRef tmpAddressBook = nil;
    __block BOOL accessGranted = YES;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 6.0) {
        tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        accessGranted = status == kABAuthorizationStatusAuthorized;
    }
    else {
        tmpAddressBook = ABAddressBookCreate();
    }
    NSArray *addressArray = (NSArray*)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(tmpAddressBook));
    CFRelease(tmpAddressBook);
    return [[NSArray alloc]initWithObjects:[[NSNumber alloc] initWithBool:accessGranted], addressArray,nil];
}

/*
 @method convertAddressbookRecord:
 @abstract 将通讯录对象转换为自定义对象
 @param people 通讯录对象
 @result 通讯录成员自定义对象
 */
-(ZYContactPeople*)convertAddressbookRecord:(ABRecordRef)people {
    ZYContactPeople *contact = [[ZYContactPeople alloc]init];
    contact.firstName = (NSString *)CFBridgingRelease(ABRecordCopyValue(people, kABPersonFirstNameProperty));
    contact.middleName = ( NSString *)CFBridgingRelease(ABRecordCopyValue(people, kABPersonMiddleNameProperty));
    contact.lastName = ( NSString *)CFBridgingRelease(ABRecordCopyValue(people, kABPersonLastNameProperty));
    contact.phoneKey = (NSInteger)ABRecordGetRecordID(people);
    contact.lastestDateTime = (NSDate*)CFBridgingRelease(ABRecordCopyValue(people, kABPersonModificationDateProperty));
    return contact;
}

/*!
 @method getAllContactPeoples
 @abstract 获取所有通讯录成员
 @result 所有通讯录成员
 */
-(ZYNSMutableDictionary*)getAllContactPeoples {
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
    NSArray *address = [self readAddressBook];
    BOOL accessGranted = [address[0] boolValue];
    NSArray* addressBooks = address[1];
    
    if (addressBooks != nil && [addressBooks count] > 0){
        for(NSObject *people in addressBooks) {
            ZYContactPeople *contact = [self convertAddressbookRecord:(ABRecordRef)(people)];
            [contacts addObject:contact];
            CFRelease(CFBridgingRetain(people));
        }
    }
    
    return [[ZYNSMutableDictionary alloc] initWithIndexedObjects:[[NSArray alloc]initWithObjects:contacts, nil] forKeys:[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithBool:accessGranted], nil]];
}

/*!
 @method getAllContactPeoplesExcept:
 @abstract 获取排除成员外的所有通讯录成员
 @param exceptPhonekeys 排除成员健值
 @result 所有通讯录成员
 */
-(ZYNSMutableDictionary*)getAllContactPeoplesExcept:(NSArray*)exceptPhonekeys {
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
    NSArray *address = [self readAddressBook];
    BOOL accessGranted = [address[0] boolValue];
    NSArray* addressBooks = address[1];
    
    if (addressBooks != nil && [addressBooks count] > 0){
        for(NSObject *people in addressBooks) {
            ZYContactPeople *contact = [self convertAddressbookRecord:(ABRecordRef)(people)];
            BOOL isExcept = NO;
            if (exceptPhonekeys != nil && [exceptPhonekeys count] > 0) {
                for (NSNumber *key in exceptPhonekeys) {
                    if ([key integerValue] == contact.phoneKey) {
                        isExcept = YES;
                        break;
                    }
                }
            }
            if (!isExcept) {
                [contacts addObject:contact];
            }
            CFRelease(CFBridgingRetain(people));
        }
    }
    
    return [[ZYNSMutableDictionary alloc] initWithIndexedObjects:[[NSArray alloc]initWithObjects:contacts, nil] forKeys:[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithBool:accessGranted], nil]];
}

/*!
 @method getAllContactPeoples
 @abstract 获取所有缓存通讯录成员
 @result 所有缓存通讯录成员
 */
-(NSMutableArray*)getAllCachedContactPeoples {
     NSMutableArray *contacts = [[[ZYArchiveCache alloc]init] readCache:ZYArchiveCache.contactCacheFileName];
    return contacts;
}

/*!
 @method setContactPeoplesCache:
 @abstract 缓存通讯录成员
 */
-(void)setContactPeoplesCache:(NSMutableArray *)contactPeoples {
    [[[ZYArchiveCache alloc]init] writeCacheFile:contactPeoples toFile:ZYArchiveCache.contactCacheFileName];
}

@end
