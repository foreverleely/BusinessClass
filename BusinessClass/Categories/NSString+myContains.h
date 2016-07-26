//
//  NSString+myContains.h
//  TongQuanDai
//
//  Created by 向海涛 on 15/10/13.
//  Copyright © 2015年 xianghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (myContains)
- (BOOL)myContainsString:(NSString*)other;
//获取字符串字符数组
- (NSArray *)words;
@end
