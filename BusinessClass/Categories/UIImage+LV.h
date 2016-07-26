//
//  UIImage+LV.h
//  LoanService
//
//  Created by very good on 15/1/22.
//  Copyright (c) 2015年 zonxt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LV)

+(UIImage*) imageWithColor:(UIColor*)color;

//调整图片大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
-(UIImage *)scaleToSize:(CGSize)size;
@end
