//
//  NSObject+HttpRequestExtension.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYHttpRequest.h"

@implementation ZYHttpRequest

/*!
 @method initWithRequestUrl:method:respenseDelegate:
 @abstract 使用一个 url 连接初始化一个 httprequest 对象
 @param requestUrl 请求的url地址
 @param method 请求的 http 方法 POST 或 GET
 @param respenseDelegate 回调执行的委托，类型为 ZYHttpResponseDelegate
 @result 已实例化的 ZYHttpRequest
 */
-(ZYHttpRequest*)initWithRequestUrl:(NSString*)requestUrl method:(NSString*)method respenseDelegate:(id<ZYHttpResponseDelegate>)delegate
{
    self -> httpRequestUrl = requestUrl;
    self -> httpMethod = method;
    self -> httpResponseDelegate = delegate;
    self -> paramaterFormat = @"%@=%@";
    self -> paramaters = [[NSMutableDictionary alloc] init];
    self -> isRequestSuccess = YES;
    return self;
}

/*!
 @method addParamaterFor:byValue:
 @abstract 为请求添加参数
 @param paramaterName 参数的名称
 @param addParamaterValue 参数的值
 */
-(void)addParamaterFor:(NSString*)paramaterName byValue:(NSString*)paramaterValue
{
    [self -> paramaters setObject:paramaterValue forKey:paramaterName];
}

/*!
 @method setParamaterFor:byValue:
 @abstract 设置请求的参数的值
 @param paramaterName 参数的名称
 @param addParamaterValue 参数的值
 */
-(void)setParamaterFor:(NSString*)paramaterName byValue:(NSString*)paramaterValue
{
    [self -> paramaters setObject:paramaterValue forKey:paramaterName];
}

/*!
 @method removeParamaterBy:
 @abstract 根据名称移除请求的参数
 @param paramaterName 参数的名称
 */
-(void)removeParamaterBy:(NSString*)paramaterName
{
    [self -> paramaters removeObjectForKey:paramaterName];
}

/*!
 @method doHttpRequest
 @abstract 开始请求
 */
-(void)doHttpRequest
{
    NSString *paramatersString = @"";
    if (self -> paramaters.count > 0) {
        int i = 0;
        for (id key in  self -> paramaters) {
            paramatersString = [paramatersString stringByAppendingString: [(i > 0 ? @"&" : @"") stringByAppendingString: [[NSString alloc] initWithFormat:self -> paramaterFormat , key , [self -> paramaters objectForKey:key]] ] ];
            i++;
        }
    }
    if ([self -> httpMethod isEqual:@"GET"]) {
        self -> httpRequestUrl = [[self -> httpRequestUrl stringByAppendingString:@"?"] stringByAppendingString:paramatersString];
    }
    NSURL *url = [[NSURL alloc] initWithString:(self -> httpRequestUrl)];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: url];
    if ([self -> httpMethod isEqual:@"POST"]) {
        NSData *requestData = [paramatersString dataUsingEncoding:NSUTF8StringEncoding];
        [request addValue:[[NSString alloc] initWithFormat:@"%d",requestData.length ] forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = requestData;
    }
    request.HTTPMethod = self -> httpMethod;
    [NSURLConnection connectionWithRequest:request delegate:self];
}

/*!
 @method connection:didFailWithError:
 @abstract 请求执行发生错误
 @param connection 请求的连接
 @param didFailWithError 错误信息
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([self -> httpResponseDelegate respondsToSelector:@selector(httpRequestFaild:)]) {
        [self -> httpResponseDelegate httpRequestFaild:[[NSString alloc] initWithFormat:@"error : 无法连接服务器 %@" , error.localizedDescription]];
    }
    self -> isRequestSuccess = NO;
}

/*!
 @method connection:didReceiveResponse:
 @abstract 请求收到回复信息
 @param connection 请求的连接
 @param didReceiveResponse 回复信息
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if (httpResponse.statusCode != 200 && [self -> httpResponseDelegate respondsToSelector:@selector(httpRequestFaild:)]) {
        [self -> httpResponseDelegate httpRequestFaild:[[NSString alloc] initWithFormat:@"error : 无法连接服务器 %d" , httpResponse.statusCode]];
    }
    self -> isRequestSuccess = httpResponse.statusCode == 200;
}

/*!
 @method connection:didReceiveData:
 @abstract 请求收到回复数据
 @param connection 请求的连接
 @param didReceiveData 回复数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self -> isRequestSuccess) {
        NSString *responseResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (responseResult.length == 0 && [self -> httpResponseDelegate respondsToSelector:@selector(httpRequestFaild:)]) {
            [self -> httpResponseDelegate httpRequestFaild:@"wrong : 服务器返回结果解析错误"];
        }
        else if ([self -> httpResponseDelegate respondsToSelector:@selector(httpRequestSuccess:)]){
            [self -> httpResponseDelegate httpRequestSuccess:responseResult];
        }
    }
}

@end
