//
//  NSString+Height.m
//  ShenZhenHaiShiJu
//
//  Created by 向海涛 on 16/1/26.
//  Copyright © 2016年 mgear. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)
- (CGFloat )getLabHeight:(CGFloat )lineSpace Width:(CGFloat)width font:(UIFont *)font {
    // MAXFLOAT 为可设置的最大高度
    CGSize size = CGSizeMake(width, MAXFLOAT);
    //    设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    //获取当前那本属性
    NSDictionary *dic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    //实际尺寸
    CGSize actualSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return actualSize.height;
}
@end
