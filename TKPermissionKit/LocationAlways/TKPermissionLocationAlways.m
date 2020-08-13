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
#import "TKPermissionLocationManager.h"



@interface TKPermissionLocationAlways ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager         *locationManager;       // 定位
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@property (nonatomic, assign) NSInteger count;
@end

@implementation TKPermissionLocationAlways

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
    self.count = 0;
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [TKPermissionLocationManager signleLocationManager];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
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
        self.count += 1;
        if (self.count == 1) {
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
}

- (void)returnBlock:(BOOL)isAuth
{
    __weak TKPermissionBlock block = self.block;
    dispatch_async(dispatch_get_main_queue(), ^{
        block(isAuth);
    });
}

@end
