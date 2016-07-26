//
//  TabBarController.m
//  GFTWallet
//
//  Created by 李阳 on 16/3/25.
//  Copyright © 2016年 liyang. All rights reserved.
//

//如果想自己控制tabbar的现实和隐藏，可以在 viewWillAppear 或者 viewWillDisappear 中进行设置
//[[self rdv_tabBarController] setTabBarHidden:NO];
//通过控制 Index 也可以做页面间的切换操作 [[self rdv_tabBarController] setSelectedIndex:2];

#import "TabBarController.h"

#import "UIColor+Util.h"

#import "FirstViewController.h"
#import "OffLineMapViewController.h"
#import "MapLocationViewController.h"
#import "MyAliPayViewController.h"

@implementation TabBarController

+ (RDVTabBarController *)getTabBarController {
    
    FirstViewController *VC1 = [[FirstViewController alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:VC1];
    
    OffLineMapViewController *VC2 = [[OffLineMapViewController alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:VC2];
    
    MapLocationViewController *VC3 = [[MapLocationViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:VC3];
    
    MyAliPayViewController *VC4 = [[MyAliPayViewController alloc] init];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:VC4];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]];
    
    RDVTabBar *tabber = tabBarController.tabBar;
    tabber.layer.borderWidth = 0.5;
    tabber.layer.borderColor = [UIColor textSecondColor].CGColor;
    [self customizeTabBarForController:tabBarController];
    
    return tabBarController;
    
}

+ (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //1.UIImage 对象尽量不要直接放到数组中，如果系统没有找到该图片，要么数组长度不对，要么Xcode直接崩溃
    //2.图片命名最好类似于 ic_%@_focus ic_%@_normal，并且放在Assets.xcassets中，分类整理好
    NSArray *tabBarItemImages = @[@"workStation",@"vesselTax",@"chargeRecord",@"set"];
    NSArray *tabTitle = @[@"基本地图",@"离线地图",@"定位导航",@"多平台支付"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        [item setBackgroundColor:[UIColor whiteColor]];
        [item  setUnselectedTitleAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                              NSForegroundColorAttributeName:[UIColor blackColor]
                                              } ];
        item.title = [NSString stringWithFormat:@"%@",tabTitle[index]];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_focus",
                                                      [tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"ic_%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
//        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item  setSelectedTitleAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                            NSForegroundColorAttributeName:[UIColor colorWithHex:0x00A0EA]
                                            } ];
        index++;
    }
}

@end
