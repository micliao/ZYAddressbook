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
    NSString *noticeText;
    CGRect noticeSize;
    NSTimer *closeTimer;
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
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 8.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithParentView:(UIView*)view {
    self = [super initWithNibName:@"ZYNoticeView" bundle:nil];
    if (self) {
        self->parentView = view;
        [self->parentView addSubview:self.view];
        self->noticeSize = CGRectMake(0, 0, 0, 0);
    }
    return self;
}

-(void)show:(NSString*)text {
    [self show:text showTime:3];
}

-(void)show:(NSString*)text showTime:(int)showTime {
    if (self->closeTimer != nil) {
        [self->closeTimer invalidate];
        self->closeTimer = nil;
    }
    self->noticeText = text;
    [self beforeShow];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.view setHidden:NO];
        [self.view setFrame:self->noticeSize];
        [self->lbNoticeText setHidden:NO];
    } completion:^(BOOL finished) {
        self->closeTimer = [NSTimer scheduledTimerWithTimeInterval:showTime target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }];
}

-(void)beforeShow {
    if (self->lbNoticeText == nil) {
        self->lbNoticeText = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 215, 40)];
        [self->lbNoticeText setFont:[UIFont fontWithName:@"Helvetica Bold" size:16.0]];
        [self->lbNoticeText setBackgroundColor:[UIColor clearColor]];
        [self->lbNoticeText setTextColor:[UIColor whiteColor]];
        [self->lbNoticeText setNumberOfLines:0];
        [self.view addSubview:self->lbNoticeText];
    }
    
    if (![self->lbNoticeText.text isEqualToString:self->noticeText]) {
        [self->lbNoticeText setHidden:YES];
        [self->lbNoticeText setText:self->noticeText];
        NSMutableDictionary *attr = [[NSMutableDictionary alloc] init];
        [attr setValue:self->lbNoticeText.font forKey:NSFontAttributeName];
        CGSize size = [self->noticeText boundingRectWithSize:CGSizeMake(215, 500) options: NSStringDrawingUsesLineFragmentOrigin attributes: attr context: nil].size;
        CGFloat width = size.width + 20;
        CGFloat height = size.height + 20 > 40 ? size.height + 20 : 40;
        CGFloat x = self->parentView.center.x - width/2;
        CGFloat y = [UIScreen mainScreen].applicationFrame.size.height - 20 - height;
        self.view.frame = CGRectMake(x + width/2 , y +height/2 , 1 , 1);
        self->noticeSize = CGRectMake(x,y,width, height);
        [self->lbNoticeText setFrame:CGRectMake(5, 5, size.width, size.height)];
        self->lbNoticeText.center = CGPointMake(width/2, height/2);
    }
}

-(void)hide {
    self->closeTimer = nil;
    [self->lbNoticeText setHidden:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.cornerRadius = 4;
        [self.view setFrame:CGRectMake(self->noticeSize.origin.x + self->noticeSize.size.width/2 , self->noticeSize.origin.y +self->noticeSize.size.height/2 , 0.1 , 0.1)];
    } completion:^(BOOL finished) {
        [self.view setHidden:YES];
    }];
}

-(void)hideNow {
    self->closeTimer = nil;
    [self->lbNoticeText setHidden:YES];
    [self.view setHidden:YES];
}

@end
