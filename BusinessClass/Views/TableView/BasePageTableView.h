//
//  BasePageTableView.h
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePageTableViewCell.h"//通过nib文件来layout
#import "BasePage2TableViewCell.h"//通过代码来layout
#import "MyBaseObject.h"
#import "MJRefresh.h"

@interface BasePageTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *parameter;

@property (nonatomic, strong) BasePageTableViewCell *baseCell;
@property (nonatomic, strong) BasePage2TableViewCell *base2Cell;
@property (nonatomic, strong) DashedTableViewCell *headerCell;
@property (nonatomic, strong) DashedTableViewCell *header2Cell;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger CurrentPage;
@property (nonatomic, assign) NSInteger TotalPages;

@property (nonatomic, copy) void(^rowSelect)(MyBaseObject *);

@property (nonatomic, assign) BOOL isHideFooter;
@property (nonatomic, assign) BOOL isHideheader;

- (void)getDatas:(int)page endTitle:(NSString *)where;
- (void)endRefreshAt:(NSString *) where;
- (void)cellEvent:(BasePageTableViewCell *)cell;

- (CGFloat )setCellHeightForIndexPath:(NSIndexPath *)indexPath;

@end
