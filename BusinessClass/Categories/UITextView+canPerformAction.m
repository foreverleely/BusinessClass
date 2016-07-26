//
//  UITextView+canPerformAction.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UITextView+canPerformAction.h"

@implementation UITextView (canPerformAction)

//禁用所有输入框功能按钮
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
