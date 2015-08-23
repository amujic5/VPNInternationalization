//
//  UITextField+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UITextField+Localization.h"
#import "LocalizationManager.h"
#import "NSObject+Localization.h"

static NSString *titleKey = @"KEY";
static NSString *placeholderKey = @"PKEY";

@implementation UITextField (Localization)

-(NSString *)locTextKey
{
    return self.loc_keysDictionary[titleKey];
}

-(NSString *)locPlaceholderKey
{
    return self.loc_keysDictionary[placeholderKey];
}

-(void)setLocTextKey:(NSString *)locTextKey
{
    self.loc_keysDictionary[titleKey] = locTextKey;
    self.text = local(locTextKey);
}

-(void)setLocPlaceholderKey:(NSString *)locPlaceholderKey
{
    self.loc_keysDictionary[placeholderKey] = locPlaceholderKey;
    self.placeholder = local(locPlaceholderKey);
}

-(void)loc_localeDidChanged
{
    if (self.locTextKey) {
        self.text = local(self.locTextKey);
    }
    if (self.locPlaceholderKey) {
        self.placeholder = local(self.locPlaceholderKey);
    }
}

@end
