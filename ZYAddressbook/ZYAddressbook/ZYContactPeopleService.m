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

-(NSDictionary*)getAllContactPeoples {
    return [[[ZYContactPeopleDao alloc]init] getAllContactPeoples];
}

-(NSDictionary*)getAllContactPeoplesGroupByFirstLetter {
    NSDictionary *contacts = [self getAllContactPeoples];
    return contacts;
}
@end
