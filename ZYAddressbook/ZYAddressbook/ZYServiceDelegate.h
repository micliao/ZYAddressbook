//
//  ZYServiceDelegate.h
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYServiceDelegate <NSObject>

-(BOOL)add:(NSObject*)object;

-(BOOL)drop:(NSObject*)object;

-(BOOL)modify:(NSObject*)object;

-(NSObject*)get:(int)ID;

@end
