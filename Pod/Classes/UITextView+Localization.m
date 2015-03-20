//
//  UITextView+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UITextView+Localization.h"
#import "LocalizationManager.h"

@implementation UITextView (Localization)

-(void)awakeFromNib
{
    [super awakeFromNib];
    if ([LocalizationManager shouldLocalizeForStoryboardString:self.text]) {
        [self configureStoryboardLocalization];
    } else {
        self.text = [LocalizationManager stringWithRemovedSkipingPrefixFromString:self.text];
    }
}

-(void)configureStoryboardLocalization
{
    NSString *key = [LocalizationManager localizationKeyFromStoryboardString:self.text];
    [[LocalizationManager sharedManager] setLocalizationKey:key forUIElement:self.description state:nil];
    [self subscribeForLanguageChange];
    self.text = local(key);
}

-(void)setLocalizedTextForKey:(NSString *)localizationKey
{
    [[LocalizationManager sharedManager] setLocalizationKey:localizationKey forUIElement:self.description state:nil];
    [self subscribeForLanguageChange];
    self.text = local(localizationKey);
}

-(void)subscribeForLanguageChange
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LocalizationManagerLanguageDidChangeNotification object:nil];
}

-(void)languageChanged
{
    self.text = local([[LocalizationManager sharedManager] localizationKeyForUIElement:self.description state:nil]);
}

-(void)dealloc
{
    [[LocalizationManager sharedManager] removeLocalizationKeyForUIElement:self.description state:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
}


@end
