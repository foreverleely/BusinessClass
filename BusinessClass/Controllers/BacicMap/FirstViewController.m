//
//  FirstViewController.m
//  BusinessClass
//
//  Created by 李阳 on 16/6/29.
//  Copyright © 2016年 liyang. All rights reserved.
//

//基本地图
//离线地图

#import "FirstViewController.h"
//百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "SecondViewController.h"

@interface FirstViewController()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation FirstViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"基本地图-第一部分";
    [self initRightButton];
    self.view = self.mapView;
}

- (void)initRightButton {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(GoaheadVC)];
    negativeSpacer.width = -16;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}

- (void)viewDidAppear:(BOOL)animated {
    // 设置地图标注基本属性
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
}

#pragma mark - method
- (void)GoaheadVC {
    [self.navigationController pushViewController:[SecondViewController new] animated:NO];
}

#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

#pragma mark - setter and getter
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.trafficEnabled = YES;
    //    mapView.baiduHeatMapEnabled = YES;
        //打开或关闭底图标注，默认打开
//        _mapView.showMapPoi = NO;
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.924257, 116.403263);
        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.038325, 0.028045);
        _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
//        _mapView.rotateEnabled = NO;//禁用旋转手势
    }
    return _mapView;
}

@end
