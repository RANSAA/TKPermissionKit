//
//  TKPermissionNotification.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


NS_ASSUME_NONNULL_BEGIN


/**
 功能：请求推送通知权限
 注意: iOS10.0+可以正确的拿到权限状态，系统版本低于iOS10时，直接返回YES!
 ⚠️⚠️⚠️需要打开项目中的：
        1.Push Notifications 开关
        2.Background Modes --> Remote notifications 开关

 
 注意2：
 请求权限后好需要注册远程通知获取deviceToken
 执行[UIAppliection registerForRemoteNotifications]获取推送需要的deviceToken。
 application:didRegisterForRemoteNotificationsWithDeviceToken: 成功获取设备token，或者失败application:didFailToRegisterForRemoteNotificationsWithError：
 
 
 注意3：
 application:didReceiveRemoteNotification:fetchCompletionHandler: 该方法可以使应用程序因远程通知而启动或恢复
 
 **/



#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0
typedef UNAuthorizationOptions TKPermissionUNAuthorizationOptions;
#else
typedef UIUserNotificationType TKPermissionUNAuthorizationOptions;
#endif




@interface TKPermissionNotification : NSObject

/**
 自定义UNAuthorizationOptions选项；
 如果不设置则使用:UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound
 注意:需要在authWithAlert:completion:方法之前设置才有效。
 */
+ (void)setAuthorizationOptions:(TKPermissionUNAuthorizationOptions )options;

/**
 请求推送通知权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 注意:
 如果是远程推送则需要执行[UIAppliection registerForRemoteNotifications]获取推送需要的deviceToken。
 application:didRegisterForRemoteNotificationsWithDeviceToken: 成功获取设备token，或者失败application:didFailToRegisterForRemoteNotificationsWithError：
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;


@end

NS_ASSUME_NONNULL_END
