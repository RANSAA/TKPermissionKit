//
//  TKPermissionNotification.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 功能：请求推送通知权限
 注意: iOS10.0+可以正确的拿到权限状态，系统版本低于iOS10时，直接返回YES!
 ⚠️⚠️⚠️需要打开项目中的：
        1.Push Notifications 开关
        2.Background Modes --> Remote notifications 开关

 **/

@interface TKPermissionNotification : NSObject

/**
 请求推送通知权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

@end

NS_ASSUME_NONNULL_END
