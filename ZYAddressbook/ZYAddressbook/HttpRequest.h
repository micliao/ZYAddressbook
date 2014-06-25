//
//  NSObject+HttpRequestExtension.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponseDelegate.h"

/*!
    @interface HttpRequest http请求封装
 */
@interface HttpRequest : NSObject <NSURLConnectionDataDelegate>
{
    id<HttpResponseDelegate> httpResponseDelegate;
    NSString *httpMethod;
    NSURL *httpRequestUrl;
    NSMutableDictionary *paramaters;
    NSString *paramaterFormat;
}

-(HttpRequest*)initWithRequestUrl:(NSString*)requestUrl method:(NSString*)method respenseDelegate:(id<HttpResponseDelegate>)delegate;

-(void)addParamater:(NSString*)paramaterName addParamaterValue:(NSString*)paramaterValue;

-(void)setParamater:(NSString*)paramaterName setParamaterValue:(NSString*)paramaterValue;

-(void)removeParamater:(NSString*)paramaterName;

-(void)doHttpRequest;

@end
