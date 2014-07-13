//
//  ZYContactPeopleService.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-30.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYServiceDelegate.h"
#import "ZYContactPeopleDao.h"
#import "ZYNSMutableDictionary.h"

@interface ZYContactPeopleService : NSObject<ZYServiceDelegate>

-(ZYNSMutableDictionary*)getAllContactPeoples;
-(ZYNSMutableDictionary*)getAllContactPeoplesGroupByFirstLetter;
-(ZYNSMutableDictionary*)getAllContactPeoplesGroupByFirstLetterExcept:(NSArray*)exceptPeople;
-(ZYNSMutableDictionary*)getAllCachedContactPeoplesGroupByFirstLetter;
-(void)setContactPeoplesCache:(ZYNSMutableDictionary*)contactPeoples;

@end
