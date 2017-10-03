#
#  Be sure to run `pod spec lint Utils.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    
    s.name         = "Utils"
    s.version      = "1.0.4"
    s.summary      = "Utilities."
    s.description  = "Many utilities i use a lot"
    s.homepage     = "https://github.com/machukas/Utils"
    s.license      = "MIT"
    s.author       = { "Nico Landa" => "machukkas@gmail.com" }
    
    
    s.platform     = :ios
    s.ios.deployment_target = '9.0'
    
    s.source       = { :git => 'https://github.com/machukas/Utils.git' }
    
    s.source_files  = "Utils/**/*.{h,m,swift}"
    
    s.resource_bundles = {
        'Utils' => ['Utils/**/*.{storyboard,xib}']
    }
    
end
