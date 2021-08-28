//
//  TKPermissionTracking.m
//  TKPermissionKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 mac. All rights reserved.
//

#import "TKPermissionTracking.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>


@implementation TKPermissionTracking


/**
 请求AppTrackingTransparency用户权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth: YES:idfa为有效可被追踪的标识符；NO:idfa为无效有效不可被追踪的标识符
 idfa: IDFA标识符
 **/
+ (void)authWithCompletion:(void(^)(BOOL isAuth, NSString *idfa))completion
{
    if (@available(iOS 14.0, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *idfaString = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
                if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                    completion(YES,idfaString);
                }else{
                    completion(NO,idfaString);
                }
            });
        }];
    } else {
        NSString *idfaString = [[ASIdentifierManager sharedManager] advertisingIdentifier].UUIDString;
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            completion(YES,idfaString);
        }else{
            completion(NO,idfaString);
        }
    }
}

@end
