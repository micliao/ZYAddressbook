//
//  ZYJsonSerializationProtocol.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-3.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYJsonSerializationProtocol <NSObject>

@property NSArray *nomalProperties;

-(void)encodePropertiesValue:(NSMutableDictionary*)propertiesDictionary;
-(void)decodePropertiesValue:(NSDictionary*)propertiesDictionary;

@end
