#
# Be sure to run `pod lib lint VPInternationalization.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "VPInternationalization"
  s.version          = "0.2.0"
  s.summary          = "Internationalization framework for iOS"
  s.description      = <<-DESC
                       To be used with polyglot.
                       Quick way to add transaltion keys to polyglot.
                       DESC
  s.homepage         = "https://bitbucket.org/infinum_hr/ios-vpinternationalization"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Vlaho" => "vlaho.poluta@infinum.hr" }
  s.source           = { :git => "git@bitbucket.org:infinum_hr/ios-vpinternationalization.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'VPInternationalization' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
