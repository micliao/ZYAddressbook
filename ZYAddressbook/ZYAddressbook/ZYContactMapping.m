//
//  ZYContactMapping.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-2.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactMapping.h"

@implementation ZYContactMapping

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:[[NSNumber alloc]initWithInteger:self.phoneKey] forKey:@"phoneKey"];
    [aCoder encodeObject:[[NSNumber alloc]initWithInteger:self.serverKey] forKey:@"serverKey"];
    [aCoder encodeObject:self.version forKey:@"version"];
    [aCoder encodeObject:[[NSNumber alloc]initWithInteger:self.versionType] forKey:@"versionType"];
    [aCoder encodeObject:self.versionDate forKey:@"versionDate"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.phoneKey = [[aDecoder decodeObjectForKey:@"phoneKey"] integerValue];
        self.serverKey = [[aDecoder decodeObjectForKey:@"serverKey"] integerValue];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.versionType = [[aDecoder decodeObjectForKey:@"versionType"] integerValue];
        self.versionDate = [aDecoder decodeObjectForKey:@"versionDate"];
    }
    return self;
}

-(void)encodePropertiesValue:(NSMutableDictionary*)propertiesDictionary {
    [propertiesDictionary setValue:[self.version UUIDString] forKey:@"version"];
    [propertiesDictionary setValue:[self.versionDate toString] forKey:@"versionDate"];
}

-(void)decodePropertiesValue:(NSDictionary*)propertiesDictionary {
    self.version = [[NSUUID alloc]initWithUUIDString:[propertiesDictionary valueForKey:@"version"]];
    self.versionDate = [NSDate fromString:[propertiesDictionary valueForKey:@"versionDate"]];
}

@end
