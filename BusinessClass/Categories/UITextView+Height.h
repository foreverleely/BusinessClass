//
//  UITextView+Height.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Height)

- (float)heightforString:(NSString *)string
      orAttributedString:(NSAttributedString *)attributedstring
            withFontSize:(float)fontsize
                andWidth:(float)width;

@end
