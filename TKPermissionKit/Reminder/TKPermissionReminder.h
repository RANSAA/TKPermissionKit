//
//  TKPermissionReminder.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 功能：提醒事项 权限获取与请求
 要求：iOS6.0+


 权限描述:
 Privacy - Reminders Usage Description                              需要您的同意，才能访问提醒事项

 **/


@interface TKPermissionReminder : NSObject

/**
 请求提醒事项权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了提醒事项权限
 **/
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
