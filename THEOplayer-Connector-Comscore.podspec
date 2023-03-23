Pod::Spec.new do |s|
  s.name             = 'THEOplayer-Connector-Comscore'
  s.module_name      = 'THEOplayerConnectorComscore'
  s.version          = '0.1.0'
  s.summary          = 'Integration between the THEOplayerSDK and ComScore'

  s.description      = 'This pod gives you access to classes that let you report playback events from a THEOplayer instance to Comscore'

  s.homepage         = 'https://github.com/THEOplayer/iOS-Connector'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "THEO technologies"
  s.source           = { :git => 'https://github.com/THEOplayer/iOS-Connector.git', :tag => s.version.to_s }

  s.platforms    = { :ios => "12.0", :tvos => "12.0" }

  s.source_files = 'Code/Comscore/Source/**/*'
      
  s.static_framework = true
  s.swift_versions = ['5.3', '5.4', '5.5', '5.6', '5.7']
  s.dependency 'ComScore', '~> 6.7.1'
  s.dependency 'THEOplayerSDK-basic'
end
