//
//  MyWebView.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/6/2.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
//CocoaPod
#import "NJKWebViewProgress.h"

@interface MyWebView : UIView<UIWebViewDelegate,NJKWebViewProgressDelegate>

@property (nonatomic,strong) UIWebView *mywebView;

- (void)goToUrlWithOvertime:(NSString *)url;
- (void)goToUrlWithoutOvertime:(NSString *)url;

@end
