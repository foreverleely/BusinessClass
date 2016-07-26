//
//  GestureUtil.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "GestureUtil.h"
#import "CLLockVC.h"
#import "UserDataModel.h"

static NSString *GestureHasLock = @"Lock";

@implementation GestureUtil

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    
    return result;
}

+ (void)AlertGesture{
    
    UIViewController *CurrentVc = [self getCurrentVC];
    
    [CLLockVC showVerifyLockVCInVC:CurrentVc forgetPwdBlock:^{
        NSLog(@"忘记密码");
    } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
        NSLog(@"密码正确");
        
        [lockVC dismiss:1.0f];
        
    }];
}

+ (void)gesture:(UIViewController *)CurrentVc :(UIViewController *)PushVc{
    BOOL hasPwd = NO;
    if(hasPwd){
        
    }else{
        [CLLockVC showSettingLockVCInVC:CurrentVc successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            //这里可以给当前用户添加一个是否设置了手势锁的状态
            UserDataModel *model = [UserDataModel getUserData];
            model.GestureLock = GestureHasLock;
            [UserDataModel saveUserData:model];
            
            [lockVC.navigationController dismissViewControllerAnimated:NO completion:nil];
            [CurrentVc.navigationController pushViewController:PushVc animated:NO];
        }];
    }
}

+ (void)changeGestureLock:(UIViewController *)vc{
    UserDataModel *model = [UserDataModel getUserData];
    if(![model.GestureLock isEqualToString:GestureHasLock]){//如果没有设置手势密码，则设置手势密码
        
        [CLLockVC showSettingLockVCInVC:vc successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            model.GestureLock = GestureHasLock;
            
            [UserDataModel saveUserData:model];
            
            [lockVC dismiss:1.0f];
        }];
        
    }else {//如果已经设置了手势密码，则进行手势密码验证
        
        [CLLockVC showModifyLockVCInVC:vc successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:1.0f];
        }];
    }
}

@end
