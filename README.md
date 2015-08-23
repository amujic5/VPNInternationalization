# VPInternationalization

[![CI Status](http://img.shields.io/travis/Vlaho/VPInternationalization.svg?style=flat)](https://travis-ci.org/Vlaho/VPInternationalization)
[![Version](https://img.shields.io/cocoapods/v/VPInternationalization.svg?style=flat)](http://cocoadocs.org/docsets/VPInternationalization)
[![License](https://img.shields.io/cocoapods/l/VPInternationalization.svg?style=flat)](http://cocoadocs.org/docsets/VPInternationalization)
[![Platform](https://img.shields.io/cocoapods/p/VPInternationalization.svg?style=flat)](http://cocoadocs.org/docsets/VPInternationalization)

## Installation

VPInternationalization is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following source to your Podfile:

```ruby
source 'https://bitbucket.org/infinum_hr/cocoapods.git'
pod "VPInternationalization"
```

To work with other pods also add:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
```
## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Add:
```objC
#import <VPInternationalization/VPInternationalization.h>
```

Set language, default language, ...:
```objC
[LocalizationManager sharedManager].language = @"en";
[LocalizationManager sharedManager].defoultLanguage = @"en";// defoult == @"en"
[LocalizationManager sharedManager].preferePhoneLanguage = YES;// defoult == NO
```

Few handy macros:

```objC
NSString *currnetLocale = locCurent;
NSString *transaltion = local(@"key");
NSString *formatedTransation = localFormat(@"key",@"John");
```

Handling language change:
Add ```[self loc_subscribeForLocaleDidChange] ``` to ```viewDidLoad ```
Then just implement:
```objC
-(void)loc_localeDidChanged;
```
No need for unsubscribing, that is done for you.

### Where fun really starts

```objC
[someLabel setLocTitleKey:@"key"];
```
Now title and language change is all done for you.

Supported elements:
```UILabel ```
```UIButton ```
```UITextFiled ```
```UITextView ```
```UIViewController ```

**And the most important thing all of those are supported in ```Storyboards ``` as ```@IBInspectable ```.**

## Requirements

```
iOS7, ARC
```

## Not supported 

```
Attributed strings
```
Sy :(

## Author

Vlaho, vlaho.poluta@infinum.hr

## License

VPInternationalization is available under the MIT license. See the LICENSE file for more info.