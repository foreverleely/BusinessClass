//
//  UserDataModel.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel

+ (void)saveUserData:(UserDataModel *)model{
    
    NSUserDefaults *MyUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [MyUserDefaults setObject:model.GestureLock forKey:@"GestureLock"];
    
    /*
    if (![GoodsCompareUserDefaults objectForKey:@"LoginNameArr"]) {
        NSMutableArray *LoginNameArr = [NSMutableArray new];
        [GoodsCompareUserDefaults setObject:LoginNameArr forKey:@"LoginNameArr"];
    }
    NSMutableArray *LoginNameArr = [GoodsCompareUserDefaults objectForKey:@"LoginNameArr"];
    NSMutableArray *LoginNameArr_1 = [[NSMutableArray alloc] initWithArray:LoginNameArr];
    
    BOOL HasLoginName = NO;
    if (LoginNameArr_1.count<=0) {
        [LoginNameArr_1 addObject:model.LoginName];
        
    }else{
        
        for (int i=0; i<LoginNameArr_1.count; i++) {
            if ([model.LoginName isEqualToString:LoginNameArr_1[i]]) {
                
                HasLoginName = YES;
            }
        }
        if (!HasLoginName) {
            [LoginNameArr_1 addObject:model.LoginName];
        }
    }
    [MyUserDefaults setObject:LoginNameArr_1 forKey:@"LoginNameArr"];
    */
    
    //3.强制让数据立刻保存
    [MyUserDefaults synchronize];
    
}

+ (UserDataModel *)getUserData{
    
    UserDataModel *model = [UserDataModel new];
    
    NSUserDefaults *MyUserDefaults = [NSUserDefaults standardUserDefaults];
    
    model.GestureLock = [[MyUserDefaults objectForKey:@"GestureLock"] description];

    return model;
}

+ (void)deleteUserData{
    
    NSUserDefaults *MyUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [MyUserDefaults setObject:nil forKey:@"GestureLock"];
    
    //3.强制让数据立刻保存
    [MyUserDefaults synchronize];
}

@end
