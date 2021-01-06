//
//  TKPermissionPublic.m
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPermissionPublic.h"
#import <UIKit/UIKit.h>


@implementation TKPermissionPublic


#pragma mark 国际化

+ (NSBundle *)TKPermissionBundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这种方式获取NSBundle不会因为二进制文件，bundle文件是否处于framework中而受到影响
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[TKPermissionPublic class]] pathForResource:@"TKPermissionKit" ofType:@"bundle"]];
    });
    return bundle;
}

/** 直接从bundle文件中读取指定string，而获取国际化字符串*/
+ (NSString *)localizedStringForKey:(NSString *)key tab:(NSString *)tab
{
//    NSString *ls1 = NSLocalizedStringFromTableInBundle(key, tab, [self TKPermissionBundle] , nil);

    NSString *value = [[self lprojBundle] localizedStringForKey:key value:nil table:tab];
    return value;
}

//获取当前语言lproj文件对应的bundle
+ (NSBundle *)lprojBundle
{
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
          NSMutableArray *lproj = @[].mutableCopy;
          NSString *path = [[self TKPermissionBundle] resourcePath];
          NSArray *ary = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
          for (NSString *dirName in ary) {
              if ([dirName hasSuffix:@"lproj"]) {
                  [lproj addObject:[dirName stringByReplacingOccurrencesOfString:@".lproj" withString:@""]];
              }
          }
          NSString *language = [NSLocale preferredLanguages].firstObject;
          //如果当前系统语言与lproj文件不对应，则进行手动适配
          if (![lproj containsObject:language]) {
              if ([language hasPrefix:@"en"]) {
                  language = @"en";
              } else if ([language hasPrefix:@"zh"]) {
                  if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                      language = @"zh-Hans"; // 简体中文
                  } else { // zh-Hant\zh-HK\zh-TW
                      language = @"zh-Hant"; // 繁體中文
                  }
              } else if ([language hasPrefix:@"ko"]) {
                  language = @"ko";
              } else if ([language hasPrefix:@"ru"]) {
                  language = @"ru";
              } else if ([language hasPrefix:@"uk"]) {
                  language = @"uk";
              } else if ([language hasPrefix:@"ja"]) {
                  language = @"ja";
              } else {
                  language = @"zh-Hans";
              }
          }
          bundle = [NSBundle bundleWithPath:[[self TKPermissionBundle] pathForResource:language ofType:@"lproj"]];
      });
    return bundle;
}



#pragma mark alert

/// 包装UIAlertController, 具有两个按钮
/// @param title 标题
/// @param msg 内容
/// @param leftTitle 左边按钮文字
/// @param rightTitle 右边按钮文字
+ (void)alertTitle:(NSString *)title msg:(NSString *)msg leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        UIViewController *tragetVC = [self TK_getCurrentController];
        [tragetVC presentViewController:alert animated:YES completion:nil];
    });
}


/// 包装UIAlertController,只有一个按钮
/// @param title 标题
/// @param msg 内容
/// @param actionTitle 按钮文字
+ (void)alertActionTitle:(NSString *)title msg:(NSString *)msg actionTitle:(NSString *)actionTitle;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];
        UIViewController *tragetVC = [self TK_getCurrentController];
        [tragetVC presentViewController:alert animated:YES completion:nil];
    });
}

/**
 简单弹窗，没有action事件
 */
+ (void)alertTips:(NSString *)msg
{
    [self alertActionTitle:TKPermissionString(@"提示") msg:msg actionTitle:TKPermissionString(@"知道了")];
}

/**
 权限提示alert
 */
+ (void)alertPromptTips:(NSString *)msg
{
    [self alertTitle:TKPermissionString(@"权限提示") msg:msg leftTitle:TKPermissionString(@"设置") rightTitle:TKPermissionString(@"取消")];
}

#pragma mark VC
/**
 获取keyWindow,适配iOS13.0+
 PS:如果需要实现iPad多屏处理，最好是使用SceneDelegate管理Window
 */
+ (UIWindow*)TK_keyWindow
{
    UIWindow *mainWindow = nil;
    if ( @available(iOS 13.0, *) ) {
        //如果是多场景，可以遍历windows,检查window.isKeyWindow获取
        NSArray *windows = UIApplication.sharedApplication.windows;
        for (UIWindow *window in windows) {
            if (window.isKeyWindow) {
                mainWindow = window;
                break;
            }
        }
        if (!mainWindow) {
            mainWindow = windows.firstObject;
        }
    } else {
        mainWindow = UIApplication.sharedApplication.keyWindow;
    }
    return mainWindow;
}

/**
 获取当前显示的视图控制器
 */
+ (UIViewController *)TK_getCurrentController
{
    UIViewController *rootVC = [self TK_keyWindow].rootViewController;
    UIViewController *currentVC = [self TK_getCurrentVCFrom:rootVC];
    return currentVC;
}

+ (UIViewController *)TK_getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    while (rootVC.presentedViewController) {
        rootVC = rootVC.presentedViewController;
    }
    if ([rootVC isKindOfClass:UITabBarController.class]) {
        currentVC = [self TK_getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    }else if ([rootVC isKindOfClass:UINavigationController.class]){
        currentVC = [self TK_getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    }else{
        currentVC = rootVC;
    }
    return currentVC;;
}

@end
