//
//  ZYSignInViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-25.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYSignInViewController.h"

@implementation ZYSignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self -> loadingViewController = [[ZYLoadingViewController alloc] initWithParentView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignin_TouchDown:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.imgAvatar.frame.size.width == 30) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.imgAvatar setFrame:CGRectMake(100, 100, 120, 120)];
            [self.btnRegist setFrame:CGRectMake(self.btnRegist.frame.origin.x, self.btnRegist.frame.origin.y + 105, self.btnRegist.frame.size.width, self.btnRegist.frame.size.height)];
            [self.btnSignIn setFrame:CGRectMake(self.btnSignIn.frame.origin.x, self.btnSignIn.frame.origin.y + 105, self.btnSignIn.frame.size.width, self.btnSignIn.frame.size.height)];
            [self.txtAccount setFrame:CGRectMake(self.txtAccount.frame.origin.x, self.txtAccount.frame.origin.y + 105, self.txtAccount.frame.size.width, self.txtAccount.frame.size.height)];
            [self.txtPassword setFrame:CGRectMake(self.txtPassword.frame.origin.x, self.txtPassword.frame.origin.y + 105, self.txtPassword.frame.size.width, self.txtPassword.frame.size.height)];
        } completion:^(BOOL finished) {
            [self signIn];
        }];
    }
    else {
        [self signIn];
    }
}

-(void)signIn {
    ZYContactsTableViewController *contactsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
    [self presentViewController:contactsViewController animated:YES completion:nil];
//    [self -> loadingViewController show];
//
//    ZYUserService* userService = [[ZYUserService alloc] init];
//    [userService verifyUserBy:self.txtAccount.text password:self.txtPassword.text httpResponseDelagete:self];
}

/*!
 @method httpRequestSuccess http调用成功后执行方法
 @param responseData http访问返回结果
 */
- (void)httpRequestSuccess:(NSString *)responseData {
    [self -> loadingViewController hide];
    NSLog(@"success %@" , responseData);
}

/*!
 @method httpRequestSuccess http调用成功后执行方法
 @param errorMsg http访问错误信息
 */
-(void)httpRequestFaild:(NSString *)errorMsg {
    [self -> loadingViewController hide];
    [ZYNoticeViewController showNotice:self.view showTime:3 showBottomOffset:0 noticeText:errorMsg];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.imgAvatar.frame.size.width == 30) {
        return YES;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.imgAvatar setFrame:CGRectMake(145, 85, 30, 30)];
        [self.btnRegist setFrame:CGRectMake(self.btnRegist.frame.origin.x, self.btnRegist.frame.origin.y - 105, self.btnRegist.frame.size.width, self.btnRegist.frame.size.height)];
        [self.btnSignIn setFrame:CGRectMake(self.btnSignIn.frame.origin.x, self.btnSignIn.frame.origin.y - 105, self.btnSignIn.frame.size.width, self.btnSignIn.frame.size.height)];
        [self.txtAccount setFrame:CGRectMake(self.txtAccount.frame.origin.x, self.txtAccount.frame.origin.y - 105, self.txtAccount.frame.size.width, self.txtAccount.frame.size.height)];
        [self.txtPassword setFrame:CGRectMake(self.txtPassword.frame.origin.x, self.txtPassword.frame.origin.y - 105, self.txtPassword.frame.size.width, self.txtPassword.frame.size.height)];
    }];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
