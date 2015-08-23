//
//  UIButton+Localization.h
//  LocalizationManager
//
//  Created by Vlaho Poluta on 2/8/15.
//  Copyright (c) 2015 Infinum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Localization)

//for all states
@property (nonatomic, strong) IBInspectable NSString *locTitleKey;

//for any state
-(void)setLocalizedTitleForKey:(NSString *)localizationKey forState:(UIControlState)state;
-(NSString *)localizationKeyForState:(UIControlState)state;





@end
