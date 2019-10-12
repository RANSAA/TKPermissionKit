//
//  TKPermissionLocationAlways.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionLocationAlways.h"
#import "TKPermissionPublic.h"
#import <CoreLocation/CoreLocation.h>


@interface TKPermissionLocationAlways ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@end

@implementation TKPermissionLocationAlways

+ (id)shared
{
    static dispatch_once_t onceToken;
    static TKPermissionLocationAlways *obj = nil;
    dispatch_once(&onceToken, ^{
        obj = [TKPermissionLocationAlways new];
    });
    return obj;
}

- (void)jumpSetting
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TKPermissionPublic alertTitle:@"权限提示" msg:@"访问位置时需要您提供权限，请将位置设置为\"始终\""];
    });
}

- (void)alertAction
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TKPermissionPublic alertActionTitle:@"提示" msg:@"请先到\"隐私\"中，开启定位服务！"];
    });
}

/**
 查询是否获取了始终访问位置权限
 PS:只有选择了"始终"，才会返回YES
 **/
- (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedAlways) {
            isAuth = YES;
        }
    }
    return isAuth;
}

/**
 请求始终访问位置权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
    }else{
        [self alertAction];
        self.block(NO);
    }
}

/**
 CLLocationManagerDelegate: 获取权限状态
 **/
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.block(YES);
    }else{
        if (self.isAlert && (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusAuthorizedWhenInUse)) {
            [self jumpSetting];
        }
        self.block(NO);
    }
}


@end
