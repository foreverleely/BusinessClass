//
//  UITextView+canPerformAction.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (canPerformAction)

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender;

@end
