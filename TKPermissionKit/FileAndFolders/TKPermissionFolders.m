//
//  TKPermissionFolders.m
//  TKPermissionKitDemo
//
//  Created by PC on 2020/8/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "TKPermissionFolders.h"
#import "TKPermissionPublic.h"


@implementation TKPermissionFolders

/**
 文件与文件夹访问权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    [TKPermissionPublic alertTips:TKPermissionString(@"文件与文件夹访问权限不需要请求，直接在info文件中添加描述即可!")];
    NSString *key = @"\n 权限描述(根据需求选取):\n Supports opening documents in place        =  YES \n Supports Document Browser                  =  YES\n Application supports iTunes file sharing   =  YES";
    NSLog(@"%@",key);
}

@end
