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
 @method httpRequestSuccess: 调用成功后执行方法
 @param responseData http访问返回结果
 */
- (void)httpRequestSuccess:(NSString *)responseData;

/*!
 @method httpRequestSuccess: 调用成功后执行方法
 @param errorMsg http访问错误信息
 */
-(void)httpRequestFaild:(NSString *)errorMsg;

@end
