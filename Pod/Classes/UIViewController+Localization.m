//
//  UIViewController+Localization.m
//  Pods
//
//  Created by Vlaho Poluta on 8/23/15.
//
//

#import "UIViewController+Localization.h"
#import "LocalizationManager.h"
#import "NSObject+Localization.h"

static NSString *titleKey = @"KEY";

@implementation UIViewController (Localization)

-(NSString *)locTitleKey
{
    return self.loc_keysDictionary[titleKey];
}

-(void)setLocTitleKey:(NSString *)locTitleKey
{
    self.loc_keysDictionary[titleKey] = locTitleKey;
    self.title = local(locTitleKey);
}

-(void)loc_localeDidChanged
{
    self.title = local(self.locTitleKey);
}

@end
