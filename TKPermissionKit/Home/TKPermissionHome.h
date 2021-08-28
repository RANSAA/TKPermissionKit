//
//  TKPermissionHome.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"

NS_ASSUME_NONNULL_BEGIN

/*
 功能：HomeKit住宅数据 权限获取与请求
 要求：iOS8.0+
 注意: 需要打开项目中的HomeKit

 

 权限描述:
 NSHomeKitUsageDescription          需要您的同意，才能访问HomeKit

 **/


@interface TKPermissionHome : NSObject

/**
 请求HomeKit住宅数据权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

@end

NS_ASSUME_NONNULL_END
