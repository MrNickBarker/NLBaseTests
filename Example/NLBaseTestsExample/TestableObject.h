//
//  TestableObject.h
//  NLBaseTestsExample
//
//  Created by Nikola Lajic on 8/26/14.
//  Copyright (c) 2014 Nikola Lajic. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kTestNotification;

@interface TestableObject : NSObject

- (void)stopNotifications;
- (void)objectAction:(NSNotification *)notification;

@end
