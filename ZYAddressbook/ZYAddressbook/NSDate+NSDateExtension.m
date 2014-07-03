//
//  NSDate+NSDateExtension.m
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "NSDate+NSDateExtension.h"

@implementation NSDate (NSDateExtension)

-(NSString*)toString {
    return [self toString:@"yyyy-MM-dd HH:mm:ss"];
}

-(NSString*)toString:(NSString*)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatString];
    return [dateFormatter stringFromDate:self];
}

+(instancetype)fromString:(NSString*)dateString {
    return [NSDate fromString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
}

+(instancetype)fromString:(NSString*)dateString format:(NSString*)formatString {
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:dateString];
}

@end
