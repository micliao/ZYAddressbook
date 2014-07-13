//
//  ZYNoticeViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @interface ZYNoticeViewController
 @abstract 自定义提示文本定义
 */
@interface ZYNoticeViewController : UIViewController

-(id)initWithParentView:(UIView*)view;
-(void)show:(NSString*)text;
-(void)show:(NSString*)text showTime:(int)showTime showBottomOffset:(double)offset showAni:(BOOL)showAni;
-(void)hideNow;
+(void)showNotice:(UIView*)view showTime:(int)showTime showBottomOffset:(double)offset noticeText:(NSString*)text;
+(void)showNotice:(UIView*)view noticeText:(NSString*)text;
@end
