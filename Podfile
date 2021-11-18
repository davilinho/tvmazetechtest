platform :ios, '13.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'tvmazetechtest' do
  use_frameworks!

  pod 'Alamofire', '5.4.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'
  pod 'SDWebImage'
  pod 'lottie-ios'

  target 'tvmazetechtestTests' do
    inherit! :search_paths

    pod 'Nimble', '9.2.1'
    pod 'SnapshotTesting', '~> 1.8.1'
  end

  target 'tvmazetechtestUITests' do
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['VALID_ARCHS'] = 'arm64 arm64e armv7 armv7s x86_64'
      config.build_settings['CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER'] = 'NO'
    end
  end
end
