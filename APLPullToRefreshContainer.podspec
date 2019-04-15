Pod::Spec.new do |s|
  s.name         = "APLPullToRefreshContainer"
  s.version      = "1.0.0"
  s.summary      = "Pull To Refresh Control"

  s.description  = <<-DESC
		This is a Pull to Refresh Control where you can embed arbitrary scrollable UIViewControllers.
                   DESC

  s.homepage     = "https://bitbucket.org/lb-lab/aplpulltorefreshcontainer"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author       = 'Nico Schuemann'

  s.platform     = :ios, '10.0'

  s.source       = { :git => "git@bitbucket.org:lb-lab/aplpulltorefreshcontainer.git", :tag => s.version.to_s }

  s.source_files  = 'APLPullToRefreshContainer', 'APLPullToRefreshContainer/**/*.{h,m}'
  s.exclude_files = 'APLPullToRefreshContainer/Exclude'

  s.requires_arc = true

end
