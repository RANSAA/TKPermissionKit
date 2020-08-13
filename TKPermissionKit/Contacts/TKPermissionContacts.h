//
//  TKPermissionContacts.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 功能：通讯录权限获取与请求
 要求：iOS2.0+
 注意：本工具中使用了两个系统框架进行权限获取，他们分别是：
    <Contacts/Contacts.h>           9.0+

    <AddressBook/AddressBook.h>     < 9.0  已经移出
 ⚠️⚠️⚠️如果APP审核时出现AddressBook被弃用，拒绝APP时，请自行移出<AddressBook/AddressBook.h> 相关代码


 PS:AddressBook方式如果不被Appstore拒绝，可以直接进入该文件打开注释即可


 权限描述:
 Privacy - Contacts Usage Description                               需要您的同意，才能访问通讯录


 **/

@interface TKPermissionContacts : NSObject

/**
 请求通讯录权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

/**
 查询是否获取了通讯录权限
 **/
+ (BOOL)checkAuth;


@end

NS_ASSUME_NONNULL_END
