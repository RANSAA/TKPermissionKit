//
//  TKPermissionLocationManager.m
//  TKPermissionKitDemo
//
//  Created by PC on 2020/8/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import "TKPermissionLocationManager.h"


@implementation TKPermissionLocationManager

static CLLocationManager *locationManager = nil;
+ (CLLocationManager *)signleLocationManager
{
    locationManager.delegate = nil;
    locationManager = nil;
    locationManager = [[CLLocationManager alloc]init];
    return locationManager;
}


@end
