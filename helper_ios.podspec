
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


   s.license      = {:type => 'helper_ios', :text => <<-TXT
                  This software is provided 'as-is', without any express or implied
                  warranty. In no event will the authors be held liable for any damages
                  arising from the use of this software. Permission is granted to anyone to
                  use this software for any purpose, including commercial applications, and to
                  alter it and redistribute it freely, subject to the following restrictions:
                  1. The origin of this software must not be misrepresented; you must not
                     claim that you wrote the original software. If you use this software
                     in a product, an acknowledgment in the product documentation would be
                     appreciated but is not required.
                  2. Altered source versions must be plainly marked as such, and must not be
                     misrepresented as being the original software.
                  3. This notice may not be removed or altered from any source
                     distribution.
                TXT
               }


  s.author             = { "billnie" => "706919534@qq.com" }
  # Or just: s.author    = "billnie"
  # s.authors            = { "billnie" => "706919534@qq.com" }
  # s.social_media_url   = "http://twitter.com/billnie"


  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/billnie/helper_ios.git", :tag => "0.0.1" }



  s.source_files  = "helper_ios", "helper_ios/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "helper_ios/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"





end
