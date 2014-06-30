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
 @method getAllContactPeoples
 @abstract 获取所有通讯录成员
 @result
 */
-(NSDictionary*)getAllContactPeoples {
    NSMutableArray *contacts = [[NSMutableArray alloc]init];
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
    
    return [[NSDictionary alloc]initWithObjectsAndKeys:contacts,accessGranted, nil];
}

@end
