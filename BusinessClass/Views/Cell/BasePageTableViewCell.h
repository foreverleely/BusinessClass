//
//  BasePageTableViewCell.h
//  ShipReport
//
//  Created by 向海涛 on 16/2/16.
//  Copyright © 2016年 mgear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashedTableViewCell.h"
#import "MyBaseObject.h"

@interface BasePageTableViewCell : DashedTableViewCell

- (void)setDataWithModel:(MyBaseObject *)model;


@end
