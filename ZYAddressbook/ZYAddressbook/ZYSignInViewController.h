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
#import "ZYLoadingViewController.h"
#import "ZYNoticeViewController.h"
#import "ZYContactsViewController.h"

@interface ZYSignInViewController : UIViewController <ZYHttpResponseDelegate , UITextFieldDelegate>
{
    ZYLoadingViewController *loadingViewController;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
- (IBAction)btnSignin_TouchDown:(UIButton *)sender;

@end
