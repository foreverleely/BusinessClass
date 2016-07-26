//
//  WebServiceUtil.h
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

//需要注意iOS9让所有的HTTP默认使用了HTTPS，原来的HTTP协议传输都改成TLS1.2协议进行传输。直接造成的情况就是App发请求的时候弹出网络无法连接。解决办法就是在项目的info.plist 文件里加上节点，App Transport Security Settings 类型为字典，然后添加它的子项 NSAllowsArbitraryLoads 布尔类型 设为 YES

#import <Foundation/Foundation.h>

@interface WebServiceUtil : NSObject

+ (void) getHttpRequestWithMethodName:(NSString *)MethodName params:(NSString *)params success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSDictionary *dict))failure;

+ (void)getDataFromSoapWithMethodName:(NSString *)methodName params:(NSString *)parameter success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSDictionary *dict))failed;

@end
