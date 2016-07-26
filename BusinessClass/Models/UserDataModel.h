//
//  UserDataModel.h
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

//这里可以将用户的数据model化，然后处理一些弱业务逻辑，切记不要随便往这里塞数据
#import "MyBaseObject.h"

@interface UserDataModel : MyBaseObject

@property (nonatomic, strong) NSString *GestureLock;


+ (void)saveUserData:(UserDataModel *)model;

+ (UserDataModel *)getUserData;

+ (void)deleteUserData;

@end
