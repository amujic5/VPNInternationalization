//
//  UILabel+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UILabel+Localization.h"
#import "LocalizationManager.h"
#import "NSObject+Localization.h"

static NSString *titleKey = @"KEY";

@implementation UILabel (Localization)

-(NSString *)locTitleKey
{
    return self.loc_keysDictionary[titleKey];
}

-(void)setLocTitleKey:(NSString *)locTitleKey
{
    self.loc_keysDictionary[titleKey] = locTitleKey;
    self.text = local(locTitleKey);
}

-(void)loc_localeDidChanged
{
    self.text = local(self.locTitleKey);
}

@end
