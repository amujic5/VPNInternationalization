//
//  NSObject+Localization.m
//  Pods
//
//  Created by Vlaho Poluta on 8/23/15.
//
//

#import "NSObject+Localization.h"
#import <objc/runtime.h>
#import "LocalizationManager.h"


@interface LocalizationNotificationObject : NSObject

@property (nonatomic, weak) NSObject *localizableObject;

+(instancetype)objectWithLocalizableObject:(NSObject *)localizableObject;

@end

@implementation LocalizationNotificationObject

+(instancetype)objectWithLocalizableObject:(NSObject *)localizableObject
{
    LocalizationNotificationObject *object = [LocalizationNotificationObject new];
    object.localizableObject = localizableObject;
    [[NSNotificationCenter defaultCenter] addObserver:object selector:@selector(loc_localeDidChanged) name:LocalizationManagerLanguageDidChangeNotification object:nil];
    return object;
}

-(void)loc_localeDidChanged
{
    [self.localizableObject loc_localeDidChanged];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalizationManagerLanguageDidChangeNotification object:nil];
}

@end

@interface NSObject (LocalizationPrivate)

@property (nonatomic, strong) LocalizationNotificationObject *loc_notificationObject;

@end

@implementation NSObject (LocalizationPrivate)

-(void)setLoc_notificationObject:(LocalizationNotificationObject *)loc_notificationObject
{
    objc_setAssociatedObject(self, @selector(loc_notificationObject), loc_notificationObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(LocalizationNotificationObject *)loc_notificationObject
{
    return objc_getAssociatedObject(self, @selector(loc_notificationObject));
}

@end

@implementation NSObject (Localization)


-(void)loc_subscribeForLocaleDidChange
{
    if (self.loc_notificationObject) {
        return;
    }
    self.loc_notificationObject = [LocalizationNotificationObject objectWithLocalizableObject:self];
}

-(NSMutableDictionary *)loc_keysDictionary
{
    NSMutableDictionary *keysDictionary = objc_getAssociatedObject(self, @selector(loc_keysDictionary));
    if (!keysDictionary) {
        keysDictionary = [NSMutableDictionary new];
        objc_setAssociatedObject(self, @selector(loc_keysDictionary), keysDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self loc_subscribeForLocaleDidChange];
    }
    return keysDictionary;
}

-(void)loc_localeDidChanged
{
    //to be overridden
}


@end
