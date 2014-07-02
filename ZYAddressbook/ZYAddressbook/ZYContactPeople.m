//
//  ZYContactPeople.m
//  ZYAddressbook
//
//  Created by shang on 14/6/29.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYContactPeople.h"

@implementation ZYContactPeople

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstName forKey:@"firstName"];
    [aCoder encodeObject:self.middleName forKey:@"middleName"];
    [aCoder encodeObject:self.lastName forKey:@"lastName"];
    [aCoder encodeObject:[[NSNumber alloc]initWithInteger:self.phoneKey ] forKey:@"phoneKey"];
    [aCoder encodeObject:self.propertyInfos forKey:@"propertyInfos"];
    [aCoder encodeObject:self.lastestDateTime forKey:@"lastestDateTime"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.middleName = [aDecoder decodeObjectForKey:@"middleName"];
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.phoneKey = [[aDecoder decodeObjectForKey:@"phoneKey"] integerValue];
        self.propertyInfos = [aDecoder decodeObjectForKey:@"propertyInfos"];
        self.lastestDateTime = [aDecoder decodeObjectForKey:@"lastestDateTime"];
    }
    
    return self;
}

/*!
 @method isContains:
 @abstract 是否包含搜索文本
 @param searchText 搜索文本
 */
-(BOOL)isContains:(NSString*)searchText {
    return (self->nameLetters != nil && [self->nameLetters containsString:searchText]) || (self.firstName != nil && [self.firstName containsString:searchText]) || (self.middleName != nil && [self.middleName containsString:searchText]) || (self.lastName != nil && [self.lastName containsString:searchText]) || [self isPropertyInfosContains:searchText];
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

-(void) setFirstName:(NSString *)firstName {
    self->_firstName = firstName;
    [self setName];
}

-(NSString*)firstName {
    return self->_firstName;
}

-(void)setMiddleName:(NSString *)middleName {
    self->_middleName = middleName;
    [self setName];
}

-(NSString*)middleName {
    return self->_middleName;
}

-(void)setLastName:(NSString *)lastName {
    self->_lastName = lastName;
    [self setName];
}

-(NSString*)lastName {
    return self->_lastName;
}

/*!
 @method nameLetters
 @abstract 获取名字的拼音字母
 */
-(NSString*)nameLetters {
    return self->nameLetters;
}

/*!
 @method viewName
 @abstract 获取用于显示的名称组合
 */
-(NSString*) viewName {
    return self->viewName;
}

-(void)setName {
    self->viewName = [NSString stringWithFormat:@"%@%@%@",self.lastName ? self.lastName : @"",self.middleName ? self.middleName : @"",self.firstName ? self.firstName : @""];
    
    NSString *pinyin = [ChineseToPinyin pinyinFromChiniseString:self->viewName];
    self->nameLetters = pinyin == nil || [pinyin length] == 0 ? @"#" : pinyin;
}

@end
