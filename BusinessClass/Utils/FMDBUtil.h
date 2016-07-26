//
//  FMDBUtil.h
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FMDBUtil : NSObject

//初始化数据库
+ (FMDatabase *)inititalizeDB;

//一般启动应用时都需要检查本地数据库是否存在或者是否最新
+ (BOOL)copyDBtoDocument;

@end
