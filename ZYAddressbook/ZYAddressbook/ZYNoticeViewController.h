//
//  ZYNoticeViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNoticeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbNotice;
-(id)initWithParentView:(UIView*)view;
-(void)show:(NSString*)text;
-(void)hide;

@end
