//
//  TKPermissionLocationAlways.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"


NS_ASSUME_NONNULL_BEGIN

/**
 功能：定位始终访问位置权限获取与请求
 要求：iOS8.0+
 注意: TKPermissionLocationAlways 与 TKPermissionLocationWhen  二选一使用(权限描述也是2选1)



 权限描述:
 NSLocationAlwaysUsageDescription                       需要您的同意，才能访问位置信息
 NSLocationAlwaysAndWhenInUseUsageDescription           需要您的同意，才能始终访问位置信息
 NSLocationWhenInUseUsageDescription                    需要您的同意，才能访问位置信息

 NSLocationUsageDescription     需要您的同意，才能访问位置信息        PS:如果时MacOS需要包含该权限描述，iOS8之后不需要该权限描述


 

  关于iOS14新增的向用户申请临时开启一次精确位置权限问题：
    可以使用CLLocationManager的 -requestTemporaryFullAccuracyAuthorizationWithPurposeKey：方法请求一次临时的精准位置信息权限(APP运行期间只有一次的有效请求)。
    1. 在申请临时开启一次精确位置权限时，需要先申请位置访问信息权限。即先使用TKPermissionLocationWhen/TKPermissionLocationAlways申请位置权限之后才能申请临时精确位置权限.
    2. 申请临时开启一次精确位置权限的前提是，之前申请位置权限时用户关闭了《精确定位》开关。因为用户如果开启了《精确定位》就不需要再申请临时开启一次精确位置权限。
    3. 本工具中没有添加申请临时开启一次精确位置权限想过操作，如果需要请直接在APP中需要的地方添加申请临时开启一次精确位置权限，一般不需要考虑用户是否同意授权，因为用户即使不同意也只是获取到的位置信息不精确而已

    申请临时开启一次精确位置权限需要在info.plist文件中配置“NSLocationTemporaryUsageDescriptionDictionary”字典中需要配置 key 和 value 表明使用位置的原因，以及具体的描述;
    NSLocationTemporaryUsageDescriptionDictionary字典中的key和value需要用户自定义，其中key用于requestTemporaryFullAccuracyAuthorizationWithPurposeKey，value是具体描述。



  对于地理位置不敏感的App 来说，iOS14 也可以通过直接在 info.plist 中添加 NSLocationDefaultAccuracyReduced值为YES，默认请求大概位置（PS:该描述类型为boolean）。
     <key>NSLocationDefaultAccuracyReduced</key>
     <true/>

  这样设置之后，即使用户想要为该 App 开启精确定位权限，也无法开启。


 
 **/



@interface TKPermissionLocationAlways : NSObject


/**
 请求始终访问位置权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;


/**
 查询是否获取了始终访问位置权限
 PS:只有选择了"始终"，才会返回YES
 **/
+ (BOOL)checkAuth;

@end

NS_ASSUME_NONNULL_END
