//
//  Example_SwiftTests.swift
//  Example-SwiftTests
//
//  Created by Nikola Lajic on 3/18/15.
//  Copyright (c) 2015 Nikola Lajic. All rights reserved.
//

import UIKit

class Example_SwiftTests: NLBaseTests {
    func testNotificationObserving() {
        let obj = TestObject()
        obj.start() // commenting out will fail the next two assertions
        NLAssertObservingNotification("testNotification", object: obj, description: "I forgot to observe")
        NLAssertObservingNotificationWithSelector("testNotification", object: obj, selector: "testSelector", description: "I forgot to observe a selector")
        obj.stop() // commenting out will fail last assertion
        NLAssertNotObservingNotification("testNotification", object: obj, description: "I forgot to stop observing a selector")
    }
}
