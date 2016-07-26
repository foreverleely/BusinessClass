//
//  UIColor+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 14-10-18.
//  Copyright (c) 2014年 oschina. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

#pragma mark - Hex

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}


#pragma mark - theme colors

+ (UIColor *)backGroundColor
{
    return [UIColor colorWithHex:0xEFEFEF];
}
+ (UIColor *)textFirstColor{
    return [UIColor colorWithHex:0x333333];
}
+ (UIColor *)textSecondColor{
    return [UIColor colorWithHex:0x666666];
}
+ (UIColor *)texThirdColor{
    return [UIColor colorWithHex:0x999999];
}
+ (UIColor *)BtnColor{
    return [UIColor colorWithHex:0x00A0EA];
}
+ (UIColor *)UnEditColor{
    return  [UIColor lightGrayColor];
}

+ (BOOL)isColorClear:(UIColor *)color
{
    if (color == [UIColor clearColor]) {
        return YES;
    }
    
    NSUInteger totalComponents = CGColorGetNumberOfComponents(color.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    CGFloat *components = (CGFloat *)CGColorGetComponents(color.CGColor);
    if (!components) {
        return YES;
    }
    
    if(isGreyscale) {
        if (components[1] <= 0) {
            return YES;
        }
    }
    else {
        if (components[3] <= 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
