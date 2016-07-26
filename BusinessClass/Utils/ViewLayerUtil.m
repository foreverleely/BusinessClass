//
//  ViewLayerUtil.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "ViewLayerUtil.h"

@implementation ViewLayerUtil

+ (MBProgressHUD *)createHUD:(UIView *)currentView
{
    //    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:currentView];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:12];
    [currentView addSubview:HUD];
    [HUD show:YES];
    return HUD;
}

+ (void)navgationBackitem:(UIViewController *)controller {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    controller.navigationItem.backBarButtonItem = backItem;
    //禁用 iOS7 返回手势
    if ([controller.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        controller.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

@end
