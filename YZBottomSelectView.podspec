Pod::Spec.new do |s|
    s.name         = 'YZBottomSelectView'
    s.version      = '1.0.0'
    s.summary      = 'Bottom pop-up choose view.'
    s.homepage     = 'https://github.com/micyo202/YZBottomSelectView'
    s.license      = 'MIT'
    s.authors      = {'Yanzheng' => 'micyo202@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/micyo202/YZBottomSelectView.git', :tag => s.version}
    s.source_files = 'YZBottomSelectView/Plugins/*.{h,m}'
    s.requires_arc = true
end