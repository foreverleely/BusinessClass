//
//  FMDBUtil.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "FMDBUtil.h"


static NSString *dbVersion = @"2.0.0";

static NSString *dbName = @"";

static NSString *dbType = @"";

@implementation FMDBUtil

+ (FMDatabase *)inititalizeDB {
    //获取数据库文件路径
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbfullname = [NSString stringWithFormat:@"%@.%@",dbName ,dbType];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:dbfullname];
    //根据路径获取数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    //设置数据库线程安全
    [FMDatabase isSQLiteThreadSafe];
    if (![db open]) {
        NSLog(@"counld't open the db");
    }
    return db;
    
}

+ (BOOL)copyDBtoDocument {
    //获取本地数据库版本
    NSString *versionKey = @"versionKey";
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *version = [userdefaults stringForKey:versionKey];
    
    BOOL filepresent = NO;
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:dbName ofType:dbType];
    //数据库文件存放路径
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //数据库文件操作
    if (!version) {
        filepresent = [self copyMissingFile:dbPath toPath:docsPath];
    } else if (![dbVersion isEqualToString:version]) {
        [self updateDBFile:dbPath toPath:docsPath];
    }
    
    [userdefaults setObject:dbVersion forKey:versionKey];
    [userdefaults synchronize];
    
    return filepresent;
    
}

+ (void)updateDBFile:(NSString *)sourcePath toPath:(NSString *)toPath {
    //查看sourcePath路径下是否有我们的数据库文件
    NSString *filePath = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    NSError *error = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            NSLog(@"移除文件失败，错误信息:%@",error);
        } else {
            NSLog(@"成功移除文件");
        }
    } else {
        NSLog(@"文件不存在");
    }
    
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:toPath error:NULL];
    
}

+ (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath {
    
    BOOL copyfile = YES;
    NSString *filePath = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        copyfile = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:toPath error:NULL];
    }
    
    return copyfile;
    
}

@end
