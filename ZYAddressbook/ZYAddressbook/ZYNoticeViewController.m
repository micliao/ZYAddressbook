//
//  ZYNoticeViewController.m
//  ZYAddressbook
//
//  Created by micliao on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYNoticeViewController.h"

@interface ZYNoticeViewController ()
{
    UIView *parentView;
    UILabel *lbNoticeText;
    CGRect noticeSize;
    NSTimer *closeTimer;
    double bottomOffset;
    BOOL isNeedShowAnimation;
}
@end

@implementation ZYNoticeViewController

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
 @result 已实例化的 ZYNoticeViewController
 */
-(id)initWithParentView:(UIView*)view {
    self = [super initWithNibName:@"ZYNoticeView" bundle:nil];
    if (self) {
        self->parentView = view;
        [self->parentView addSubview:self.view];
        self->noticeSize = CGRectMake(0, 0, 0, 0);
    }
    return self;
}

/*!
 @method show:
 @abstract 显示提示，在3s后消失
 @param text 提示文本
 */
-(void)show:(NSString*)text {
    [self show:text showTime:3 showBottomOffset:0 showAni:YES];
}

/*!
 @method show:showTime:showBottomOffset:
 @abstract 在指定Y坐标偏移量显示提示，在特定时间后消失
 @param text 提示文本
 @param showTime 显示时间
 @param showBottomOffset y坐标偏移量
 @param showAni 是否显示“显示动画”
 */
-(void)show:(NSString*)text showTime:(int)showTime showBottomOffset:(double)offset showAni:(BOOL)showAni{
    if (self->closeTimer != nil) {
        [self->closeTimer invalidate];
        self->closeTimer = nil;
    }
    self->bottomOffset = offset;
    [self beforeShow:text];
    if (showAni) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.view.alpha = 1;
            [self.view setFrame:self->noticeSize];
        } completion:^(BOOL finished) {
            self->closeTimer = [NSTimer scheduledTimerWithTimeInterval:showTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
        }];
    }
    else {
        self.view.alpha = 1;
        [self.view setFrame:self->noticeSize];
        self->closeTimer = [NSTimer scheduledTimerWithTimeInterval:showTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }
}

-(void)beforeShow:(NSString*)text {
    self->lbNoticeText = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 215, 40)];
    [self->lbNoticeText setFont:[UIFont fontWithName:@"Helvetica Bold" size:16.0]];
    [self->lbNoticeText setBackgroundColor:[UIColor clearColor]];
    [self->lbNoticeText setTextColor:[UIColor whiteColor]];
    [self->lbNoticeText setNumberOfLines:0];
    [self.view addSubview:self->lbNoticeText];
    [self->lbNoticeText setText:text];
    
    NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
    [attr setValue:self->lbNoticeText.font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(215, 500) options: NSStringDrawingUsesLineFragmentOrigin attributes: attr context: nil].size;
    CGFloat width = size.width + 10;
    CGFloat height = size.height + 10;
    CGFloat x = self->parentView.center.x - width/2;
    CGFloat y = [UIScreen mainScreen].applicationFrame.size.height - 20 - height - self->bottomOffset;
    self.view.frame = CGRectMake(x,y+height,width, height);
    self.view.alpha = 0;
    self.view.hidden = NO;
    self->noticeSize = CGRectMake(x,y,width, height);
    [self->lbNoticeText setFrame:CGRectMake(5, 5, size.width, size.height)];
    self->lbNoticeText.center = CGPointMake(width/2, height/2);
}

-(void)hide {
    if (self->closeTimer != nil) {
        [self->closeTimer invalidate];
        self->closeTimer = nil;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0;
        [self.view setFrame:CGRectMake(self->noticeSize.origin.x  , self->noticeSize.origin.y -self->noticeSize.size.height,  self->noticeSize.size.width ,  self->noticeSize.size.height)];
    } completion:^(BOOL finished) {
        [self.view setHidden:YES];
        [self.view removeFromSuperview];
    }];
}

/*!
 @method hideNow:
 @abstract 立即隐藏提示框
 */
-(void)hideNow {
    if (self->closeTimer != nil) {
        [self->closeTimer invalidate];
        self->closeTimer = nil;
    }
    [self.view setHidden:YES];
    [self.view removeFromSuperview];
}

/*!
 *@method showNotice:showTime:showBottomOffset:
 *显示提示信息
 *@param view 需要显示提示信息的view
 *@param showTime 显示时间
 *@param showBottomOffset 显示距离底部Y坐标偏移量
 *@param noticeText 显示的提示文本
 */
+(void)showNotice:(UIView*)view showTime:(int)showTime showBottomOffset:(double)offset noticeText:(NSString*)text{
    BOOL showAni = YES;
    for (UIView* v in view.subviews) {
        UIResponder *nextResponder = [v nextResponder];
        if ([nextResponder isMemberOfClass:[ZYNoticeViewController class]]) {
            [((ZYNoticeViewController *)nextResponder) hideNow];
            nextResponder = nil;
            showAni = NO;
        }
    }
    ZYNoticeViewController *noticeController = [[ZYNoticeViewController alloc]initWithParentView:view];
    [noticeController show:text showTime:showTime showBottomOffset:offset showAni:showAni];
}

+(void)showNotice:(UIView*)view noticeText:(NSString*)text {
    [ZYNoticeViewController showNotice:view showTime:3 showBottomOffset:0 noticeText:text];
}

@end
