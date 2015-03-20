//
//  UITextField+Localization.h
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Localization)

-(void)setLocalizedTextForKey:(NSString *)localizationKey;
-(void)setLocalizedPlaceholderForKey:(NSString *)localizationKey;

@end
