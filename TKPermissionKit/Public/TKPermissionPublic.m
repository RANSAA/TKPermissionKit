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



+ (instancetype)shared
{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[self.class alloc] init];
    });
    return  obj;
}


#pragma mark 国际化处理

/** 直接从bundle文件中读取指定string，而获取国际化字符串*/
+ (NSString *)localizedStringForKey:(NSString *)key tab:(NSString *)tab
{
//    NSString *value = [[self lprojBundle] localizedStringForKey:key value:nil table:tab];
    NSString *value = [[self.shared lprojBundle] localizedStringForKey:key value:nil table:tab];
    return value;
}

/** TKPermissionKit Bundle Path*/
- (NSString *)bundlePath
{
    NSString *path = [[NSBundle bundleForClass:[TKPermissionPublic class]] pathForResource:@"TKPermissionKit" ofType:@"bundle"];
    return  path;
}

/** TKPermissionKit Bundle */
- (NSBundle *)bundle
{
    NSBundle *bundle = [NSBundle bundleWithPath:[self bundlePath]];
    return bundle;
}

/** 配置.lproj文件 */
- (NSString *)selectedLanguage
{
    NSString *selectedLanguage = @"zh-Hans";
    NSString *systemLanguage = [NSLocale preferredLanguages].firstObject.lowercaseString;
    NSString *path = [self bundlePath];
    NSArray *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    subPaths = [subPaths filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject hasSuffix:@".lproj"];
    }]];
    for (NSString *dirName in subPaths) {
        NSString *name = [dirName stringByReplacingOccurrencesOfString:@".lproj" withString:@""];
        NSString *lowerName = [name lowercaseString];
        if ([lowerName containsString:systemLanguage] || [systemLanguage containsString:lowerName]) {
            selectedLanguage = name;
            break;
        }
    }
    for (NSString *dirName in subPaths) {
        NSString *name = [dirName stringByReplacingOccurrencesOfString:@".lproj" withString:@""];
        NSString *lowerName = [name lowercaseString];
        if ([lowerName isEqualToString:systemLanguage]) {
            selectedLanguage = name;
            break;
        }
    }    
    return selectedLanguage;
}

//MARK: 获取当前语言lproj文件对应的bundle 方式一
- (NSBundle *)lprojBundle
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[self bundle] pathForResource:[self selectedLanguage] ofType:@"lproj"]];
    return bundle;
}




//MARK: 获取当前语言lproj文件对应的bundle 方式二
+ (NSBundle *)TKPermissionBundle
{
    //这种方式获取NSBundle不会因为二进制文件，bundle文件是否处于framework中而受到影响
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[TKPermissionPublic class]] pathForResource:@"TKPermissionKit" ofType:@"bundle"]];
    return bundle;
}

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
              } else if ([language hasPrefix:@"ko"]) {//韩语
                  language = @"ko";
              } else if ([language hasPrefix:@"ru"]) {//俄语
                  language = @"ru";
              } else if ([language hasPrefix:@"uk"]) {//乌克兰
                  language = @"uk";
              } else if ([language hasPrefix:@"ja"]) {//日语
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
        if (TKPermissionPublic.shared.blockCustomMsg) {
            TKPermissionPublic.shared.blockCustomMsg(title, msg, leftTitle, rightTitle);
            return;;
        }
        
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
        if (TKPermissionPublic.shared.blockCustomMsg) {
            TKPermissionPublic.shared.blockCustomMsg(title, msg, actionTitle, nil);
            return;;
        }
        
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
    if (@available(iOS 13.0, *)) {
//        for (UIWindow *window in UIApplication.sharedApplication.windows) {
//            if (window.isKeyWindow) {
//                return window;
//            }
//        }
        for (UIWindowScene *windowScene in UIApplication.sharedApplication.connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        return window;
                    }
                }
            }
        }
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        mainWindow = UIApplication.sharedApplication.keyWindow;
#pragma clang diagnostic pop
    }
    if (!mainWindow) {
        mainWindow = UIApplication.sharedApplication.windows.firstObject;
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
