//
//  TKPermissionMotion.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/12.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：运动与健身权限 权限获取与请求
 要求：iOS7.0+
 注意: 必须使用单利请求，获取运动与健身权限权限


 权限描述:
 Privacy - Motion Usage Description                                 需要您的同意，才能访问运动与健身

 **/

@interface TKPermissionMotion : NSObject

+ (instancetype)shared;

/**
 请求运动与健身权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

@end

NS_ASSUME_NONNULL_END
