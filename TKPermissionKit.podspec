#
#  Be sure to run `pod spec lint TKPermissionKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

name      = "TKPermissionKit"
version   = "1.2.7"
homepage  = "https://github.com/RANSAA/TKPermissionKit"


file_source       = "*.{h,m,bundle}"
file_header       = "*.h"
public_source     = "TKPermissionKit/Public/TKPermissionPublic.{h,m}"
public_header     = "TKPermissionKit/Public/TKPermissionPublic.h"
public_base       = "TKPermissionKit/Public"



Pod::Spec.new do |spec|

spec.name         = "#{name}"   
spec.summary      = 'iOS权限管理工具'
spec.homepage     = "#{homepage}"
spec.version      = "#{version}"
spec.source       = { :git => "#{homepage}.git", :tag => "v#{spec.version}" } #对应github资源与版本
spec.license      = "MIT"     #开源协议方式
spec.author       = { "sayaDev" => "1352892108@qq.com" }    #作者
spec.requires_arc = true    #支持arc
spec.platform     = :ios, '9.0'


spec.source_files         = "#{name}/TKPermissionKit.h"
spec.public_header_files  = "#{name}/TKPermissionKit.h"



spec.subspec 'Public' do |ss|
  ss.source_files         = public_source
  ss.public_header_files  = public_header
  # ss.resources            = "#{name}/Public/*.bundle"
  ss.resource_bundles = {
      spec.name => ["#{name}/Public/*.bundle/*", "#{name}/Public/PrivacyInfo.xcprivacy"]
  }
  ss.ios.frameworks       = "Foundation", "UIKit"
end

spec.subspec 'Photo' do |ss|
  ss.source_files         = "#{name}/Photo/#{file_source}"
  ss.public_header_files  = "#{name}/Photo/#{file_header}"
  ss.ios.frameworks       = "Photos"
  ss.dependency "#{public_base}"    #依赖
end

spec.subspec 'Camera' do |ss|
  ss.source_files         = "#{name}/Camera/#{file_source}"
  ss.public_header_files  = "#{name}/Camera/#{file_header}"
  ss.ios.frameworks       = "AVFoundation"
  ss.dependency "#{public_base}"
end

spec.subspec 'Media' do |ss|
  ss.source_files         = "#{name}/Media/#{file_source}"
  ss.public_header_files  = "#{name}/Media/#{file_header}"
  ss.ios.frameworks       = "MediaPlayer"
  ss.dependency "#{public_base}"
end

spec.subspec 'Bluetooth' do |ss|
  ss.source_files         = "#{name}/Bluetooth/#{file_source}"
  ss.public_header_files  = "#{name}/Bluetooth/#{file_header}"
  ss.ios.frameworks       = "CoreBluetooth"
  ss.dependency "#{public_base}"
end

spec.subspec 'Microphone' do |ss|
  ss.source_files         = "#{name}/Microphone/#{file_source}"
  ss.public_header_files  = "#{name}/Microphone/#{file_header}"
  ss.ios.frameworks       = "AVFoundation"
  ss.dependency "#{public_base}"
end

spec.subspec 'LocationWhen' do |ss|
  ss.source_files         = "#{name}/LocationWhen/#{file_source}"
  ss.public_header_files  = "#{name}/LocationWhen/#{file_header}"
  ss.ios.frameworks       = "CoreLocation"
  ss.dependency "#{public_base}"
end

spec.subspec 'LocationAlways' do |ss|
  ss.source_files         = "#{name}/LocationAlways/#{file_source}"
  ss.public_header_files  = "#{name}/LocationAlways/#{file_header}"
  ss.ios.frameworks       = "CoreLocation"
  ss.dependency "#{public_base}"
end

spec.subspec 'Notification' do |ss|
  ss.source_files         = "#{name}/Notification/#{file_source}"
  ss.public_header_files  = "#{name}/Notification/#{file_header}"
  ss.ios.frameworks       = "UserNotifications"
  ss.dependency "#{public_base}"
end

spec.subspec 'Speech' do |ss|
  ss.source_files         = "#{name}/Speech/#{file_source}"
  ss.public_header_files  = "#{name}/Speech/#{file_header}"
  ss.ios.frameworks       = "Speech"
  ss.dependency "#{public_base}"
end

spec.subspec 'Contacts' do |ss|
  ss.source_files         = "#{name}/Contacts/#{file_source}"
  ss.public_header_files  = "#{name}/Contacts/#{file_header}"
  # ss.ios.frameworks       = "Contacts","AddressBook"
  ss.ios.frameworks       = "Contacts"
  ss.dependency "#{public_base}"
end

spec.subspec 'Calendar' do |ss|
  ss.source_files         = "#{name}/Calendar/#{file_source}"
  ss.public_header_files  = "#{name}/Calendar/#{file_header}"
  ss.ios.frameworks       = "EventKit"
  ss.dependency "#{public_base}"
end

spec.subspec 'Reminder' do |ss|
  ss.source_files         = "#{name}/Reminder/#{file_source}"
  ss.public_header_files  = "#{name}/Reminder/#{file_header}"
  ss.ios.frameworks       = "EventKit"
  ss.dependency "#{public_base}"
end

spec.subspec 'Network' do |ss|
  ss.source_files         = "#{name}/Network/#{file_source}"
  ss.public_header_files  = "#{name}/Network/#{file_header}"
  ss.ios.frameworks       = "CoreTelephony"
  ss.dependency "#{public_base}"
end

spec.subspec 'Motion' do |ss|
  ss.source_files         = "#{name}/Motion/#{file_source}"
  ss.public_header_files  = "#{name}/Motion/#{file_header}"
  ss.ios.frameworks       = "CoreMotion"
  ss.dependency "#{public_base}"
end

spec.subspec 'Home' do |ss|
  ss.source_files         = "#{name}/Home/#{file_source}"
  ss.public_header_files  = "#{name}/Home/#{file_header}"
  ss.ios.frameworks       = "HomeKit"
  ss.dependency "#{public_base}"
end

spec.subspec 'Health' do |ss|
  ss.source_files         = "#{name}/Health/#{file_source}"
  ss.public_header_files  = "#{name}/Health/#{file_header}"
  ss.ios.frameworks       = "HealthKit"
  ss.dependency "#{public_base}"
end

spec.subspec 'FileAndFolders' do |ss|
  ss.source_files         = "#{name}/FileAndFolders/#{file_source}"
  ss.public_header_files  = "#{name}/FileAndFolders/#{file_header}"
  ss.dependency "#{public_base}"
end

spec.subspec 'Tracking' do |ss|
  ss.source_files         = "#{name}/Tracking/#{file_source}"
  ss.public_header_files  = "#{name}/Tracking/#{file_header}"
  ss.ios.frameworks       = 'AppTrackingTransparency', 'AdSupport'
  ss.dependency "#{public_base}"
end

spec.subspec 'Siri' do |ss|
  ss.source_files         = "#{name}/Siri/#{file_source}"
  ss.public_header_files  = "#{name}/Siri/#{file_header}"
  ss.ios.frameworks       = "Intents"
  ss.dependency "#{public_base}"
end




end
