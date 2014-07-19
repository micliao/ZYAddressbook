//
//  ZYContactInfo.m
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactInfo.h"

@implementation ZYContactInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.propertyName forKey:@"propertyLabel"];
    [aCoder encodeObject:self.propertyValue forKey:@"propertyValue"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.propertyName = [aDecoder decodeObjectForKey:@"propertyLabel"];
        self.propertyValue = [aDecoder decodeObjectForKey:@"propertyValue"];
    }
    
    return self;
}

/*!
 @method isContains:
 @abstract 是否包含搜索文本
 @param searchText 搜索文本
 */
-(BOOL)isContains:(NSString*)searchText {
    if ([self.propertyValue isMemberOfClass:[NSString class]]) {
        return [((NSString*)self.propertyValue) containsString:searchText];
    }
    return [[self.propertyValue description] containsString:searchText];
}

@end
