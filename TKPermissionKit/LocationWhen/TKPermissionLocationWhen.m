//
//  TKPermissionLocationWhen.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionLocationWhen.h"
#import "TKPermissionPublic.h"
#import <CoreLocation/CoreLocation.h>
#import "TKPermissionLocationManager.h"



@interface TKPermissionLocationWhen ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@end

@implementation TKPermissionLocationWhen

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        NSString *name = [NSString stringWithFormat:@"%@",self.class];
        Class class = NSClassFromString(name);
        obj = [[class alloc] init];
    });
    return obj;
}

- (void)jumpSetting
{
     [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问位置时需要您提供权限，去设置！")];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"请先到\"隐私\"中，开启定位服务！")];
}

/**
 查询是否获取了仅在使用应用期间位置权限
 **/
- (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            isAuth = YES;
        }
    }
    return isAuth;
}

/**
 请求仅在使用应用期间位置权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [TKPermissionLocationManager signleLocationManager];
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
    }else{
        [self alertAction];
        [self returnBlock:NO];
    }
}

/**
 CLLocationManagerDelegate: 获取权限状态
 **/
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusNotDetermined) {//第一次弹出授权页面，不处理

    }else{
        if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
            [self returnBlock:YES];
        }else{
            if (self.isAlert && status == kCLAuthorizationStatusDenied) {
                [self jumpSetting];
            }
            [self returnBlock:NO];
        }
    }
}

- (void)returnBlock:(BOOL)isAuth
{
    __weak TKPermissionBlock block = self.block;
    dispatch_async(dispatch_get_main_queue(), ^{
        block(isAuth);
    });
}

@end
