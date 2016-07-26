//
//  BtnMaskLayer.m
//  GFTWallet
//
//  Created by 李阳 on 16/3/30.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "BtnMaskLayer.h"

@implementation BtnMaskLayer

- (void)setMaskLayer:(CGRect)rect {
    
    self.frame = rect;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.0;
    [self addTarget:self action:@selector(changeAlpha:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeAlpha:(UIButton *)sender {
    [self setMaskLayerAlpha:0.0];
}

- (void)setMaskLayerAlpha:(float)alphaValue {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alpha = alphaValue;
    } completion:^(BOOL finished) {
        if (self.alphaChangeAction) {
            _alphaChangeAction();
        }
    }];
}

@end
