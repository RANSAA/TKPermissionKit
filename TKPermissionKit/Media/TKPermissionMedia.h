//
//  TKPermissionMedia.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 功能：媒体资料库权限获取与请求
 要求：iOS9.3+     低于该版本时权限状态都返回YES（如果出现问题，请自己修改低版本权限申请方式）


 权限描述:
 Privacy - Media Library Usage Description                          需要您的同意，才能访问媒体与Apple Music

 **/


NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionMedia : NSObject

/**
 请求媒体资料库权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了媒体资料库权限
 **/
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
