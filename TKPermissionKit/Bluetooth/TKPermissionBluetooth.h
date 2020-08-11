//
//  TKPermissionBluetooth.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：蓝牙权限获取与请求
 要求：iOS7.0+
 注意:需要打开项目设置中的：Background Modes 中的LE选项才会弹出权限提示框
     它们分别是：
             1. Uses Bluetooth LE accessories
             2. Acts as a Bluetooth LE accessory
 ⚠️⚠️⚠️iOS13.0+ 有新的权限获取方式


 权限描述:
 Privacy - Bluetooth Peripheral Usage Description                   需要您的同意，才能访问蓝牙


 **/


@interface TKPermissionBluetooth : NSObject

+ (instancetype)shared;

/**
 请求蓝牙权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了蓝牙权限
 **/
- (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
