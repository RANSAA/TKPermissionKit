//
//  TKPermissionSiri.h
//  TKPermissionKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"


NS_ASSUME_NONNULL_BEGIN

/**
 功能：Siri权限获取
 要求：iOS10+
    ：需要在项目中设置Siri


 其它权限描述:
 NSSiriUsageDescription               需要您的同意，才能访问Siri
 

 **/



@interface TKPermissionSiri : NSObject

/**
 请求Siri权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 检查Siri权限
 */
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
