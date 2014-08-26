//
//  TestableObject.m
//  NLBaseTestsExample
//
//  Created by Nikola Lajic on 8/26/14.
//  Copyright (c) 2014 Nikola Lajic. All rights reserved.
//

#import "TestableObject.h"

NSString * const kTestNotification = @"TestNotification";

@implementation TestableObject

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(objectAction:)
                                                     name:kTestNotification
                                                   object:nil];
    }
    return self;
}

- (void)objectAction:(NSNotification *)notification
{
    // Test action does nothing
}

- (void)stopNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kTestNotification
                                                  object:nil];
}

@end
