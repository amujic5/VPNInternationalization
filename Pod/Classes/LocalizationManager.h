//
//  LocalizationManager.h
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef local
#define local(s) [LocalizationManager localizedStringForKey:s]
#endif

#ifndef localFormat
#define localFormat(s,...) [NSString stringWithFormat:local(s), ##__VA_ARGS__]
#endif

#ifndef locCurent
#define locCurent [[LocalizationManager sharedManager] language]
#endif

static NSString *LocalizationManagerLanguageDidChangeNotification = @"LocalizationManagerLanguageDidChangedNotification";


/**
 Rollback language is language that is used in case current language does not contain certain localization keys.
 It can be turn off and on.
 */

@interface LocalizationManager : NSObject

@property (nonatomic, strong) NSString *language;

#define useDefoultLanguage YES
@property (nonatomic, assign) BOOL preferePhoneLanguage;//defoult == NO
@property (nonatomic, strong) NSString *defoultLanguage;//defoult == 'en'

+(instancetype)sharedManager;
+(NSString *)localizedStringForKey:(NSString *)key;

@end