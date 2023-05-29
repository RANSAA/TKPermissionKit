//
//  TKPermissionPhoto.h
//  TKPermissionKitDemo
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKPermissionPublic.h"

/**
 功能：相册权限获取与请求
 要求：iOS8.0+
 注意：iOS14新增相册有效的访问权限


 权限描述:
 NSPhotoLibraryUsageDescription             需要您的同意，才能访问相册   
 NSPhotoLibraryAddUsageDescription          需要您的同意，才能添加照片




  iOS14 中当用户选择
 “PHAuthorizationStatusLimited” 时，如果未进行适配，有可能会在每次触发相册功能时都进行弹窗询问用户是否需要修改照片权限。

  对于这种情况可通过在 Info.plist 中设置
 “PHPhotoLibraryPreventAutomaticLimitedAccessAlert”的值为 YES 来阻止该弹窗反复弹出;
 并且可通过下面这个 API 来主动控制何时弹出PHPickerViewController 进行照片选择:
 :
    [[PHPhotoLibrary sharedPhotoLibrary] presentLimitedLibraryPickerFromViewController:self];


 注意1:
 如果在iOS14即更高的版本依旧使用UIImagePickerController(未适配)，请求PHAuthorizationStatusLimited权限，它依旧会响应PHAuthorizationStatusAuthorized。
 
 
 注意2：
 在iOS14中直接使用PHPicker访问相册是不需要请求权限的，因为PHPicker是独立的进程，在默认情况下它有内置的隐私，
 1. 不需要直接访问用户相册
 2. 不会提示访问相册
 3. 仅为用户提供可选择的照片和视频
 
 **/


NS_ASSUME_NONNULL_BEGIN

@interface TKPermissionPhoto : NSObject


//相册访问限制权限等级 -> iOS14+才有实际意义
typedef NS_ENUM(NSInteger, TKPhotoAccessLevel){
    TKPhotoAccessLevelReadWrite = 0,    //获取全部的相册读写权限   -> PHAccessLevelReadWrite
    TKPhotoAccessLevelOnlyAdd           //只获取向相册中添加权限   -> PHAccessLevelAddOnly
};


/**
 请求相册权限
 isAlert: 请求权限时，用户拒绝授予权限时。是否弹出alert进行手动设置权限 YES:弹出alert
 level:   相册访问权限,限制类型:只读/读写（iOS14+才有效）
 isAuth:  回调，用户是否申请权限成功！
 PS:获取相册的读写权限/只添加权限由level决定
 **/
+ (void)authWithAlert:(BOOL)isAlert level:(TKPhotoAccessLevel)level completion:(void(^)(BOOL isAuth))completion ;


/**
 查询是否获取了相册权限
 */
+ (BOOL)checkAuthWith:(TKPhotoAccessLevel)level;



@end

NS_ASSUME_NONNULL_END
