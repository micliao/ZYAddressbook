//
//  ZYContactPeopleService.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactPeopleService.h"

@implementation ZYContactPeopleService

-(BOOL)add:(NSObject*)object {
    return [[[ZYContactPeopleDao alloc]init] insert:object];
}

-(BOOL)drop:(NSObject*)object {
    [[[ZYContactPeopleDao alloc]init] delete:object];
    return YES;
}

-(BOOL)modify:(NSObject*)object {
    [[[ZYContactPeopleDao alloc]init] update:object];
    return YES;
}

-(NSObject*)get:(int)ID {
    return [[[ZYContactPeopleDao alloc]init] select:ID];
}

/*!
    @method getAllContactPeoples
    @abstract 获取所有通讯录成员 未分组
    @result ZYNSMutableDictionary 键为是否获得用户批准访问通讯录 值为通讯录成员数组
 */
-(ZYNSMutableDictionary*)getAllContactPeoples {
    ZYNSMutableDictionary *result = [[[ZYContactPeopleDao alloc]init] getAllContactPeoples];
    if ([result keyForIndex:0]) {
        return [[ZYNSMutableDictionary alloc]initWithIndexedObjects:[[NSArray alloc] initWithObjects:[result[0] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            ZYContactPeople *peo1 = (ZYContactPeople*)obj1;
            ZYContactPeople *peo2 = (ZYContactPeople*)obj2;
            return [[peo1 nameLetters] compare:[peo2 nameLetters]];
        }],nil] forKeys:[[NSArray alloc]initWithObjects:[result keyForIndex:0], nil]];
    }
    return result;
}

/*!
 @method getAllContactPeoplesGroupByFirstLetter
 @abstract 获取所有通讯录成员 按姓氏首字母分组
 @result ZYNSMutableDictionary 键为是否获得用户批准访问通讯录 值为已分组通讯录成员字典
 */
-(ZYNSMutableDictionary*)getAllContactPeoplesGroupByFirstLetter {
    ZYNSMutableDictionary *contacts = [self getAllContactPeoples];
    if ([contacts keyForIndex:0]) {
        ZYNSMutableDictionary *groupContacts = [self groupContactPeoples:contacts[0]];
        return [[ZYNSMutableDictionary alloc]initWithIndexedObjects:[[NSArray alloc] initWithObjects:groupContacts,nil] forKeys:[[NSArray alloc]initWithObjects:[contacts keyForIndex:0], nil]];
    }
    
    return contacts;
}

/*!
 @method getAllContactPeoplesGroupByFirstLetterExcept:
 @abstract 获取排除人员外的所有通讯录成员 按姓氏首字母分组
 @param exceptPeople 排除人员
 @result ZYNSMutableDictionary 键为是否获得用户批准访问通讯录 值为已分组通讯录成员字典
 */
-(ZYNSMutableDictionary*)getAllContactPeoplesGroupByFirstLetterExcept:(NSArray*)exceptPeople {
    NSMutableArray *array = nil;
    if (exceptPeople != nil && [exceptPeople count] > 0) {
        array = [[NSMutableArray alloc]init];
        for (ZYContactPeople *p in exceptPeople) {
            [array addObject: [[NSNumber alloc] initWithInteger: p.phoneKey]];
        }
    }

    ZYNSMutableDictionary *result = [[[ZYContactPeopleDao alloc]init] getAllContactPeoplesExcept:array];
    if ([result keyForIndex:0]) {
        ZYNSMutableDictionary* contacts = [self groupContactPeoples:[result[0] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            ZYContactPeople *peo1 = (ZYContactPeople*)obj1;
            ZYContactPeople *peo2 = (ZYContactPeople*)obj2;
            return [[peo1 nameLetters] compare:[peo2 nameLetters]];
        }]];
        return [[ZYNSMutableDictionary alloc]initWithIndexedObjects:[[NSArray alloc] initWithObjects:contacts,nil] forKeys:[[NSArray alloc]initWithObjects:[result keyForIndex:0], nil]];
    }
    return result;
}

/*!
 @method getAllCachedContactPeoplesGroupByFirstLetter
 @abstract 获取所有缓存通讯录成员 按姓氏首字母分组
 @result ZYNSMutableDictionary 已分组通讯录成员字典
 */
-(ZYNSMutableDictionary*)getAllCachedContactPeoplesGroupByFirstLetter {
    NSMutableArray *contacts = [[[ZYContactPeopleDao alloc]init] getAllCachedContactPeoples];
    if (contacts == nil) {
        return nil;
    }
    return [self groupContactPeoples:[contacts sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        ZYContactPeople *peo1 = (ZYContactPeople*)obj1;
        ZYContactPeople *peo2 = (ZYContactPeople*)obj2;
        return [[peo1 nameLetters] compare:[peo2 nameLetters]];
    }]];
}

/*
 @method setContactPeoplesCache:
 @abstract 缓存通讯录成员
 */
-(void)setContactPeoplesCache:(ZYNSMutableDictionary*)contactPeoples {
    NSMutableArray *contacts = nil;
    if (contactPeoples != nil && contactPeoples.realDictionary != nil && contactPeoples.realDictionary.count > 0) {
        contacts = [[NSMutableArray alloc]init];
        
        for (NSString *group in contactPeoples.realDictionary) {
            for (ZYContactPeople *people in contactPeoples.realDictionary[group]) {
                [contacts addObject:people];
            }
        }
    }
    [[[ZYContactPeopleDao alloc]init] setContactPeoplesCache:contacts];
}

/*!
 @method groupContactPeoples:
 @abstract 将通讯录成员按姓氏首字母分组
 @result ZYNSMutableDictionary 已分组通讯录成员字典
 */
-(ZYNSMutableDictionary*)groupContactPeoples:(NSArray*)contactPeoples {
    ZYNSMutableDictionary *groupContacts = [[ZYNSMutableDictionary alloc]init];
    for (ZYContactPeople *people in contactPeoples) {
        NSString *firstLetter = [[people nameLetters] substringWithRange:NSMakeRange(0,1)];
        if ([groupContacts.realDictionary.allKeys containsObject:firstLetter]) {
            [groupContacts.realDictionary[firstLetter] addObject:people];
        }
        else {
            [groupContacts setValue:[[NSMutableArray alloc] initWithObjects:people,nil] forKey:firstLetter];
        }
    }
    return groupContacts;
}
@end
