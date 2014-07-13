//
//  ZYContactTableViewCell.h
//  ZYAddressbook
//
//  Created by micliao on 14-7-13.
//  Copyright (c) 2014年 zy. All rights reserved.
//

#import <UIKit/UIKit.h>
/*!
 *@interface ZYContactTableViewCell
 *通讯录表格单元格
 */
@interface ZYContactTableViewCell : UITableViewCell
/*!
 *头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
/*!
 *名称
 */
@property (weak, nonatomic) IBOutlet UILabel *lbName;
/*!
 *心情
 */
@property (weak, nonatomic) IBOutlet UILabel *lbDes;

@end
