//
//  TKPermissionHealth.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionHealth : NSObject

+ (id)shared;

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
