//
//  NSDate+NSDateExtension.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateExtension)

-(NSString*)toString;
-(NSString*)toString:(NSString*)formatString;
+(instancetype)fromString:(NSString*)dateString;
+(instancetype)fromString:(NSString*)dateString format:(NSString*)formatString;

@end
