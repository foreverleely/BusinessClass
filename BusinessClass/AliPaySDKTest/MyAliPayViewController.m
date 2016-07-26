//
//  MyAliPayViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MyAliPayViewController.h"
//支付宝支付
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayProduct.h"
//Categories
#import "UIColor+Util.h"
//Pod
#import "Masonry.h"


@interface MyAliPayViewController () {
    
}

@property (nonatomic, strong) UILabel *goodnameLabel;
@property (nonatomic, strong) UILabel *goodinfoLabel;
@property (nonatomic, strong) UILabel *goodpriceLabel;
@property (nonatomic, strong) UIButton *alipayButton;
@property (nonatomic, strong) AliPayProduct *alipayproduct;

@end

@implementation MyAliPayViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    self.title = @"多平台支付";
    [super viewDidLoad];
    [self setLayOut];
    
}

- (void)setLayOut {
    
    float offsetY = 20;
    float offsetX = 20;
    float labelwidth = self.view.frame.size.width-2*offsetX;
    float labelheight = 30;
    float buttonwidth = 100;
    float buttonheight = 40;
    
    [self.view addSubview:self.goodnameLabel];
    [self.goodnameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(offsetY);
        make.left.mas_equalTo(self.view.mas_left).offset(offsetX);
        make.width.mas_equalTo(labelwidth);
        make.height.mas_equalTo(labelheight);
    }];
    
    [self.view addSubview:self.goodinfoLabel];
    [self.goodinfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodnameLabel.mas_top).offset(offsetY);
        make.left.mas_equalTo(self.view.mas_left).offset(offsetX);
        make.width.mas_equalTo(labelwidth);
        make.height.mas_equalTo(labelheight);
    }];
    
    [self.view addSubview:self.goodpriceLabel];
    [self.goodpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodinfoLabel.mas_top).offset(offsetY);
        make.left.mas_equalTo(self.view.mas_left).offset(offsetX);
        make.width.mas_equalTo(labelwidth);
        make.height.mas_equalTo(labelheight);
    }];
    
    [self.view addSubview:self.alipayButton];
    [self.alipayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-offsetY);
        make.left.mas_equalTo(self.view.mas_left).offset(offsetX);
        make.width.mas_equalTo(buttonwidth);
        make.height.mas_equalTo(buttonheight);
    }];
    
}

#pragma mark - method
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)alipayButtonPress:(UIButton *)sender {
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
//    Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"";
    NSString *seller = @"";
    NSString *privateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.subject = self.alipayproduct.subject; //商品标题
    order.body = self.alipayproduct.body; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",self.alipayproduct.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
    
}

#pragma mark - setter and getter
- (UILabel *)goodnameLabel {
    if (!_goodnameLabel) {
        _goodnameLabel = [[UILabel alloc] init];
        _goodnameLabel.text = self.alipayproduct.subject;
        _goodnameLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _goodnameLabel;
}

- (UILabel *)goodinfoLabel {
    if (!_goodinfoLabel) {
        _goodinfoLabel = [[UILabel alloc] init];
        _goodinfoLabel.text = self.alipayproduct.body;
        _goodinfoLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _goodinfoLabel;
}

- (UILabel *)goodpriceLabel {
    if (!_goodpriceLabel) {
        _goodpriceLabel = [[UILabel alloc] init];
        _goodpriceLabel.text = [NSString stringWithFormat:@"￥%f", self.alipayproduct.price];
        _goodpriceLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _goodpriceLabel;
}

- (UIButton *)alipayButton {
    if (!_alipayButton) {
        _alipayButton = [[UIButton alloc] init];
        [_alipayButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
        _alipayButton.backgroundColor = [UIColor BtnColor];
        [_alipayButton addTarget:self action:@selector(alipayButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayButton;
}

- (AliPayProduct *)alipayproduct {
    if (!_alipayproduct) {
        _alipayproduct = [[AliPayProduct alloc] init];
        _alipayproduct.subject = @"商品名";
        _alipayproduct.body = @"描述信息";
        _alipayproduct.price = 0.01f;
    }
    return _alipayproduct;
}

@end
