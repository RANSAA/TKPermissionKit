//
//  TKPermissionHealth.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionHealth.h"
#import "TKPermissionPublic.h"
#import <HealthKit/HealthKit.h>


@interface TKPermissionHealth ()
@property (nonatomic, strong) HKHealthStore             *healthStore;           // 健康
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@property (nonatomic, strong) HKQuantityType *stepCountType;
@end

@implementation TKPermissionHealth

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
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!name) {
        name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    NSString *msg = [NSString stringWithFormat:@"访问HealthKit时需要您提供权限，请打开应用\"健康\"，选择\"数据来源\"，点击进入\"%@\"，选择\"打开所有类别\"",name];
    [TKPermissionPublic alertTips:msg];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"当前设备不支持HealthKit")];
}

/**
 查询是否获取了HealthKit权限
 PS:只有选择了"始终"，才会返回YES
 **/
- (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([HKHealthStore isHealthDataAvailable]) {
        HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:self.stepCountType];
        if (HKAuthorizationStatusSharingAuthorized == status) {
            isAuth = YES;
        }
    }else{
        NSLog(@"⚠️⚠️⚠️当前设备不支持HealthKit！");
    }
    return isAuth;
}


/**
 请求HealthKit权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;
    if ([HKHealthStore isHealthDataAvailable]) {

////        HKQuantityType *stepCountType   = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//        HKQuantityType *heightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
//        HKQuantityType *weightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//        HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
//        HKQuantityType *distance        = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
//        HKQuantityType *activeEnergyType= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
////        NSSet *write = [NSSet setWithObjects:stepCountType,nil];
//        HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
//        HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
////        NSSet *read  = [NSSet setWithObjects:stepCountType,nil];


        HKQuantityType *stepCountType = self.stepCountType;
        NSSet *write = [NSSet setWithObjects:stepCountType,nil];
        NSSet *read  = [NSSet setWithObjects:stepCountType,nil];
        [self.healthStore requestAuthorizationToShareTypes:write readTypes:read completion:^(BOOL success, NSError * _Nullable error) {
            HKAuthorizationStatus status = [self.healthStore authorizationStatusForType:stepCountType];
            if (HKAuthorizationStatusSharingAuthorized == status) {
                completion(YES);
            }else{
                if (self.isAlert) {
                    [self jumpSetting];
                }
                completion(NO);
            }
        }];
    }else{
        [self alertAction];
        completion(NO);
    }
}

//以步数为例子
- (HKQuantityType *)stepCountType
{
    if (!_stepCountType) {
        _stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    }
    return _stepCountType;
}

- (HKHealthStore *)healthStore
{
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}

@end
