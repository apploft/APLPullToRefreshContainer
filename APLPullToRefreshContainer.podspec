Pod::Spec.new do |s|
  s.name         = "APLPullToRefreshContainer"
  s.version      = "0.0.1"
  s.summary      = "Pull"

  s.description  = <<-DESC
                   Pull to refresh control
                   DESC

  s.homepage     = "https://bitbucket.org/lb-lab/aplpulltorefreshcontainer"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author       = 'Nico Schümann'

  s.platform     = :ios, '8.0'

  s.source       = { :git => "git@bitbucket.org:lb-lab/aplpulltorefreshcontainer.git", :tag => s.version.to_s }

  s.source_files  = 'APLPullToRefreshContainer', 'APLPullToRefreshContainer/**/*.{h,m}'
  s.exclude_files = 'APLPullToRefreshContainer/Exclude'

  s.requires_arc = true

end
