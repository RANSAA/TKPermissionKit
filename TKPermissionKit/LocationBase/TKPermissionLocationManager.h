//
//  TKPermissionLocationManager.h
//  TKPermissionKitDemo
//
//  Created by PC on 2020/8/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionLocationManager : NSObject

+ (CLLocationManager *)signleLocationManager;

@end

NS_ASSUME_NONNULL_END
