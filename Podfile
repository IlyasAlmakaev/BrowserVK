 platform :ios, '9.0'

target 'BrowserVK' do
  
  use_frameworks!

  pod 'Kingfisher', '~> 3.13.1'
  pod 'SwiftyVK',   '2.0.14'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'Swinject',   '~> 2.1.0'
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'
  pod 'Toast-Swift', '~> 2.0.0'

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
