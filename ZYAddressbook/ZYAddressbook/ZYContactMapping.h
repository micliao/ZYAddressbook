//
//  ZYContactMapping.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ContactMappingVersionType {
    Add = 0,Delete,Update
};

@interface ZYContactMapping : NSObject<NSCoding>

@property NSInteger phoneKey;
@property NSInteger serverKey;
@property NSUUID *version;
@property NSDate *versionDate;
@property enum ContactMappingVersionType versionType;

@end
