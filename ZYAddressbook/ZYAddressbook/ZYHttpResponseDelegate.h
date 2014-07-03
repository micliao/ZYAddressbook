//
//  ZYHttpResponseDelegate.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYHttpResponseDelegate <NSObject>

@optional
/*!
 @method httpRequestSuccess:responseData:
 @abstract 调用成功后执行方法
 @param responseData http访问返回结果
 @param userData 用户数据
 */
- (void)httpRequestSuccess:(id)delegate responseData:(NSData *)responseData;

/*!
 @method httpRequestFaild:err:
 @abstract 调用失败后执行方法
 @param err http访问错误信息
 @param userData 用户数据
 */
-(void)httpRequestFaild:(id)delegate err:(NSString *)errorMsg;

@end
