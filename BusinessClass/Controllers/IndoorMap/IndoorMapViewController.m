//
//  IndoorMapViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "IndoorMapViewController.h"
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface IndoorMapViewController()<BMKMapViewDelegate>

@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation IndoorMapViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"室内地图";
//    [self initRightButton];
    self.view = self.mapView;
}

- (void)initRightButton {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(GoaheadVC)];
    negativeSpacer.width = -16;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

#pragma mark - method
- (void)GoaheadVC {
//    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}

#pragma mark - BMKMapViewDelegate
-(void)mapview:(BMKMapView *)mapView baseIndoorMapWithIn:(BOOL)flag baseIndoorMapInfo:(BMKBaseIndoorMapInfo *)info
{
    if (flag) {//进入室内图
        //coding...
    } else {//移出室内图
        //coding...
    }
}

//搜索
//poi室内检索
- (BOOL)poiIndoorSearch:(BMKPoiIndoorSearchOption*)option {
  
//    option.indoorId = _indoorMapInfoFocused.strID;
//    option.keyword = _keyworkField.text;
//    option.pageIndex = 0;
//    option.pageCapacity = 20;
//    BOOL flag = [_search poiIndoorSearch:option];
//    if (!flag) {
//        [PromptInfo showText:@"室内检索发送失败"];
//    }
    return YES;
}

//返回POI室内搜索结果
- (void)onGetPoiIndoorResult:(BMKPoiSearch*)searcher result:(BMKPoiIndoorResult*)poiIndoorResult errorCode:(BMKSearchErrorCode)errorCode {
    NSLog(@"onGetPoiIndoorResult errorcode: %d", errorCode);
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        //成功获取结果
        for (BMKPoiIndoorInfo *info in poiIndoorResult.poiIndoorInfoList) {
            NSLog(@"name: %@  uid: %@  floor: %@", info.name, info.uid, info.floor);
        }
        
    } else {
        //检索失败
        
    }
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        _mapView.zoomLevel = 16;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.924, 116.403);
        _mapView.baseIndoorMapEnabled = YES;
        BMKSwitchIndoorFloorError error = [_mapView switchBaseIndoorMapFloor:@"F1" withID:@"indoorID"];
        if (error == BMKSwitchIndoorFloorSuccess) {
            NSLog(@"切换楼层成功");
        }
    }
    return _mapView;
}

@end
