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
            for (UIView* v in self.view.subviews) {
                if ([v isMemberOfClass:[UITextField class]] || [v isMemberOfClass:[UIButton class]] ) {
                    [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y + 105, v.frame.size.width, v.frame.size.height)];
                }
            }
        } completion:^(BOOL finished) {
            [self signIn];
        }];
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
    for (UIView* v in self.view.subviews) {
            UIResponder *nextResponder = [v nextResponder];
            if ([nextResponder isMemberOfClass:[ZYNoticeViewController class]]) {
                [((ZYNoticeViewController *)nextResponder) hideNow];
            }
    }
    ZYNoticeViewController *noticeController = [[ZYNoticeViewController alloc]initWithParentView:self.view];
    [noticeController show: [[NSString alloc]initWithFormat:@"error %@ %@",errorMsg,[NSDate date]]];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.imgAvatar.frame.size.width == 30) {
        return YES;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.imgAvatar setFrame:CGRectMake(145, 85, 30, 30)];
        for (UIView* v in self.view.subviews) {
            if ([v isMemberOfClass:[UITextField class]] || [v isMemberOfClass:[UIButton class]] ) {
                [v setFrame:CGRectMake(v.frame.origin.x, v.frame.origin.y - 105, v.frame.size.width, v.frame.size.height)];
            }
        }
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
