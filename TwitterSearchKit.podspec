Pod::Spec.new do |s|
  s.name = 'TwitterSearchKit'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A demo framework for fetching tweets from the Twitter API'
  s.homepage = 'http://www.github.com'
  s.authors = { 'Julian Gruber' => 'juliangruber7@gmail.com' }
  s.source = { :git => 'https://github.com/juxs/TwitterSearchKit.git', :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'TwitterSearchKit/*.swift'
end
