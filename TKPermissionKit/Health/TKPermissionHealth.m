//
//  TKPermissionHealth.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionHealth.h"


@interface TKPermissionHealth ()
@property (nonatomic, strong) HKHealthStore   *healthStore;
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;


@property (nonatomic, strong) NSSet *writeTypes;
@property (nonatomic, strong) NSSet *readTypes;
@property (class, nonatomic, strong, readonly) TKPermissionHealth *shared;

@end

@implementation TKPermissionHealth


- (void)jumpSetting
{
    NSString *msg = TKPermissionString(@"您可以稍后在\"健康\"App中打开健康数据类别。");
    [TKPermissionPublic alertTips:msg];
}

- (void)alertAction
{
    [TKPermissionPublic alertTips:TKPermissionString(@"当前设备不支持HealthKit")];
}


static TKPermissionHealth * _shared = nil;
+ (TKPermissionHealth *)shared
{
    if (!_shared) {
        _shared = [[TKPermissionHealth alloc] init];
        HKObjectType *type = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
        _shared.writeTypes = [NSSet setWithObject:type];
        _shared.readTypes  = [NSSet setWithObject:type];
    }
    return _shared;
}


- (HKHealthStore *)healthStore
{
    if (!_healthStore) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}


/**
 需要写入Health中的HKSampleType NSSet集合
 PS:可以通过该方法自定义设置需要写入的HKSampleType 集合
 */
+ (void)setHKWriteTypes:(NSSet<HKSampleType *> *)shareTypes
{
    self.shared.writeTypes = shareTypes;
}

/**
 需要读取Health中的HKObjectType NSSet集合
 PS:可以通过该方法自定义设置需要读取的HKObjectType 集合
 */
+ (void)setHKReadTypes:(NSSet<HKObjectType *> *)readTypes
{
    self.shared.readTypes = readTypes;
}

+ (NSSet *)allTypes
{
    NSMutableSet *sets = [[NSMutableSet alloc] initWithSet:self.shared.writeTypes];
    [sets addObjectsFromArray:self.shared.readTypes.allObjects];
    return sets;
}

/**
 检查Healt指定的类别是否授权
 ⚠️：只能检测向Health中"写入数据"的类型授权状态
 **/
+ (BOOL)checkAuthWith:(HKObjectType *)type
{
    if ([HKHealthStore isHealthDataAvailable]) {
        HKAuthorizationStatus status = [self.shared.healthStore authorizationStatusForType:type];
        if (HKAuthorizationStatusSharingAuthorized == status) {
            return YES;
        }
        return  NO;
    }else{
        return NO;
    }
}


/**
 请求HealthKit权限
 ⚠️:只能检测向Health中"写入数据"的类型授权状态，"读取数据"的类型不能检测到是否授权。
 ⚠️:如果"写入数据"类型中有多个type,只要有一个type授权了，就会返回到整个Health已经授权了；反之即使"读取数据"类型中的全部type都授权了，"写入数据"中没有授权的type，那么总是会返回Health没有授权
 ⚠️:"写入数据"类型中可以通过+checkAuthWith:获取准确的授权状态。
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    TKPermissionHealth *obj = self.shared;
    obj.block = completion;
    obj.isAlert = isAlert;
    if ([HKHealthStore isHealthDataAvailable]) {
        [obj.healthStore requestAuthorizationToShareTypes:self.shared.writeTypes readTypes:self.shared.readTypes completion:^(BOOL success, NSError * _Nullable error) {
            BOOL auth = NO;
            NSSet *sets = [self allTypes];
            for (HKObjectType *type in sets) {//在所有类别中只要有一个授权，就当做用户已经授权了
                if ([self checkAuthWith:type]) {
                    auth = YES;
                    break;
                }
            }
            if (auth) {
                [obj returnBlock:YES];
            }else{
                if (obj.isAlert) {
                    [obj jumpSetting];
                }
                [obj returnBlock:NO];
            }
        }];
    }else{
        if (obj.isAlert) {
            [obj alertAction];
        }
        [obj returnBlock:NO];
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
