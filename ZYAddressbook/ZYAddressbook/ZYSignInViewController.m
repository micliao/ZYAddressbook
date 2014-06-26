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
        [UIView beginAnimations:@"animation" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(signIn)];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
        [self.imgAvatar setFrame:CGRectMake(100, 100, 120, 120)];
        [self.txtAccount setFrame:CGRectMake(self.txtAccount.frame.origin.x, self.txtAccount.frame.origin.y + 105, self.txtAccount.frame.size.width, self.txtAccount.frame.size.height)];
        [self.txtPassword setFrame:CGRectMake(self.txtPassword.frame.origin.x, self.txtPassword.frame.origin.y + 105, self.txtPassword.frame.size.width, self.txtPassword.frame.size.height)];
        [self.btnSignIn setFrame:CGRectMake(self.btnSignIn.frame.origin.x, self.btnSignIn.frame.origin.y + 105, self.btnSignIn.frame.size.width, self.btnSignIn.frame.size.height)];
        [self.btnRegist setFrame:CGRectMake(self.btnRegist.frame.origin.x, self.btnRegist.frame.origin.y + 105, self.btnRegist.frame.size.width, self.btnRegist.frame.size.height)];
        [UIView commitAnimations];
    }
    else {
        [self signIn];
    }
}

-(void)signIn {
    [self -> loadingViewController show];

    ZYUserService* userService = [[ZYUserService alloc] init];
    [userService verifyUserBy:self.txtAccount.text password:self.txtPassword.text httpResponseDelagete:self];
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
    ZYNoticeViewController *notice = [[ZYNoticeViewController alloc]initWithParentView:self.view];
    [notice show:errorMsg];
    NSLog(@"error %@",errorMsg);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.imgAvatar.frame.size.width == 30) {
        return YES;
    }
    [UIView beginAnimations:@"animation" context:nil];
    //[UIView setAnimationDelegate:self];
    //[UIView setAnimationWillStartSelector:@selector(beginShowAnimations)];
    //[UIView setAnimationDidStopSelector:@selector(afterShowAnimations)];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.imgAvatar setFrame:CGRectMake(145, 85, 30, 30)];
    [self.txtAccount setFrame:CGRectMake(self.txtAccount.frame.origin.x, self.txtAccount.frame.origin.y - 105, self.txtAccount.frame.size.width, self.txtAccount.frame.size.height)];
    [self.txtPassword setFrame:CGRectMake(self.txtPassword.frame.origin.x, self.txtPassword.frame.origin.y - 105, self.txtPassword.frame.size.width, self.txtPassword.frame.size.height)];
    [self.btnSignIn setFrame:CGRectMake(self.btnSignIn.frame.origin.x, self.btnSignIn.frame.origin.y - 105, self.btnSignIn.frame.size.width, self.btnSignIn.frame.size.height)];
    [self.btnRegist setFrame:CGRectMake(self.btnRegist.frame.origin.x, self.btnRegist.frame.origin.y - 105, self.btnRegist.frame.size.width, self.btnRegist.frame.size.height)];
    [UIView commitAnimations];
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
