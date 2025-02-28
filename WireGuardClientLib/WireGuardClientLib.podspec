Pod::Spec.new do |s|
    s.name             = 'WireGuardClientLib'
    s.version          = '0.1.0'
    s.summary          = 'Библиотека для интеграции WireGuard VPN в iOS-приложения.'
  
    s.homepage         = 'https://github.com/your-repo-link/WireGuardClientLib'
    s.license          = 'MIT'
    s.author           = { 'Yasin' => 'yasin@ie.uz' }
    s.platform         = :ios, '15.0'
  
    s.source           = { :git => 'https://github.com/Yasin9494/WireGuardClientLib.git', :tag => s.version }
  
    s.source_files     = 'Sources/WireGuardClientLib/**/*.swift'
    
    s.dependency 'WireGuardKit'
    
    s.swift_version    = '5.9'
  end
  