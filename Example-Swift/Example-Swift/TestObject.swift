//
//  TestObject.swift
//  Example-Swift
//
//  Created by Nikola Lajic on 3/18/15.
//  Copyright (c) 2015 Nikola Lajic. All rights reserved.
//

import Foundation

class TestObject {
    func start() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "testSelector",
            name: "testNotification",
            object: nil)
    }
    
    func stop() {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "testNotification",
            object: nil)
    }
    
    func testSelector() {
        NSLog("test")
    }
}