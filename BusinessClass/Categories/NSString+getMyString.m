//
//  NSString+getMyString.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/27.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "NSString+getMyString.h"

@implementation NSString (getMyString)

- (NSString *)getNilStringwithString:(NSString *)string {
    NSString *MyString = string?[NSString stringWithFormat:@"%@",string]:@"";
    return MyString;
}

- (NSString *)getNilStringwithDictionary:(NSDictionary *)dict andPath:(NSString *)path {
    
    NSString *MyString = [dict valueForKeyPath:path]?[NSString stringWithFormat:@"%@",[dict valueForKeyPath:path]]:@"";
    return MyString;
}

- (NSString *)getNilStringwithDictionary:(NSDictionary *)dict Path:(NSString *)path andDecorateStr:(NSString *)Decorate {
    
    NSString *MyString = [dict valueForKeyPath:path]?[NSString stringWithFormat:@"%@%@",[dict valueForKeyPath:path],Decorate]:@"";
    return MyString;
}

- (NSString *)getForwardSlashStringwithString:(NSString *)string andSlashLocationType:(NSString *)type {
    
    NSString *MyString = @"";// = string?[NSString stringWithFormat:@"%@",string]:@"";
    if (string.length > 0) {
        MyString = [NSString stringWithFormat:type,string];
    }
    return MyString;
}

@end
