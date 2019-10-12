#
#  Be sure to run `pod spec lint TKPermissionKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#


name = "TKPermissionKit"
public_source_files  	= "TKPermissionKit/TKPermissionPublic.{h,m}"
public_header_files     = "TKPermissionKit/TKPermissionPublic.h"


Pod::Spec.new do |spec|

  spec.name         = "TKPermissionKit"		#框架名称
  spec.version      = "1.0"					#版本
  spec.summary      = "权限管理工具"          #简短的描述
  spec.description  = <<-DESC
  					需要什么，就导入什么模块，最好不要全部模块都导入！
                   DESC
  spec.homepage     = "https://github.com/RANSAA/TKPermissionKit"		#github项目首页
  spec.license      = "MIT"			#开源协议方式
  spec.author             = { "sayaDev" => "1352892108@qq.com" }		#作者
  spec.source       = { :git => "https://github.com/RANSAA/TKPermissionKit.git", :tag => "v#{spec.version}" }	#对应github资源与版本
  spec.requires_arc = true		#支持arc
  spec.frameworks = "Foundation", "UIKit"		#引入的系统框架

  #spec.platform     = :ios
  spec.platform     = :ios, "8.0"					#支持版本

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source_files  		= public_source_files		#源文件路径相关
  spec.public_header_files = public_header_files


   #分支 
  spec.subspec 'Photo' do |ss|
   	ss.ios.deployment_target = "8.0"
    ss.source_files = "TKPermissionKit/Photo/*.{h,m}",public_source_files
    ss.public_header_files = "TKPermissionKit/Photo/*.h",public_header_files
    ss.ios.frameworks = "Photos"
  end




end
