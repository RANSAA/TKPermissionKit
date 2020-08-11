//
//  TKPermissionBluetooth.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionBluetooth.h"
#import "TKPermissionPublic.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface TKPermissionBluetooth ()<CBPeripheralManagerDelegate>
@property (nonatomic, strong) CBPeripheralManager *peripheralManager; 
@property (nonatomic, copy  ) TKPermissionBlock block;
@property (nonatomic, assign) BOOL isAlert;
@end

@implementation TKPermissionBluetooth

+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static id obj = nil;
    dispatch_once(&onceToken, ^{
        NSString *name = [NSString stringWithFormat:@"%@",self.class];
        Class class = NSClassFromString(name);
        obj = [[class alloc] init];
    });
    return obj;
}

- (void)jumpSetting
{
    [TKPermissionPublic alertPromptTips:TKPermissionString(@"访问蓝牙时需要您提供权限，请开启\"蓝牙共享\"")];
}

/**
 查询是否获取了蓝牙权限
 **/
- (BOOL)checkAuth
{
    BOOL isAuth = NO;
    if ([CBPeripheralManager authorizationStatus] == CBPeripheralManagerAuthorizationStatusAuthorized) {
        isAuth = YES;
    }
    return isAuth;
}

/**
 请求蓝牙权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
- (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion
{
    self.block = completion;
    self.isAlert = isAlert;
    self.peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:dispatch_get_global_queue(0, 0) options:nil];


}


#pragma mark CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    CBPeripheralManagerAuthorizationStatus status = [CBPeripheralManager authorizationStatus];
    if (status == CBPeripheralManagerAuthorizationStatusAuthorized) {
        self.block(YES);
    }else{
        if (self.isAlert && status == CBPeripheralManagerAuthorizationStatusDenied) {
            [self jumpSetting];
        }
        self.block(NO);
    }
    self.peripheralManager = nil;
}

@end
