//
//  BtnMaskLayer.h
//  GFTWallet
//
//  Created by 李阳 on 16/3/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnMaskLayer : UIButton

- (void)setMaskLayer:(CGRect)rect;

- (void)changeAlpha:(UIButton *)sender;

- (void)setMaskLayerAlpha:(float)alphaValue;

@property (nonatomic,copy) void (^alphaChangeAction)();

@end
