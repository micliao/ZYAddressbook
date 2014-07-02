//
//  ZYMenuViewCell.m
//  ZYAddressbook
//
//  Created by elemeNT on 14-6-26.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import "ZYMenuViewCell.h"

@implementation ZYMenuViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
   self.layer.cornerRadius = self.frame.size.width/2;
   self.layer.borderWidth = 10;//设置边框的宽度，当然可以不要
   self.layer.borderColor = [[UIColor grayColor] CGColor];//设置边框的颜色
}


@end
