//
//  DashedTableViewCell.h
//  TongQuanDai
//
//  Created by very good on 15/8/13.
//  Copyright (c) 2015年 xianghaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashedTableViewCell : UITableViewCell

@property(assign,nonatomic) BOOL isDrawLine;//是否划线

@property(assign,nonatomic) BOOL isDash;//是否虚线，否则为实线。默认为虚线

@end
