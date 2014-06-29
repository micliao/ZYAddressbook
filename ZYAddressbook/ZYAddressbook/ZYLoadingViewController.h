//
//  ZYLoadingViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @interface ZYLoadingViewController
 @abstract 自定义加载提示
 */
@interface ZYLoadingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

-(id)initWithParentView:(UIView*)view;
-(void)show;
-(void)hide;

@end
