//
//  TKPermissionLocationTemporary.m
//  TKPermissionKitDemo
//
//  Created by kimi on 2024/10/5.
//  Copyright © 2024 mac. All rights reserved.
//

#import "TKPermissionLocationTemporary.h"
#import <CoreLocation/CoreLocation.h>


@interface TKPermissionLocationTemporary ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;

@property (class, nonatomic, strong, readonly) TKPermissionLocationTemporary *shared;
@end

@implementation TKPermissionLocationTemporary
static bool safeLock = NO;//防止连续请求lock

- (void)jumpSetting
{
     [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问位置时需要您提供权限，去设置！")];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"请先到\"隐私\"中，开启定位服务！")];
}


static TKPermissionLocationTemporary * _shared = nil;
+ (TKPermissionLocationTemporary *)shared
{
    if (!_shared) {
        _shared = [[TKPermissionLocationTemporary alloc] init];
    }
    return _shared;
}



- (void)test
{
//    //请求一次精确位置信息，并授权
//    //
//    [obj.locationManager requestTemporaryFullAccuracyAuthorizationWithPurposeKey:@"ExampleUsageDescription"completion:^(NSError * error ) {
//        NSLog(@"requestTemporary error:%@",error);
//    }];
//    [obj.locationManager startUpdatingLocation];
}




//
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     请求后获取定位信息，并回调给用户
     */
    NSLog(@"locations:%@",locations);
}


@end
