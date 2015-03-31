//
//  LocalizationManager.h
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+Localization.h"
#import "UILabel+Localization.h"
#import "UITextField+Localization.h"
#import "UITextView+Localization.h"

#ifndef local
#define local(s) [LocalizationManager localizedStringForKey:s]
#endif

#ifndef locCurent
#define locCurent [[LocalizationManager sharedManager] language]
#endif

static NSString *LocalizationManagerLanguageDidChangeNotification = @"LocalizationManagerLanguageDidChangedNotification";

/**
 This is used for Storyboard.
 When you put localization key in text input filed of i.e. UILabel, and you might wont to put there more text so you
 can get the feeling how that label is going to look like while editing Storyboard.
 You can use this divider to divide actual localization key from that dummy text you were going to put there.
 Example of use:
 @"localization_key // Lorem ipusm dolar...."
 */
static NSString *LocalizationKeyToDummyTextDivider = @"//";

/**
 This is used for Storyboard.
 When you don't want some storyboard text to be used as localization key, you can write it like :
 <StoryboardSkipTihsTextPrefix><your text>
 and in the run time StoryboardSkipTihsTextPrefix will be removed so you will see onely <your text>
 as the text of an element you wanted
 */
static NSString *SkipTihsTextPrefix = @"__";

/**
 Rollback language is language that is used in case current language does not contain certain localization keys.
 It can be turn off and on.
 */
#define useRollbackLanguage YES
static NSString *rollbackLanguage = @"en";

@interface LocalizationManager : NSObject

+(instancetype)sharedManager;


@property (nonatomic, strong) NSString *language;

+(NSString *)localizedStringForKey:(NSString *)key;

//Used by +Localization.h categories
+(BOOL)shouldLocalizeForStoryboardString:(NSString *)string;
+(NSString *)stringWithRemovedSkipingPrefixFromString:(NSString *)string;
+(NSString *)localizationKeyFromStoryboardString:(NSString *)string;
-(NSString *)localizationKeyForUIElement:(NSString *)element state:(id)state;
-(void)setLocalizationKey:(NSString *)key forUIElement:(NSString *)element state:(id)state;;
-(void)removeLocalizationKeyForUIElement:(NSString *)element state:(id)state;;
@end
