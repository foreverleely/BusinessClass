

//
//  ThirdViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "ThirdViewController.h"
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "IndoorMapViewController.h"

@interface ThirdViewController()<BMKMapViewDelegate>

@property(nonatomic, strong) BMKMapView *mapView;

@end


@implementation ThirdViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本地图-瓦片图层";
    [self initRightButton];
    self.view = self.mapView;
    [self initurlTileLayer];
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

- (void)initurlTileLayer {
    BMKURLTileLayer *urlTileLayer = [[BMKURLTileLayer alloc] initWithURLTemplate:@"http://api0.map.bdimg.com/customimage/tile?&x={x}&y={y}&z={z}&udt=20150601&customid=light"];
    //要看到瓦片图层，_mapView需缩放到以下两个取值之间
    urlTileLayer.maxZoom = 18;
    urlTileLayer.minZoom = 16;
    urlTileLayer.visibleMapRect = BMKMapRectMake(32994258, 35853667, 3122, 5541);
    [self.mapView addOverlay:urlTileLayer];
}

#pragma mark - method
- (void)GoaheadVC {
    [self.navigationController pushViewController:[IndoorMapViewController new] animated:NO];
}

#pragma mark - BMKMapViewDelegate
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKTileLayer class]]) {
        BMKTileLayerView *view = [[BMKTileLayerView alloc] initWithTileLayer:overlay];
        return view;
    }
    return nil;
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        _mapView.zoomLevel = 16;
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.924, 116.403);
    }
    return _mapView;
}

@end
