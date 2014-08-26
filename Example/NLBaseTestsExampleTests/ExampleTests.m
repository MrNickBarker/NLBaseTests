//
//  NLBaseTestsExampleTests.m
//  NLBaseTestsExampleTests
//
//  Created by Nikola Lajic on 8/26/14.
//  Copyright (c) 2014 Nikola Lajic. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NLBaseTests.h"
#import "TestableObject.h"

@interface ExampleTests : NLBaseTests

@end

@implementation ExampleTests

- (void)testObserving
{
    TestableObject *obj = [[TestableObject alloc] init];
    NLAssertObservingNotification(obj, kTestNotification, @"");
}

- (void)testObservingWithSpecificSelector
{
    TestableObject *obj = [[TestableObject alloc] init];
    NLAssertObservingNotificationWithSelector(obj,
                                              kTestNotification,
                                              NSStringFromSelector(@selector(objectAction:)),
                                              @"");
}

- (void)testNotObserving
{
    TestableObject *obj = [[TestableObject alloc] init];
    [obj stopNotifications];
    NLAssertNotObservingNotification(obj, kTestNotification, @"");
}

- (void)testChained
{
    TestableObject *obj = [[TestableObject alloc] init];
    NLAssertObservingNotification(obj, kTestNotification, @"");
    [obj stopNotifications];
    NLAssertNotObservingNotification(obj, kTestNotification, @"");
}

@end
