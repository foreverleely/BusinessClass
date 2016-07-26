//
//  NSString+getMyString.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/27.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (getMyString)

- (NSString *)getNilStringwithString:(NSString *)string;

- (NSString *)getNilStringwithDictionary:(NSDictionary *)dict andPath:(NSString *)path;

- (NSString *)getNilStringwithDictionary:(NSDictionary *)dict Path:(NSString *)path andDecorateStr:(NSString *)Decorate;

- (NSString *)getForwardSlashStringwithString:(NSString *)string andSlashLocationType:(NSString *)type;

@end
