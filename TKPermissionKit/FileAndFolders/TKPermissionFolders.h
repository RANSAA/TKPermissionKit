//
//  TKPermissionFolders.h
//  TKPermissionKitDemo
//
//  Created by PC on 2020/8/12.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
功能：文件与文件夹访问权限
要求：iOS11.0+
注意: 该权限不需要请求，直接配置到info中即可


权限描述(根据需求选取):
Supports opening documents in place    =     YES
Supports Document Browser               =   YES
Application supports iTunes file sharing  =  YES




 代码示例：
 - (BOOL)showFilesWithURL:(NSURL *)URL
 {
     assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
     NSError *error = nil;
     BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
     if (!success) {
         NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
     }
     return success;
 }

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     // Override point for customization after application launch.

     //
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     [self showFilesWithURL:[NSURL fileURLWithPath:documentsDirectory]];

     return YES;
 }


 UIDocumentPickerViewController * controller = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:[@""] inMode:UIDocumentPickerModeOpen];
 controller.delegate = self;
 [self presentViewController:controller animated:YES completion:nil];


**/

@interface TKPermissionFolders : NSObject

/**
 文件与文件夹访问权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 isAuth:  回调，用户是否申请权限成功！
 **/
+ (void)authWithAlert:(BOOL)isAlert completion:(void(^)(BOOL isAuth))completion;

@end

NS_ASSUME_NONNULL_END
