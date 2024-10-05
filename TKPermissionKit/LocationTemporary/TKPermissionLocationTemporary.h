//
//  TKPermissionLocationTemporary.h
//  TKPermissionKitDemo
//
//  Created by kimi on 2024/10/5.
//  Copyright © 2024 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"

NS_ASSUME_NONNULL_BEGIN


/**
 功能：App运行期间临时请求一次准确的位置信息
 要求：iOS14.0+
 注意：
 1. 临时准确位置信息请求的前提是必须有位置授权权限，例如TKPermissionLocationAlways或TKPermissionLocationWhen权限请求成功之后请求。
 2. 临时精准的位置授权认证在App运行期间只会进行一次授权，App重新运行后需要再次授权。
 
 权限描述：
 NSLocationTemporaryUsageDescriptionDictionary      说明：临时请求一次精确位置信息需要的权限描述，类型字典。
    - Key:ExampleUsageDescription                   描述：此应用程序需要准确的定位，以便验证您是否在受支持的地区。
    - Key:AnotherUsageDescription                   描述：此应用程序需要准确的位置，以便向您显示相关结果。
 注意：
 1.按照需求类型填写对应的Key与描述。
 系统介绍示例：
 *   <key>NSLocationTemporaryUsageDescriptionDictionary</key>
 *   <dict>
 *      <key>ExampleUsageDescription</key>
 *      <string>This app needs accurate location so it can verify that you're in a supported region.</string>
 *      <key>AnotherUsageDescription</key>
 *      <string>This app needs accurate location so it can show you relevant results.</string>
 *   </dict>
 2. 要想请求一次精准位置权限，需要App使用获取位置信息精度较低的授权描述(只能获取大致位置信息，例如只能定位在所在县城)，即需要如下配置：
 <key>NSLocationDefaultAccuracyReduced</key>
 <true/>
 
 
 
 
 
 
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
 
 
 */

@interface TKPermissionLocationTemporary : NSObject

@end

NS_ASSUME_NONNULL_END
