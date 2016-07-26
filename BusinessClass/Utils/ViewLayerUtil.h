//
//  ViewLayerUtil.h
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ViewLayerUtil : NSObject

+ (MBProgressHUD *)createHUD:(UIView *)currentView;

+ (void)navgationBackitem:(UIViewController *)controller;

@end
