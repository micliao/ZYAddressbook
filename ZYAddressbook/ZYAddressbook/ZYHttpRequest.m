//
//  NSObject+HttpRequestExtension.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYHttpRequest.h"

@implementation ZYHttpRequest

-(ZYHttpRequest*)initWithRequestUrl:(NSString*)requestUrl method:(NSString*)method respenseDelegate:(id<ZYHttpResponseDelegate>)delegate
{
    self -> httpRequestUrl =[[NSURL alloc] initWithString:(requestUrl)];
    self -> httpMethod = method;
    self -> httpResponseDelegate = delegate;
    self -> paramaterFormat = @"%@:%@";
    return self;
}

-(void)addParamater:(NSString*)paramaterName addParamaterValue:(NSString*)paramaterValue
{
    [self -> paramaters setObject:paramaterValue forKey:paramaterName];
}

-(void)setParamater:(NSString*)paramaterName setParamaterValue:(NSString*)paramaterValue
{
    [self -> paramaters setObject:paramaterValue forKey:paramaterName];
}

-(void)removeParamater:(NSString*)paramaterName
{
    [self -> paramaters removeObjectForKey:paramaterName];
}

-(void)doHttpRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: self -> httpRequestUrl];
    NSString *paramatersString = @"";
    if (self -> paramaters.count > 0) {
        int i = 0;
        for (id key in  self -> paramaters) {
            paramatersString = [paramatersString stringByAppendingString: [(i > 0 ? @"&" : @"") stringByAppendingString: [[NSString alloc] initWithFormat:self -> paramaterFormat , key , [self -> paramaters objectForKey:key]] ] ];
            i++;
        }
    }
    NSData *requestData = [paramatersString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request addValue:[[NSString alloc] initWithFormat:@"%d",requestData.length ] forHTTPHeaderField:@"Content-Length"];
    request.HTTPMethod = self -> httpMethod;
    request.HTTPBody = requestData;
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self -> httpResponseDelegate httpRequestFaild:[[NSString alloc] initWithFormat:@"error : 无法连接服务器 %@" , error.localizedDescription]];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if (httpResponse.statusCode != 200) {
        [self -> httpResponseDelegate httpRequestFaild:[[NSString alloc] initWithFormat:@"error : 无法连接服务器 %d" , httpResponse.statusCode]];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *responseResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (responseResult.length == 0) {
        [self -> httpResponseDelegate httpRequestFaild:@"wrong : 服务器返回结果解析错误"];
    }
    else {
        [self -> httpResponseDelegate httpRequestSuccess:responseResult];
    }
}

@end
