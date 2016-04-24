Pod::Spec.new do |s|
  s.name         = "Adtrade"

  s.version      = "1.0.0"

  s.summary      = "Adtrade SDK."

  s.description  = "Adtrade is an open-source platform for mobile developers to exchange ads for free. "

  s.homepage     = "https://github.com/adtrade/adtrade-ios-sdk"

  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }

  s.author       = { "williamlocke" => "williamlocke@me.com" }

  s.source       = { :git => "https://github.com/adtrade/adtrade-ios-sdk.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  
  s.dependency 'AdtradeAPI'
  
  s.resources = '{Adtrade.podspec,Resources/Adtrade.bundle}'  

  s.source_files =  'Classes/**/*.[h,m]'
  
  s.frameworks = 'AdSupport', 'QuartzCore', 'StoreKit'

  s.requires_arc = true

end
