//
//  BaseTests.h
//  NotificationObserverTesting
//
//  Created by Nikola Lajic on 8/25/14.
//  Copyright (c) 2014 Nikola Lajic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/objc-runtime.h>

/**
 *  Key for the associated dictionary of notifications on a object.
 */
extern const char *kAssociatedNotificationsKey;

@interface NLBaseTests : XCTestCase

/**
 * Assert that object is observing a notification.
 * @param a1 Object for which to check.
 * @param notification Name of the notification.
 * @param description
 */
#define NLAssertObservingNotification(a1, notification, description, ...) \
do { \
    @try { \
        id _a1 = objc_getAssociatedObject(a1, kAssociatedNotificationsKey); \
        id _val = [_a1 valueForKey:notification]; \
        if (_a1 == nil || _val == nil) { \
            if (description.length == 0) { \
                NSString *_obj = [NSString stringWithUTF8String:#a1]; \
                XCTFail(@"(%@) observing (%@)", _obj, notification); \
            } else { \
                XCTFail(description, ##__VA_ARGS__); \
            } \
        } \
    } \
    @catch (id anException) { \
        XCTFail(@"(%s) observing notification fails", #a1); \
    } \
} while(0)

/**
 * Assert that object is observing a notification and calling a selector.
 * @param a1 Object for which to check.
 * @param notification Name of the notification.
 * @param selector Name of the selector.
 * @param description
 */
#define NLAssertObservingNotificationWithSelector(a1, notification, selector, description, ...) \
do { \
    @try { \
        id _a1 = objc_getAssociatedObject(a1, kAssociatedNotificationsKey); \
        id _val = [_a1 valueForKey:notification]; \
        if (_a1 == nil || ![_val isEqual:selector]) { \
            if (description.length == 0) { \
                NSString *_obj = [NSString stringWithUTF8String:#a1]; \
                XCTFail(@"(%@) observing (%@) with (%@)", _obj, notification, selector); \
            } else { \
                XCTFail(description, ##__VA_ARGS__); \
            } \
        } \
    } \
    @catch (id anException) { \
        XCTFail(@"(%s) observing notification fails", #a1); \
    } \
} while(0)

/**
 * Assert that object is not observing a notification.
 * @param a1 Object for which to check.
 * @param notification Name of the notification.
 * @param description
 */
#define NLAssertNotObservingNotification(a1, notification, description, ...) \
do { \
    @try { \
        id _a1 = objc_getAssociatedObject(a1, kAssociatedNotificationsKey); \
        id _val = [_a1 valueForKey:notification]; \
        if (_val != nil) { \
            if (description.length == 0) { \
                NSString *_obj = [NSString stringWithUTF8String:#a1]; \
                XCTFail(@"(%@) not observing (%@)", _obj, notification); \
            } else { \
                XCTFail(description, ##__VA_ARGS__); \
            } \
        } \
    } \
    @catch (id anException) { \
        XCTFail(@"(%s) not observing notification fails", #a1); \
    } \
} while(0)

@end
