//
//  TKPermissionTracking.h
//  TKPermissionKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**

 功能：iOS IDFA 广告追踪权限获取
 说明：iOS14+ 获取IDFA时需要授权，如果不授权将获取不到可被追踪的IDFA标识，低于iOS14的版本不需要授权。
 ⚠️：不管授权是否成功都将返回一个idfa字符串，区别在于能否被追踪(即是否是一个有效的IDFA标识符)


 权限描述:
 NSUserTrackingUsageDescription          需要您的同意，才能对App进行跟踪

 */

@interface TKPermissionTracking : NSObject


/**
 请求AppTrackingTransparency用户权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth: YES:idfa为有效可被追踪的标识符；NO:idfa为无效有效不可被追踪的标识符
 idfa: IDFA标识符
 **/
+ (void)authWithCompletion:(void(^)(BOOL isAuth, NSString *idfa))completion;

@end

NS_ASSUME_NONNULL_END
