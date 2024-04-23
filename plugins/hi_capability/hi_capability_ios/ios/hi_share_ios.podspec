Pod::Spec.new do |s|
  s.name             = 'hi_share_ios'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for native share.'
  s.description      = <<-DESC
A Flutter plugin for making the underlying platform (Android or iOS) native share.
                       DESC
  s.homepage         = 'https://github.com/tospery/flutter/tree/main/plugins/hi_share'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Yang Jianxiang' => 'tospery@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
