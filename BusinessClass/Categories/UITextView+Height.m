//
//  UITextView+Height.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UITextView+Height.h"

@implementation UITextView (Height)

- (float)heightforString:(NSString *)string
      orAttributedString:(NSAttributedString *)attributedstring
            withFontSize:(float)fontsize
                andWidth:(float)width {
    
    UITextView *textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    textview.font = [UIFont systemFontOfSize:fontsize];
    if (string) {
        textview.text = string;
    }else {
        textview.attributedText = attributedstring;
    }
    CGSize textViewSize = [textview sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    return textViewSize.height;
    
}

@end
