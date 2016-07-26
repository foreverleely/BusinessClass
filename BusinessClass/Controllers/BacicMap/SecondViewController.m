//
//  SecondViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "SecondViewController.h"
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "ThirdViewController.h"

@interface SecondViewController()<BMKMapViewDelegate>

@property(nonatomic, strong) BMKMapView *mapView;

@end

@implementation SecondViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本地图-地形图图层";
    [self initRightButton];
    self.view = self.mapView;
    [self add2Properities];
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
    [self.navigationController pushViewController:[ThirdViewController new] animated:NO];
}

- (void)addProperities {
    //添加图片图层覆盖物(第一种:根据指定经纬度坐标生成)
    CLLocationCoordinate2D coors;
    coors.latitude = 39.800;
    coors.longitude = 116.404;
    BMKGroundOverlay* ground = [BMKGroundOverlay groundOverlayWithPosition:coors
                                                                 zoomLevel:11 anchor:CGPointMake(0.0f,0.0f)
                                                                      icon:[UIImage imageNamed:@"test.png"]];
    ground.alpha = 0.8;
    [self.mapView addOverlay:ground];
}

- (void)add2Properities {
    //添加图片图层覆盖物(第二种:根据指定区域生成)
    CLLocationCoordinate2D coords[2] = {0};
    coords[0].latitude = 39.815;
    coords[0].longitude = 116.404;
    coords[1].latitude = 39.915;
    coords[1].longitude = 116.504;
    BMKCoordinateBounds bound;
    bound.southWest = coords[0];
    bound.northEast = coords[1];
    BMKGroundOverlay* ground2 = [BMKGroundOverlay groundOverlayWithBounds: bound
                                                                     icon:[UIImage imageNamed:@"test.png"]];
    ground2.alpha = 0.8;
    [self.mapView addOverlay:ground2];
}

#pragma mark - BMKMapViewDelegate
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKGroundOverlay class]]){
        BMKGroundOverlayView* groundView = [[BMKGroundOverlayView alloc] initWithOverlay:overlay];
        return groundView;
    }
    return nil;
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    return _mapView;
}

@end
