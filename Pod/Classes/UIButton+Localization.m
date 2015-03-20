//
//  UIButton+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UIButton+Localization.h"
#import "LocalizationManager.h"

@implementation UIButton (Localization)

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self testAndConfigureStoryboardLocalizationForState:UIControlStateNormal];
    [self testAndConfigureStoryboardLocalizationForState:UIControlStateHighlighted];
    [self testAndConfigureStoryboardLocalizationForState:UIControlStateDisabled];
    [self testAndConfigureStoryboardLocalizationForState:UIControlStateSelected];
}

-(void)testAndConfigureStoryboardLocalizationForState:(UIControlState)state
{
    if ([LocalizationManager shouldLocalizeForStoryboardString:[self titleForState:state]]) {
        [self configureStoryboardLocalizationForState:state];
    } else {
        [self setTitle:[LocalizationManager stringWithRemovedSkipingPrefixFromString:[self titleForState:state]] forState:state];
    }
}

-(void)configureStoryboardLocalizationForState:(UIControlState)state
{
    NSString *key = [LocalizationManager localizationKeyFromStoryboardString:[self titleForState:state]];
    [[LocalizationManager sharedManager] setLocalizationKey:key forUIElement:self.description state:@(state)];
    [self subscribeForLanguageChange];
    [self setTitle:local(key) forState:state];
}

-(void)setLocalizedTitleForKey:(NSString *)localizationKey forState:(UIControlState)state
{
    [[LocalizationManager sharedManager] setLocalizationKey:localizationKey forUIElement:self.description state:@(state)];
    [self subscribeForLanguageChange];
    [self setTitle:local(localizationKey) forState:state];
}

-(void)setLocalizedTitleForKey:(NSString *)localizationKey
{
    [self setLocalizedTitleForKey:localizationKey forState:UIControlStateNormal];
    [self setLocalizedTitleForKey:localizationKey forState:UIControlStateHighlighted];
    [self setLocalizedTitleForKey:localizationKey forState:UIControlStateDisabled];
    [self setLocalizedTitleForKey:localizationKey forState:UIControlStateSelected];
}

-(void)subscribeForLanguageChange
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LocalizationManagerLanguageDidChangeNotification object:nil];
}

-(void)languageChanged
{
    [self testHasKeyAndSetLocalizedStringForState:UIControlStateNormal];
    [self testHasKeyAndSetLocalizedStringForState:UIControlStateHighlighted];
    [self testHasKeyAndSetLocalizedStringForState:UIControlStateDisabled];
    [self testHasKeyAndSetLocalizedStringForState:UIControlStateSelected];
}

-(void)testHasKeyAndSetLocalizedStringForState:(UIControlState)state
{
    NSString *key = [[LocalizationManager sharedManager] localizationKeyForUIElement:self.description state:@(state)];
    if (key) {
        [self setTitle:local(key) forState:state];
    }
}

-(void)dealloc
{
    [self removeKeyForState:UIControlStateNormal];
    [self removeKeyForState:UIControlStateHighlighted];
    [self removeKeyForState:UIControlStateDisabled];
    [self removeKeyForState:UIControlStateSelected];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
}

-(void)removeKeyForState:(UIControlState)state
{
    [[LocalizationManager sharedManager] removeLocalizationKeyForUIElement:self.description state:@(state)];
}

@end
