//
//  TKPermissionLocationWhen.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionLocationWhen.h"
#import <CoreLocation/CoreLocation.h>



@interface TKPermissionLocationWhen ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;

@property (class, nonatomic, strong, readonly) TKPermissionLocationWhen *shared;
@end

@implementation TKPermissionLocationWhen

static bool safeLock = NO;//防止连续请求lock

- (void)jumpSetting
{
     [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问位置时需要您提供权限，去设置！")];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"请先到\"隐私\"中，开启定位服务！")];
}


static TKPermissionLocationWhen * _shared = nil;
+ (TKPermissionLocationWhen *)shared
{
    if (!_shared) {
        _shared = [[TKPermissionLocationWhen alloc] init];
    }
    return _shared;
}


/**
 查询是否获取了仅在使用应用期间位置权限
 **/
+ (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = kCLAuthorizationStatusNotDetermined;
        if (@available(iOS 14.0, *)) {
            CLLocationManager *manager = [[CLLocationManager alloc] init];
            status = manager.authorizationStatus;
        }else{
            status = [CLLocationManager authorizationStatus];
        }

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

+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    if (safeLock) {
        NSLog(@"TKPermissionLocationWhen权限请求任务未完成，不能申请新的请求任务......");
        return;
    }
    safeLock = YES;

    TKPermissionLocationWhen *obj = self.shared;
    obj.block = completion;
    obj.isAlert = isAlert;
    
//    if ([CLLocationManager locationServicesEnabled]) {
//        obj.locationManager = [[CLLocationManager alloc]init];
//        obj.locationManager.delegate = obj;
//        [obj.locationManager requestWhenInUseAuthorization];
//    }else{
//        [obj alertAction];
//        [obj returnBlock:NO];
//    }

    //将locationServicesEnabled方法放入子线程中请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL isEnabled = [CLLocationManager locationServicesEnabled];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(isEnabled){
                obj.locationManager = [[CLLocationManager alloc]init];
                obj.locationManager.delegate = obj;
                [obj.locationManager requestWhenInUseAuthorization];
            }else{
                [obj alertAction];
                [obj returnBlock:NO];
            }
        });
    });
}



#pragma mark CLLocationManagerDelegate: 获取权限状态
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self handleStatus:status];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager API_AVAILABLE(ios(14.0), macos(11.0), watchos(7.0), tvos(14.0))
{
    CLAuthorizationStatus status = manager.authorizationStatus;
    [self handleStatus:status];
}

- (void)handleStatus:(CLAuthorizationStatus)status
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
        safeLock = NO;
    });
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}


@end
