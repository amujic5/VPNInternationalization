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
        if (!_language && self.preferePhoneLanguage) {
            //DEFAULT LANGUAGE SET HERE - from phone languages
            //this is same as [[NSLocale preferredLanguages] firstObject];
            _language = [[[NSUserDefaults standardUserDefaults] objectForKey:AppleLanguages] firstObject];
        }
    }
    return _language;
}

-(NSString *)defoultLanguage
{
    if (!_defoultLanguage) {
        _defoultLanguage = @"en";
    }
    return _defoultLanguage;
}

#pragma makr - localized string for key

+(NSString *)localizedStringForKey:(NSString *)key
{
    NSString *language = [LocalizationManager sharedManager].language;
    NSString *string =  NSLocalizedStringFromTable(key, language, nil);
    if (useDefoultLanguage && [string isEqualToString:key]) {
        string = NSLocalizedStringFromTable(key, [LocalizationManager sharedManager].language, nil);
    }
    return string;
}

@end
