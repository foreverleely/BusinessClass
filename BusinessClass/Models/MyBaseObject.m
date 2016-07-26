//
//  MyBaseObject.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MyBaseObject.h"

@implementation MyBaseObject

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@",self.YYJSONDictionary];
}

@end
