//
//  UIButton+Localization.h
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Localization)

-(void)setLocalizedTitleForKey:(NSString *)localizationKey forState:(UIControlState)state;

//for all states
-(void)setLocalizedTitleForKey:(NSString *)localizationKey;


@end
