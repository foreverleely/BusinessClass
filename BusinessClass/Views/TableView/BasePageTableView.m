//
//  BasePageTableView.m
//  ShipGoodApplyCompare
//
//  Created by 李阳 on 16/5/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "BasePageTableView.h"
#import "UIColor+Util.h"
#import "MessageHintCell.h"
#import "AFNetworking.h"



static NSString * const CellID = @"CellID";
static NSString * const headerCellID = @"headerCellID";

@implementation BasePageTableView
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor backGroundColor];
        _dataArr = [NSMutableArray new];
        [self setUpRefresh];
        self.backgroundColor = [UIColor backGroundColor];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
        
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArr.count == 0) {
        return 1;
    }
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_dataArr.count == 0) {
        [self setMj_footer:nil];
        UITableViewCell *cell = [MessageHintCell getMessageHintCell:tableView];
        cell.userInteractionEnabled = NO;
        return cell;
    } else if (!self.mj_footer){
        [self setUpRefresh];
    }
    
    NSAssert(_baseCell || _base2Cell, @"cell can not be nil");
    if (_baseCell) {
        
        BasePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.isDrawLine = YES;
        cell.isDash = YES;
        cell.tag = indexPath.row;
        MyBaseObject *model = _dataArr[indexPath.row];
        [cell setDataWithModel:model];
        [self cellEvent:cell];
        return cell;
    }else {
        
        BasePage2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        cell.isDrawLine = YES;
        cell.isDash = YES;
        cell.tag = indexPath.row;
        MyBaseObject *model = _dataArr[indexPath.row];
        [cell setDateWithModel:model Cell:cell];
        //        [self cellEvent:cell];
        return cell;
    }
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    DashedTableViewCell *cell = (DashedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headerCellID];
    cell.isDrawLine = YES;
    cell.isDash = NO;
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.font = [UIFont boldSystemFontOfSize:14.0];
            label.textColor = [UIColor colorWithHex:0x333333];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!_headerCell && !_header2Cell) {
        return 0.0;
    }
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self setCellHeightForIndexPath:indexPath];
}

- (CGFloat )setCellHeightForIndexPath:(NSIndexPath *)indexPath {
    //如果想得到每层cell高度，就带着列表的数据源数组从写这个方法
    return 44.0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyBaseObject *model = _dataArr[indexPath.row];
    if (_rowSelect) {
        _rowSelect(model);
    }
    
}

#pragma mark - getter and setter
- (void)setBaseCell:(BasePageTableViewCell *)baseCell {
    _baseCell = baseCell;
    [self registerNib:[UINib nibWithNibName:[NSString stringWithUTF8String:object_getClassName(baseCell)] bundle:nil] forCellReuseIdentifier:CellID];
}

- (void)setBase2Cell:(BasePage2TableViewCell *)base2Cell {
    _base2Cell = base2Cell;
    [self registerClass:base2Cell.class forCellReuseIdentifier:CellID];
}

- (void)setHeaderCell:(DashedTableViewCell *)headerCell {
    _headerCell = headerCell;
    [self registerNib:[UINib nibWithNibName:[NSString stringWithUTF8String:object_getClassName(headerCell)] bundle:nil] forCellReuseIdentifier:headerCellID];
}

- (void)setHeader2Cell:(BasePage2TableViewCell *)header2Cell {
    _header2Cell = header2Cell;
    [self registerClass:_header2Cell.class forCellReuseIdentifier:headerCellID];
}

- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
    //BaseUrl 的 set 方法是调用下面的方法获取数据，所以初始化 BaseUrl 时的时刻要注意
    [self getDatas:1 endTitle:nil];
}

- (void)setUpRefresh {
    __weak typeof(self)weakSelf = self;
    
    if (!self.mj_header&&!_isHideheader) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            [weakSelf getDatas:1 endTitle:@"header"];
            weakSelf.CurrentPage = 1;
        }];
    }
    
    if (!self.mj_footer&&!_isHideFooter) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.CurrentPage += 1;
            [weakSelf getDatas:(int)weakSelf.CurrentPage endTitle:@"footer"];
        }];
    }
    
}

- (void)setIsHideFooter:(BOOL)isHideFooter {
    _isHideFooter = isHideFooter;
    if (self.mj_footer) {
        self.mj_footer = nil;
    }
}

- (void)setIsHideheader:(BOOL)isHideheader {
    _isHideheader = isHideheader;
    if (self.mj_header) {
        self.mj_header = nil;
    }
}

#pragma mark - private methods
- (void)getDatas:(int)page endTitle:(NSString *)where{
    //需要注意
    //1.列表下拉刷新查询的是第一页，也就是下拉刷新后，战士的数据是第一页的
    //2.上拉加载更多查询的数据必须是分页的，即每页数据不是交叉的
    //3.重写这个方法时，一定要注意列表的 CurrentPage ，我们是通过这个属性来判断当前获得的数据是第几页的，第一页的话，列表的数据源数组就直接和获取到的数据数组相等，如果不是第一页，就在原列表的数据数组上添加进去。
    //4.注意获取的数据的数据层级格式
    
}

- (void) endRefreshAt:(NSString *) where {
    if ([where isEqualToString:@"header"]) {
        [self.mj_header endRefreshing];
        
    } else if ([where isEqualToString:@"footer"]) {
        [self.mj_footer endRefreshing];
    }
    
}

- (void)cellEvent:(UITableViewCell *)cell {
    
}

@end
