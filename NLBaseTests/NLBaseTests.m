//
//  BaseTests.m
//  NotificationObserverTesting
//
//  Created by Nikola Lajic on 8/25/14.
//  Copyright (c) 2014 Nikola Lajic. All rights reserved.
//

#import "NLBaseTests.h"

const char *kAssociatedNotificationsKey = "associatedNotifications";
static IMP _original_add_implementation;
static IMP _original_remove_implementation;
static IMP _original_remove_all_implementation;

/**
 * Associates the selector with a notification name to make it easy to check if an object is subscribed to a notification.
 */
void _swizzled_add_implementation(id self, SEL _cmd, id observer, SEL selector, NSString *name, id notiObj)
{
    // check if dictionary of observed notifications exists
    NSMutableDictionary *notifications = objc_getAssociatedObject(observer, kAssociatedNotificationsKey);
    if (!notifications)
    {
        // if it doesn't create it and associate it
        notifications = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(observer, kAssociatedNotificationsKey, notifications, OBJC_ASSOCIATION_RETAIN);
    }
    // set selector name for each notification
    [notifications setObject:NSStringFromSelector(selector) forKey:name];
    
    // Call original implementation
    // Need cast so ARC doesn't retain void
    ((void(*)(id,SEL,id,SEL,NSString*,id))_original_add_implementation)(self, _cmd, observer, selector, name, notiObj);
}

/**
 * Removes notification name to make it easy to check if an object is not subscribed to a notification.
 */
void _swizzled_remove_implementation(id self, SEL _cmd, id observer, NSString *name, id notiObj)
{
    // check if dictionary of observed notifications exists
    NSMutableDictionary *notifications = objc_getAssociatedObject(observer, kAssociatedNotificationsKey);
    if (notifications)
    {
        [notifications removeObjectForKey:name];
    }
    
    // Call original implementation
    // Need cast so ARC doesn't retain void
    ((void(*)(id,SEL,id,NSString*,id))_original_remove_implementation)(self, _cmd, observer, name, notiObj);
}

void _swizzled_remove_all_implementation(id self, SEL _cmd, id observer)
{
    // remove all items and throw a warning that this method shouldn't be used
    objc_setAssociatedObject(observer, kAssociatedNotificationsKey, nil, OBJC_ASSOCIATION_ASSIGN);
    NSLog(@"[WARNING] Should you be using \"removeAll:\"?");
    
    // Call original implementation
    // Need cast so ARC doesn't retain void
    ((void(*)(id,SEL,id))_original_remove_all_implementation)(self, _cmd, observer);
}

@implementation NLBaseTests

- (void)setUp
{
    [super setUp];
    
    Method originalAddMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(addObserver:selector:name:object:));
    _original_add_implementation = method_setImplementation(originalAddMethod, (IMP)_swizzled_add_implementation);
    
    Method originalRemoveMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(removeObserver:name:object:));
    _original_remove_implementation = method_setImplementation(originalRemoveMethod, (IMP)_swizzled_remove_implementation);
    
    Method originalRemoveAllMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(removeObserver:));
    _original_remove_all_implementation = method_setImplementation(originalRemoveAllMethod, (IMP)_swizzled_remove_all_implementation);
}

- (void)tearDown
{
    // return implementations for the next setup since it will infinately call itself
    Method swizzledAddMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(addObserver:selector:name:object:));
    method_setImplementation(swizzledAddMethod, (IMP)_original_add_implementation);
    
    Method swizzledRemoveMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(removeObserver:name:object:));
    method_setImplementation(swizzledRemoveMethod, (IMP)_original_remove_implementation);
    
    Method swizzledRemoveAllMethod = class_getInstanceMethod([NSNotificationCenter class], @selector(removeObserver:));
    method_setImplementation(swizzledRemoveAllMethod, (IMP)_original_remove_all_implementation);

    [super tearDown];
}

@end
