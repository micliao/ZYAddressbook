//
//  ZYSignInViewController.h
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYHttpResponseDelegate.h"
#import "ZYUserService.h"

@interface ZYSignInViewController : UIViewController <ZYHttpResponseDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnSignin_TouchDown:(UIButton *)sender;

@end
