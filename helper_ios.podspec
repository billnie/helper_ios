
Pod::Spec.new do |s|


  s.name         = "helper_ios"
  s.version      = "0.0.1"
  s.summary      = "some of ios usefull function  helper_ios."

  s.description  = <<-DESC
                   A longer description of helper_ios in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/billnie/helper_ios"

    s.license          = 'MIT'

  s.author             = { "billnie" => "706919534@qq.com" }
  # Or just: s.author    = "billnie"
  # s.authors            = { "billnie" => "706919534@qq.com" }
  # s.social_media_url   = "http://twitter.com/billnie"

 s.ios.deployment_target = "8.0"


  s.source       = { :git => "https://github.com/billnie/helper_ios.git", :tag => "0.0.1" }
    s.dependency = 'ios_boost', :git => 'https://github.com/billnie/ios_boost.git'

  s.public_header_files = 'helper_ios/helper_ios/*.h'
  s.source_files  = "helper_ios", "helper_ios/helper_ios/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

    s.resource_bundles = {
    'helper_ios' => ['helper_ios/helper_ios/**/*.{storyboard,xib,xcassets,json,imageset,png}']
    }

s.subspec 'ALBatteryView' do |ss|
    ss.source_files = 'helper_ios/helper_ios/ALBatteryView/**/*.{h,m}'
    ss.public_header_files = 'helper_ios/helper_ios/ALBatteryView/**/*'
end

s.subspec 'ASValueTrackingSlider' do |ss|
    ss.source_files = 'helper_ios/helper_ios/ASValueTrackingSlider/**/*.{h,m}'
    ss.public_header_files = 'helper_ios/helper_ios/ASValueTrackingSlider/**/*'
end

s.subspec 'DHLayout' do |ss|
    ss.source_files = 'helper_ios/helper_ios/DHLayout/**/*.{h,m}'
    ss.public_header_files = 'helper_ios/helper_ios/DHLayout/**/*'
end




end
