#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'cinema_darwin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }

  s.ios.source_files = ['cinema_darwin/Sources/cinema_ios/*', 'cinema_darwin/Sources/cinema_darwin_bindings/*', 'cinema_darwin/Sources/cinema_darwin/*']
  s.osx.source_files = ['cinema_darwin/Sources/cinema_macos/*', 'cinema_darwin/Sources/cinema_darwin_bindings/*', 'cinema_darwin/Sources/cinema_darwin/*']
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'

  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
