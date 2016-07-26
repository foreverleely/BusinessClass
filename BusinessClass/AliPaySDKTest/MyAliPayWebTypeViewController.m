//
//  MyAliPayWebTypeViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MyAliPayWebTypeViewController.h"
////支付宝支付
#import <AlipaySDK/AlipaySDK.h>
//Views
#import "MyWebView.h"
//Pod
#import "Masonry.h"

@interface MyAliPayWebTypeViewController ()<UIWebViewDelegate> {
    
}

@property (nonatomic, strong) MyWebView *alipayWebView;

@end

@implementation MyAliPayWebTypeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setLayOut {
    
    [self.view addSubview:self.alipayWebView];
    [self.alipayWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
   
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.alipayWebView.mywebView.delegate = nil;
}

#pragma mark - method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[request.URL absoluteString]];
    if (orderInfo.length > 0) {
        [self payWithUrlOrder:orderInfo];
        return NO;
    }
    return YES;
}


- (void)payWithUrlOrder:(NSString*)urlOrder
{
    if (urlOrder.length > 0) {
        __weak MyAliPayWebTypeViewController* wself = self;
        [[AlipaySDK defaultService]payUrlOrder:urlOrder fromScheme:@"alisdkdemo" callback:^(NSDictionary* result) {
            // 处理支付结果
            NSLog(@"%@", result);
            // isProcessUrlPay 代表 支付宝已经处理该URL
            if ([result[@"isProcessUrlPay"] boolValue]) {
                // returnUrl 代表 第三方App需要跳转的成功页URL
                NSString* urlStr = result[@"returnUrl"];
                [wself loadWithUrlStr:urlStr];
            }
        }];
    }
}

- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.alipayWebView.mywebView loadRequest:webRequest];
        });
    }
}

#pragma mark - setter and getter
- (MyWebView *)alipayWebView {
    if (!_alipayWebView) {
        _alipayWebView = [[MyWebView alloc] init];
        _alipayWebView.mywebView.delegate = self;
        // 加载已经配置的url
        NSString* webUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"alipayweburl"];
        if (webUrl.length > 0) {
            [_alipayWebView goToUrlWithOvertime:webUrl];
        }
        
    }
    return _alipayWebView;
}



@end
