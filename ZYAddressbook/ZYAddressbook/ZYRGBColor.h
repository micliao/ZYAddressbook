//
//  ZYRGBColor.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#ifndef ZYAddressbook_ZYRGBColor_h
#define ZYAddressbook_ZYRGBColor_h

/*!
    rgbValue为16进制颜色，alpha为0到1的double
 */
#define ColorWithRGB(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:alphaValue]
//! 参数格式为：222,222,222
#define ColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]

#endif
