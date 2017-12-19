 platform :ios, '9.0'

target 'BrowserVK' do
  
  use_frameworks!

  pod 'SDWebImage', '~> 4.0'
  pod 'SwiftyVK', '2.0.14'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'Swinject', '~> 2.1.0'

  target 'BrowserVKTests' do
    inherit! :search_paths
    # Pods for testing
  end

	post_install do |installer|
    	installer.pods_project.targets.each do |target|
        	target.build_configurations.each do |config|
            	config.build_settings['SWIFT_VERSION'] = '3.0'
        	end
    	end
	end

end
