Pod::Spec.new do |s|
  s.name = 'UITabBarItem-GIHTabBarItem'
  s.version = '0.0.1'
  s.ios.deployment_target = '6.0'
  s.license = { :type => "Apache-2.0", :file => "LICENSE" }
  s.summary = 'Perferment UITabBarItem badge a little dot'
  s.homepage = 'https://github.com/gaizhi'
  s.author = { 'Xu Qiang' => '994059781@qq.com' }
  s.source = { :git => 'https://github.com/gaizhi/UITabBarItem-GIHTabBarItem.git', :tag => s.version.to_s }

  s.description = 'Perferment UITabBarItem badge a little dot!'

  s.requires_arc = true

  s.frameworks = [
    'UIKit'
  ]

  s.dependency 'NSObject-GIHObject', '~> 0.0.1'

  s.source_files = 'UITabBarItem/*.{h,m}'
  s.public_header_files = 'UITabBarItem/*.h'

end
