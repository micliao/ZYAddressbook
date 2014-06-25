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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSignin_TouchDown:(UIButton *)sender {
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationWillStartSelector:@selector(beginShowAnimations)];
    [UIView setAnimationDidStopSelector:@selector(afterShowAnimations)];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [self.imgAvatar setBounds:CGRectMake(20, 20, 20, 20)];
    [UIView commitAnimations];
}

-(void)afterShowAnimations {
    ZYUserService* userService = [[ZYUserService alloc] init];
    [userService verifyUserBy:self.txtAccount.text password:self.txtPassword.text httpResponseDelagete:self];
}

/*!
 @method httpRequestSuccess http调用成功后执行方法
 @param responseData http访问返回结果
 */
- (void)httpRequestSuccess:(NSString *)responseData {
    NSLog(@"success %@" , responseData);
}

/*!
 @method httpRequestSuccess http调用成功后执行方法
 @param errorMsg http访问错误信息
 */
-(void)httpRequestFaild:(NSString *)errorMsg {
    NSLog(@"error %@",errorMsg);
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
