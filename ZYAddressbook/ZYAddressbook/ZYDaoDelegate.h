//
//  ZYDaoDelegate.h
//  ZYAddressbook
//  DAO基础协议
//  Created by elemeNT on 14-6-24.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYDaoDelegate <NSObject>

@required

-(int)insert:(NSObject*)object;

-(void)delete:(NSObject*)object;

-(int)update:(NSObject*)object;

-(NSObject*)select:(int)indentity;

@end
