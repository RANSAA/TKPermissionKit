//
//  TKPermissionHealth.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 功能：HealthKit健康 权限获取与请求
 要求：iOS8.0+
 注意: 必须使用单利请求，获取HealthKit权限
 ⚠️⚠️⚠️不推荐使用
 ⚠️⚠️⚠️在实际使用HealthKit时不要使用该类获取权限，因为HealthKit中的类型很多,
        使用不同的类型都需要对应的授权，所以该类不能通用获取HealthKit权限，
        该类只是针对于：步数（HKQuantityTypeIdentifierStepCount）来进行权限处理的，
        实际使用HealthKit可以以改方法为例子，进行具体的HealthKit权限处理。


 ⚠️⚠️⚠️需要打开项目中的：
        1. HealthKit 开关



 权限描述:
 Privacy - Health Share Usage Description                           需要您的同意，才能访问健康分享
 Privacy - Health Update Usage Description                          需要您的同意，才能访问健康更新

 **/


@interface TKPermissionHealth : NSObject

+ (instancetype)shared;
/**
 请求HealthKit权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了HealthKit权限
 PS:只有选择了"始终"，才会返回YES
 **/
- (BOOL)checkAuth;


@end

NS_ASSUME_NONNULL_END
