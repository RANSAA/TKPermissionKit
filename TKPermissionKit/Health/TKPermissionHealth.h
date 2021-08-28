//
//  TKPermissionHealth.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"
#import <HealthKit/HealthKit.h>


NS_ASSUME_NONNULL_BEGIN


/**
 功能：HealthKit健康 权限获取与请求
 要求：iOS8.0+
 条件：需要打开项目中的HealthKit 开关


 ⚠️⚠️⚠️使用说明:
        1.该工具只能检测"写入数据"类型中的HealthKit权限，无法检测"读取数据"类型中的HealthKit权限。
        2.如果"写入数据"类型中的多个type中只要有一个type授权了，那么整个请求认证方法将会返回YES。（不会管"读取数据"中的类型授权状态）
        3.如果"写入数据"类型中没有一个type授权，那么即使"读取数据"类型中的所有type都授权了，那么整个请求认证方法将会返回NO。（无法判断"读取数据"类型中type授权状态）
        4.可以通过+checkAuthWith:方法检测"写入数据"类型中的Health type权限。
        5.可通过+setHKWriteTypes：或setHKReadTypes：方法来设置Health的type



 权限描述:
 NSHealthShareUsageDescription           需要您的同意，才能访问健康分享
 NSHealthUpdateUsageDescription          需要您的同意，才能访问健康更新

 **/


@interface TKPermissionHealth : NSObject


/**
 例子：

// HKQuantityType *stepCountType   = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
// NSSet *write = [NSSet setWithObjects:stepCountType,nil];
// NSSet *read  = [NSSet setWithObjects:stepCountType,nil];


HKQuantityType *heightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
HKQuantityType *weightType      = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
HKQuantityType *temperatureType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
HKQuantityType *distance        = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
HKQuantityType *activeEnergyType= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];


HKCharacteristicType *birthdayType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
HKCharacteristicType *sexType = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];


 */


/**
 需要写入Health中的HKSampleType NSSet集合
 PS:可以通过该方法自定义设置需要写入的HKSampleType 集合
 */
+ (void)setHKWriteTypes:(NSSet<HKSampleType *> *)shareTypes;


/**
 需要读取Health中的HKObjectType NSSet集合
 PS:可以通过该方法自定义设置需要读取的HKObjectType 集合
 */
+ (void)setHKReadTypes:(NSSet<HKObjectType *> *)readTypes;


/**
 请求HealthKit权限，需要先通过+setHKWriteTypes:或+setHKReadTypes:添加授权类型
 ⚠️:只能检测向Health中"写入数据"的类型授权状态，"读取数据"的类型不能检测到是否授权。
 ⚠️:如果"写入数据"类型中有多个type,只要有一个type授权了，就会返回到整个Health已经授权了；反之即使"读取数据"类型中的全部type都授权了，"写入数据"中没有授权的type，那么总是会返回Health没有授权
 ⚠️:"写入数据"类型中可以通过+checkAuthWith:获取准确的授权状态。
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 检查Healt指定的类别是否授权
 ⚠️：只能检测向Health中"写入数据"的类型授权状态
 **/
+ (BOOL)checkAuthWith:(HKObjectType *)type;


@end

NS_ASSUME_NONNULL_END
