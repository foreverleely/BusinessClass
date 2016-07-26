//
//  MySearchBar.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtnMaskLayer.h"

@interface MySearchBar : UISearchBar<UISearchBarDelegate>

@property (nonatomic, strong) BtnMaskLayer *btnmasklayer;

@property (nonatomic, copy) void (^selectData)(NSString *);

@end
