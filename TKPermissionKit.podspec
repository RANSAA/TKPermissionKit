#
#  Be sure to run `pod spec lint TKPermissionKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#


name = "TKPermissionKit"
file_source     = "*.{h,m}"
file_header     = "*.h"
public_source     = "TKPermissionKit/Public/TKPermissionPublic.{h,m}"
public_header     = "TKPermissionKit/Public/TKPermissionPublic.h"


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

  # spec.platform     = :ios
  spec.platform     = :ios, "8.0"					#支持版本

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # spec.source_files  		= public_source,"#{name}/*.*","#{name}/**/*.*"	#源文件路径相关
  # spec.public_header_files = public_header,"#{name}/*.h","#{name}/**/*.h"

  spec.source_files         = "#{name}/*.*","#{name}/**/*.*"  #源文件路径相关
  spec.public_header_files  = "#{name}/*.h","#{name}/**/*.h"
  spec.frameworks = "Foundation", "UIKit" ,"Photos", "AVFoundation", "MediaPlayer", "CoreBluetooth", "CoreLocation", "UserNotifications", "Speech", "Contacts", "EventKit", "CoreTelephony", "CoreMotion", "HomeKit", "HealthKit" , "AddressBook"                       #引入的系统框架

  


  #分支 
  spec.subspec 'Photo' do |ss|
    ss.source_files         = "#{name}/Photo/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Photo/#{file_header}",public_header
    ss.ios.frameworks       = "Photos"
  end

 
  spec.subspec 'Camera' do |ss|
    ss.source_files         = "#{name}/Camera/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Camera/#{file_header}",public_header
    ss.ios.frameworks       = "AVFoundation"
  end


  spec.subspec 'Media' do |ss|
    ss.source_files         = "#{name}/Media/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Media/#{file_header}",public_header
    ss.ios.frameworks       = "MediaPlayer"
  end


  spec.subspec 'Bluetooth' do |ss|
    ss.source_files         = "#{name}/Bluetooth/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Bluetooth/#{file_header}",public_header
    ss.ios.frameworks       = "CoreBluetooth"
  end


  spec.subspec 'Microphone' do |ss|
    ss.source_files         = "#{name}/Microphone/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Microphone/#{file_header}",public_header
    ss.ios.frameworks       = "AVFoundation"
  end


  spec.subspec 'LocationWhen' do |ss|
    ss.source_files         = "#{name}/LocationWhen/#{file_source}",public_source
    ss.public_header_files  = "#{name}/LocationWhen/#{file_header}",public_header
    ss.ios.frameworks       = "CoreLocation"
  end


  spec.subspec 'LocationAlways' do |ss|
    ss.source_files         = "#{name}/LocationAlways/#{file_source}",public_source
    ss.public_header_files  = "#{name}/LocationAlways/#{file_header}",public_header
    ss.ios.frameworks       = "CoreLocation"
  end


  spec.subspec 'Notification' do |ss|
    ss.source_files         = "#{name}/Notification/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Notification/#{file_header}",public_header
    ss.ios.frameworks       = "UserNotifications"
  end



  spec.subspec 'Speech' do |ss|
    ss.source_files         = "#{name}/Speech/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Speech/#{file_header}",public_header
    ss.ios.frameworks       = "Speech"
  end


  spec.subspec 'Contacts' do |ss|
    ss.source_files         = "#{name}/Contacts/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Contacts/#{file_header}",public_header
    ss.ios.frameworks       = "Contacts","AddressBook"
  end


  spec.subspec 'Calendar' do |ss|
    ss.source_files         = "#{name}/Calendar/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Calendar/#{file_header}",public_header
    ss.ios.frameworks       = "EventKit"
  end


  spec.subspec 'Reminder' do |ss|
    ss.source_files         = "#{name}/Reminder/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Reminder/#{file_header}",public_header
    ss.ios.frameworks       = "EventKit"
  end

  spec.subspec 'NetWork' do |ss|
    ss.source_files         = "#{name}/NetWork/#{file_source}",public_source
    ss.public_header_files  = "#{name}/NetWork/#{file_header}",public_header
    ss.ios.frameworks       = "CoreTelephony"
  end

  spec.subspec 'Motion' do |ss|
    ss.source_files         = "#{name}/Motion/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Motion/#{file_header}",public_header
    ss.ios.frameworks       = "CoreMotion"
  end

  spec.subspec 'Home' do |ss|
    ss.source_files         = "#{name}/Home/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Home/#{file_header}",public_header
    ss.ios.frameworks       = "HomeKit"
  end

  spec.subspec 'Health' do |ss|
    ss.source_files         = "#{name}/Health/#{file_source}",public_source
    ss.public_header_files  = "#{name}/Health/#{file_header}",public_header
    ss.ios.frameworks       = "HealthKit"
  end



end
