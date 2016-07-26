//
//  MapLocationViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/7/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "MapLocationViewController.h"
//Pod
#import "Masonry.h"
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface MapLocationViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation MapLocationViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定位功能";
    self.view = self.mapView;
    
    //启动LocationService
    [self.locService startUserLocationService];
    
    self.mapView.showsUserLocation = NO;
    //模拟器设置的地理位置是（需自己设置）
    CLLocationCoordinate2D coor;
    coor.latitude = 39.924257;
    coor.longitude = 116.403263;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(coor.latitude, coor.longitude);
    self.mapView.centerCoordinate = center;
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.zoomLevel = 20;
    
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//跟踪
    self.mapView.showsUserLocation = YES;
    
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;//罗盘模式
    self.mapView.showsUserLocation = YES;
    
    [self.view addSubview:self.slider];
    float sliderwidth = 150;
    float sliderheight = 10;
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-sliderheight);
        make.left.mas_equalTo(self.view.mas_left).offset([UIScreen mainScreen].bounds.size.width - sliderwidth - 10);
        make.width.mas_equalTo(sliderwidth);
        make.height.mas_equalTo(sliderheight);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.mapView.delegate == nil) {
        self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
        self.locService.delegate = self;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
}

- (void)ScaleZoomLevel {
    self.mapView.zoomLevel = self.slider.value / 10;
}

#pragma mark - BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
   
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    self.mapView.centerCoordinate = center;
    [self.mapView updateLocationData:userLocation];
    
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        _mapView.delegate = self;
//        _mapView.mapType = BMKMapTypeStandard;
//        _mapView.trafficEnabled = YES;
        //    mapView.baiduHeatMapEnabled = YES;
        //打开或关闭底图标注，默认打开
        //        _mapView.showMapPoi = NO;
//        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.924257, 116.403263);
//        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.038325, 0.028045);
//        _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
        //        _mapView.rotateEnabled = NO;//禁用旋转手势
    }
    return _mapView;
}

- (BMKLocationService *)locService {
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return _locService;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.minimumValue = 1;
        _slider.maximumValue = 210;
        _slider.value = self.mapView.zoomLevel * 10;
        [_slider addTarget:self action:@selector(ScaleZoomLevel) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

@end
