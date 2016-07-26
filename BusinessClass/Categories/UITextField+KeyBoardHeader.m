//
//  UITextField+KeyBoardHeader.m
//  ShenZhenHaiShiJu
//
//  Created by 向海涛 on 16/1/27.
//  Copyright © 2016年 mgear. All rights reserved.
//

#import "UITextField+KeyBoardHeader.h"

@implementation UITextField (KeyBoardHeader)

-(void)addDismissHeader{//自定义键盘toolbar
    
    CGSize QScreenSize = [UIScreen mainScreen].bounds.size;
    
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, QScreenSize.width, 44)];
    if (QScreenSize.height < 485) {//比4s大的屏幕
        topView.frame = CGRectMake(0, 0, QScreenSize.width, 30);
    }
    //设置style
    //        [topView setBarStyle:UIBarStyleBlack];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    
    self.inputAccessoryView = topView;
    self.inputAccessoryView.backgroundColor = [UIColor whiteColor];
    self.inputAccessoryView.tintColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
}

//隐藏键盘
-(void)resignKeyboard
{
    [self resignFirstResponder];
}

@end
