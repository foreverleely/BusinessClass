//
//  OffLineMapViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "OffLineMapViewController.h"

//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface OffLineMapViewController ()<BMKOfflineMapDelegate> {
    BMKOfflineMap *_offlineMap;
}

@end

@implementation OffLineMapViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"离线地图";
    _offlineMap = [[BMKOfflineMap alloc] init];
    _offlineMap.delegate = self;
    NSArray* records = [_offlineMap searchCity:@"北京"];
    BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
    BOOL success = [_offlineMap start:oneRecord.cityID];
    NSLog(@"%i",success);
}
#pragma mark - BMKOfflineMapDelegate
- (void)onGetOfflineMapState:(int)type withState:(int)state {
    NSLog(@"离线地图类型:%d 状态:%d",type,state);
}

@end
