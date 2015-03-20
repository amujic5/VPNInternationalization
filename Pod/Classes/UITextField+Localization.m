//
//  UITextField+Localization.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "UITextField+Localization.h"
#import "LocalizationManager.h"

@implementation UITextField (Localization)

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    if ([LocalizationManager shouldLocalizeForStoryboardString:self.text]) {
        [self configureStoryboardLocalizationForText];
    } else {
        self.text = [LocalizationManager stringWithRemovedSkipingPrefixFromString:self.text];
    }
    if ([LocalizationManager shouldLocalizeForStoryboardString:self.placeholder]) {
        [self configureStoryboardLocalizationForPlacehoder];
    } else {
        self.placeholder = [LocalizationManager stringWithRemovedSkipingPrefixFromString:self.placeholder];
    }
}

-(void)configureStoryboardLocalizationForText
{
    NSString *key = [LocalizationManager localizationKeyFromStoryboardString:self.text];
    [[LocalizationManager sharedManager] setLocalizationKey:key forUIElement:self.description state:@"t"];
    self.text = local(key);
}

-(void)configureStoryboardLocalizationForPlacehoder
{
    NSString *key = [LocalizationManager localizationKeyFromStoryboardString:self.placeholder];
    [[LocalizationManager sharedManager] setLocalizationKey:key forUIElement:self.description state:@"p"];
    self.text = local(key);
}

-(void)setLocalizedTextForKey:(NSString *)localizationKey
{
    [[LocalizationManager sharedManager] setLocalizationKey:localizationKey forUIElement:self.description state:@"t"] ;
    [self subscribeForLanguageChange];
    self.text = local(localizationKey);
}

-(void)setLocalizedPlaceholderForKey:(NSString *)localizationKey
{
    [[LocalizationManager sharedManager] setLocalizationKey:localizationKey forUIElement:self.description state:@"p"];
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
    NSString *textKey = [[LocalizationManager sharedManager] localizationKeyForUIElement:self.description state:@"t"];
    NSString *placeholderKey = [[LocalizationManager sharedManager] localizationKeyForUIElement:self.description state:@"p"];
    if (textKey) {
        self.text = local(textKey);
    }
    if (placeholderKey) {
        self.placeholder = local(placeholderKey);
    }
}

-(void)dealloc
{
    [[LocalizationManager sharedManager] removeLocalizationKeyForUIElement:self.description state:@"t"];
    [[LocalizationManager sharedManager] removeLocalizationKeyForUIElement:self.description state:@"p"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
}

@end
