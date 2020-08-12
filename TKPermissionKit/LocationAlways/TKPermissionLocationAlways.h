//
//  TKPermissionLocationAlways.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 功能：定位始终访问位置权限获取与请求，⚠️⚠️⚠️并且只有用户同意了"始终允许",获取到的权限状态才为YES
 要求：iOS8.0+
 注意: 必须使用单利请求，获取定位权限

 PS: TKPermissionLocationAlways 与 TKPermissionLocationWhen  二选一使用

 权限描述:
 Privacy - Location Always and When In Use Usage Description        需要您的同意，才能获取位置信息
 Privacy - Location When In Use Usage Description                   需要您的同意，才能在使用期间访问位置
 Privacy - Location Always Usage Description                        需要您的同意，才能始终访问位置

 **/



@interface TKPermissionLocationAlways : NSObject

+ (instancetype)shared;

/**
 请求始终访问位置权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了始终访问位置权限
 PS:只有选择了"始终"，才会返回YES
 **/
- (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
