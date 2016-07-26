//
//  DashedTableViewCell.m
//  TongQuanDai
//
//  Created by very good on 15/8/13.
//  Copyright (c) 2015年 xianghaitao. All rights reserved.
//

#import "DashedTableViewCell.h"

@implementation DashedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _isDrawLine = YES;
    _isDash = YES;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        _isDrawLine = YES;
        _isDash = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isDrawLine = YES;
        _isDash = YES;
    }
    return self;
}

// 自绘分割线
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1.0].CGColor);
    CGContextFillRect(context, rect);
    
    if (_isDrawLine) {
        
        rect = CGRectMake(rect.origin.x, rect.origin.y,rect.size.width, rect.size.height);
        
        CGFloat minx = CGRectGetMinX(rect) ;
        CGFloat maxx = CGRectGetMaxX(rect) ;
        //CGFloat miny = CGRectGetMinY(rect) ;
        CGFloat maxy = CGRectGetMaxY(rect) ;
        
        CGContextBeginPath(context);
        CGContextSetStrokeColorWithColor(context,[UIColor lightGrayColor].CGColor);
        
        if (_isDash) {
            CGFloat dash[2] = {2.f,2.f};
            CGContextMoveToPoint(context, maxx, maxy);
            CGContextSetLineDash(context,0,dash,2);
            CGContextAddLineToPoint(context, minx,maxy);
        }
        else
        {
            CGContextSetLineWidth(context,1);
            CGContextMoveToPoint(context, maxx, maxy);
            CGContextAddLineToPoint(context, minx,maxy);
        }
        
        CGContextStrokePath(context);
        
    }
}

@end
