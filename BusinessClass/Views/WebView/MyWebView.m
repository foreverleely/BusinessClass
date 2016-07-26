//
//  MyWebView.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MyWebView.h"
//CocoaPod
#import "Masonry.h"

@interface MyWebView() {
    
    NJKWebViewProgress *progressPro;
    UIProgressView *progressView;
    NSURL *url2;
}

@end

@implementation MyWebView

@synthesize mywebView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubViews];
        [self setLayOut];
    }
    return self;
}

- (void)initSubViews {
    
    mywebView = [[UIWebView alloc] init];
    [mywebView setMultipleTouchEnabled:YES];
    [mywebView setScalesPageToFit:YES];
    //移除滚动后的外边阴影
    UIScrollView *scrollView = mywebView.scrollView;
    for (int i=0; i<scrollView.subviews.count; i++) {
        
        UIView *view = scrollView.subviews[i];
        if ([view isKindOfClass:[UIImageView class]]) {
            
            view.hidden = YES;
        }
    }
    
    progressPro = [[NJKWebViewProgress alloc] init];
    mywebView.delegate = progressPro;
    progressPro.webViewProxyDelegate = self;
    progressPro.progressDelegate = self;
    
    progressView = [[UIProgressView alloc] init];
    [self addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(1.5);
    }];
    
}

- (void)setLayOut {
    
    [self addSubview:mywebView];
    [mywebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(2, 0, 0, 0));
    }];
}

- (void)goToUrlWithOvertime:(NSString *)url {
    
    url2 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url2 cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    
    if (mywebView == nil) {
        
        mywebView = [UIWebView new];
    }
    [mywebView loadRequest:request];
}

- (void)goToUrlWithoutOvertime:(NSString *)url {
    
    url2 = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url2];
    
    if (mywebView == nil) {
        
        mywebView = [UIWebView new];
    }
    [mywebView loadRequest:request];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        progressView.progress = 0;
        [UIView animateWithDuration:0.27 animations:^{
            progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [UIView animateWithDuration:0.27 delay:progress - progressView.progress options:0 animations:^{
            progressView.alpha = 0.0;
        } completion:nil];
    }
    
    [progressView setProgress:progress animated:NO];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    return YES;
}

@end
