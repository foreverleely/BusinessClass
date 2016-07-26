//
//  MySearchBar.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MySearchBar.h"
//Categories
#import "UIColor+Util.h"

@implementation MySearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.barTintColor = [UIColor backGroundColor];
    }
    return self;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    if (_btnmasklayer) {
        //如果有遮罩层，设其透明度为0.6
        [_btnmasklayer setMaskLayerAlpha:0.6];
    }
    
    return YES;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //取消键盘响应并进行查询
    [self resignFirstResponder];
    if (self.selectData) {
        _selectData(searchBar.text);
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.selectData) {
        _selectData(searchText);
    }
}

@end
