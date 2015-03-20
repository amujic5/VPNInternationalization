//
//  LocalizationManager.m
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import "LocalizationManager.h"

static NSString *AppleLanguages = @"AppleLanguages";
static NSString *LMLanguage = @"LocalizationManagerLanguage";
static NSString *LMLocalizationKeysForUIElements = @"LocalizationManagerLocalizationKeysForUIElements";


@interface LocalizationManager ()

@property (nonatomic, strong) NSMutableDictionary *localizationKeysForUIElements;

@end

@implementation LocalizationManager

#pragma mark - singletion

+ (instancetype)sharedManager {
    static LocalizationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        self.localizationKeysForUIElements = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - language

@synthesize language = _language;

-(void)setLanguage:(NSString *)language
{
    _language = language;
    [[NSNotificationCenter defaultCenter] postNotificationName:LocalizationManagerLanguageDidChangeNotification object:nil userInfo:nil];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:LMLanguage];
    [[NSUserDefaults standardUserDefaults] setObject:@[language] forKey:AppleLanguages];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)language
{
    if (!_language) {
        _language = [[NSUserDefaults standardUserDefaults] objectForKey:LMLanguage];
        if (!_language) {
            //DEFAULT LANGUAGE SET HERE
            //this is same as [[NSLocale preferredLanguages] firstObject];
            _language = [[[NSUserDefaults standardUserDefaults] objectForKey:AppleLanguages] firstObject];
        }
    }
    return _language;
}

#pragma makr - localized string for key

+(NSString *)localizedStringForKey:(NSString *)key
{
    NSString *language = [[LocalizationManager sharedManager] language];
    NSString *string =  NSLocalizedStringFromTable(key, language, nil);
    if (useRollbackLanguage && [string isEqualToString:key]) {
        string = NSLocalizedStringFromTable(key, rollbackLanguage, nil);
    }
    return string;
}

#pragma mark - UI elements key storing & helper

+(BOOL)shouldLocalizeForStoryboardString:(NSString *)string
{
    if (!string || string.length <= 0) {
        return NO;
    }
    if (string.length >= SkipTihsTextPrefix.length) {        
        if ([[string substringToIndex:SkipTihsTextPrefix.length] isEqualToString:SkipTihsTextPrefix]) {
            return NO;
        }
    }
    return YES;
}
+(NSString *)stringWithRemovedSkipingPrefixFromString:(NSString *)string
{
    if (string.length >= SkipTihsTextPrefix.length) {
        if ([[string substringToIndex:SkipTihsTextPrefix.length] isEqualToString:SkipTihsTextPrefix]) {
            return [string substringFromIndex:SkipTihsTextPrefix.length];
        } else {
            return string;
        }
    }
    return string;
}

+(NSString *)localizationKeyFromStoryboardString:(NSString *)string
{
    NSString *key = [[string componentsSeparatedByString:LocalizationKeyToDummyTextDivider] firstObject];
    return [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(void)setLocalizationKey:(NSString *)key forUIElement:(NSString *)element state:(id)state
{
    NSString *address = [element componentsSeparatedByString:@" "][1];
    address = [address stringByAppendingFormat:@"%@",state];
    self.localizationKeysForUIElements[address] = key;
}

-(void)removeLocalizationKeyForUIElement:(NSString *)element state:(id)state
{
    NSString *address = [element componentsSeparatedByString:@" "][1];
    address = [address stringByAppendingFormat:@"%@",state];
    [self.localizationKeysForUIElements removeObjectForKey:element];
}

-(NSString *)localizationKeyForUIElement:(NSString *)element state:(id)state
{
    NSString *address = [element componentsSeparatedByString:@" "][1];
    address = [address stringByAppendingFormat:@"%@",state];
    return self.localizationKeysForUIElements[address];
}

@end
