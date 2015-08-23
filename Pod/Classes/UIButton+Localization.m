//
//  UIButton+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UIButton+Localization.h"
#import "LocalizationManager.h"
#import "NSObject+Localization.h"

@implementation UIButton (Localization)

-(void)setLocalizedTitleForKey:(NSString *)localizationKey forState:(UIControlState)state
{
    self.loc_keysDictionary[@(state)] = localizationKey;
    [self setTitle:local(localizationKey) forState:state];
}

-(NSString *)localizationKeyForState:(UIControlState)state
{
    return self.loc_keysDictionary[@(state)];
}

-(void)setLocTitleKey:(NSString *)locTitleKey
{
    [self setLocalizedTitleForKey:locTitleKey forState:UIControlStateNormal];
    [self setLocalizedTitleForKey:locTitleKey forState:UIControlStateHighlighted];
    [self setLocalizedTitleForKey:locTitleKey forState:UIControlStateSelected];
    [self setLocalizedTitleForKey:locTitleKey forState:UIControlStateDisabled];
}

-(NSString *)locTitleKey
{
    return self.loc_keysDictionary[@(UIControlStateNormal)];
}

-(void)loc_localeDidChanged
{
    for (NSNumber *stateObject in self.loc_keysDictionary) {
        NSString *localizationKey = self.loc_keysDictionary[stateObject];
        [self setTitle:local(localizationKey) forState:[stateObject integerValue]];
    }
}

@end
