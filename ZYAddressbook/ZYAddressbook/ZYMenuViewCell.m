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
        //self.layer.cornerRadius = 100;
        //self.layer.borderWidth = 100;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 100;
    self.layer.borderWidth = 100;
}


@end
