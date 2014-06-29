//
//  ZYLoadingViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYLoadingViewController.h"

@interface ZYLoadingViewController ()
{
    UIView *parentView;
    UIView *maskView;
    BOOL isInsert;
}

@end

@implementation ZYLoadingViewController

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
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8.0;
    self.view.center = self->parentView.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @method initWithParentView:
 @abstract 使用父级view初始化
 @param view 父级view初始化
 @result 已实例化的 ZYLoadingViewController
 */
-(id)initWithParentView:(UIView*)view {
    self = [super initWithNibName:@"ZYLoadingView" bundle:nil];
    if (self) {
        self->parentView = view;
        self->maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
        self->maskView.backgroundColor = [UIColor blackColor];
        self->maskView.alpha = 0.2;
        self->maskView.hidden = YES;
        
        self->isInsert = NO;
    }
    return self;
}

/*!
 @method show:
 @abstract 显示加载提示
 */
-(void)show {
    if (!self->isInsert) {
        [self->parentView addSubview:self->maskView];
        [self->parentView addSubview:self.view];
        self.view.center = self->parentView.center;
        self->isInsert = YES;
    }
    self->maskView.hidden = NO;
    self.view.hidden = NO;
    [self.indicatorView startAnimating];
}

/*!
 @method hide:
 @abstract 隐藏加载提示
 */
-(void)hide {
    self->maskView.hidden = YES;
    self.view.hidden = YES;
    [self.indicatorView stopAnimating];
}
@end
