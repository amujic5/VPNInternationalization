//
//  NSObject+Localization.h
//  Pods
//
//  Created by Vlaho Poluta on 8/23/15.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Localization)

@property (nonatomic, strong, readonly) NSMutableDictionary *loc_keysDictionary;

-(void)loc_localeDidChanged;

-(void)loc_subscribeForLocaleDidChange;

@end
