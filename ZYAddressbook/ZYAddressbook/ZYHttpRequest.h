//
//  NSObject+HttpRequestExtension.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYHttpResponseDelegate.h"

/*!
    @interface HttpRequest http请求封装
 */
@interface ZYHttpRequest : NSObject <NSURLConnectionDataDelegate>
{
    id<ZYHttpResponseDelegate> httpResponseDelegate;
    NSString *httpMethod;
    NSString *httpRequestUrl;
    NSMutableDictionary *paramaters;
    NSString *paramaterFormat;
    bool isRequestSuccess;
}

-(ZYHttpRequest*)initWithRequestUrl:(NSString*)requestUrl method:(NSString*)method respenseDelegate:(id<ZYHttpResponseDelegate>)delegate;

-(void)addParamaterFor:(NSString*)paramaterName byValue:(NSString*)paramaterValue;

-(void)setParamaterFor:(NSString*)paramaterName byValue:(NSString*)paramaterValue;

-(void)removeParamaterBy:(NSString*)paramaterName;

-(void)doHttpRequest;

@end
