//
//  VersionUtil.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

//通过URL返回到的是一个文件，通过解析文档内容来获取相关数据
//注意AFHTTPRequestOperationManager在AFN2.6.3后就去掉了，所以注意AFN的版本
//建议在做企业应用时，写APP信息的文档时，注意一下对应字段和AppStore获取的信息里对应字段保持一致，例如，版本version，APP链接地址trackViewUrl，如果不嫌麻烦，文档格式最好和AppStore下载的文档格式保持一致
//AppStore对应文档内容格式 {"resultCount":1,"results": [{相关信息}]}，注意那对方括号

#import "VersionUtil.h"
#import "AFHTTPSessionManager.h"

@implementation VersionUtil

+ (void)findVersionwithurl:(NSString *)url success:(void (^)(NSDictionary *dict))success {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/javascript", @"application/json",@"text/plain",@"text/json",nil];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictResult = responseObject;
        NSArray *resultArray = [dictResult objectForKey:@"results"];
        NSDictionary *resultdict;
        if (resultArray.count > 0) {
            resultdict = resultArray[0];
        }
        //更新升级应用程序
        NSString * version = [resultdict objectForKey:@"version"];
        NSString *appCurVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        float appCurVersion2 = [[appCurVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue];
        float appNewVersion2 = [[version stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue];
        //因为判断是否更新试讲两版本好进行比较，所以，写APP版本时，注意一下
        if (appNewVersion2 > appCurVersion2) {
            
            NSString * appUrl = [resultdict objectForKey:@"trackViewUrl"];
            NSString * alertTitle = @"版本更新";
            //AppStore对应文档信息里是没有appInfo字段，我们可以根据这个字段判断当前是企业更新海事商店更新
            NSString * appInfo = [resultdict objectForKey:@"appInfo"];
            NSString * alertInfo = [NSString stringWithFormat:@"当前最新版本：%@ \n 更新内容：%@",version,appInfo];
            //这个appImportant是为了判断但前的企业应用更新是否需要强制更新
            NSString * appImportant = [dictResult valueForKeyPath:@"appImportant"];
            
            if([appImportant isEqualToString:@"1"]){
                alertTitle = @"版本重要更新，必须升级才能操作！";
            }else {
                appImportant = @"0";
            }
            
            if (appInfo) {
                alertInfo = [NSString stringWithFormat:@"当前最新版本：%@ \n 更新内容：%@",version,appInfo];
            }else {
                alertInfo = [NSString stringWithFormat:@"%@",version];
            }
            
            NSDictionary * dict = @{@"appUrl":appUrl,@"alertTitle":alertTitle,@"alertInfo":alertInfo,@"appImportant":appImportant};
            
            success(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
