//
//  VersionUtil.h
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionUtil : NSObject

+ (void)findVersionwithurl:(NSString *)url success:(void (^)(NSDictionary *dict))success;

@end
