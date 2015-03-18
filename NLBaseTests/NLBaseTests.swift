//
//  NLBaseTests.swift
//  SwiftSwizzling
//
//  Created by Nikola Lajic on 3/18/15.
//  Copyright (c) 2015 Nikola Lajic. All rights reserved.
//

import Foundation

extension NLBaseTests {
 
    /**
    Assert that object is observing a notification. 
    
    :param: notification Name of the notification.
    :param: object       Object for which to check.
    :param: description  Test case failure description note.
    :param: file         Don't add this.
    :param: line         Don't add this.
    */
    func NLAssertObservingNotification(notification: String, object: AnyObject, description: String?, file:String=__FILE__, line:UInt=__LINE__) {
        let _a1: NSDictionary? = objc_getAssociatedObject(object, kAssociatedNotificationsKey) as NSDictionary?
        if let _a1 = _a1 {
            let _val: String? = _a1.valueForKey(notification) as String?
            if _val != nil {
                return
            }
        }
        if let desc = description {
            recordFailureWithDescription("[Observing \"\(notification)\" fails] \(desc)", inFile: file, atLine: line, expected:true)
        }
        else {
            recordFailureWithDescription("[Observing \"\(notification)\" fails]", inFile: file, atLine: line, expected:true)
        }
    }
    
    /**
    Assert that object is observing a notification and calling a selector.
    
    :param: notification Name of the notification.
    :param: object       Object for which to check.
    :param: selector     Selector for which to test.
    :param: description  Test case failure description note.
    :param: file         Don't add this.
    :param: line         Don't add this.
    */
    func NLAssertObservingNotificationWithSelector(notification: String, object: AnyObject, selector: String, description: String?, file:String=__FILE__, line:UInt=__LINE__) {
        let _a1: NSDictionary? = objc_getAssociatedObject(object, kAssociatedNotificationsKey) as NSDictionary?
        if let _a1 = _a1 {
            let _val: String? = _a1.valueForKey(notification) as String?
            if let _val = _val {
                if  _val == selector {
                    return;
                }
            }
        }
        if let desc = description {
            recordFailureWithDescription("[Observing \"\(notification)\" for \"\(selector)\" fails] \(desc)", inFile: file, atLine: line, expected:true)
        }
        else {
            recordFailureWithDescription("[Observing \"\(notification)\" for \"\(selector)\" fails]", inFile: file, atLine: line, expected:true)
        }
    }
    
    /**
     Assert that object is not observing a notification.
    
    :param: notification Name of the notification.
    :param: object       Object for which to check.
    :param: description  Test case failure description note.
    :param: file         Don't add this.
    :param: line         Don't add this.
    */
    func NLAssertNotObservingNotification(notification: String, object: AnyObject, description: String?, file:String=__FILE__, line:UInt=__LINE__) {
        let _a1: NSDictionary? = objc_getAssociatedObject(object, kAssociatedNotificationsKey) as NSDictionary?
        if let _a1 = _a1 {
            let _val: String? = _a1.valueForKey(notification) as String?
            if _val == nil {
                return
            }
        }
        else {
            return
        }
        if let desc = description {
            recordFailureWithDescription("[Not observing \"\(notification)\" fails] \(desc)", inFile: file, atLine: line, expected:true)
        }
        else {
            recordFailureWithDescription("[Not observing \"\(notification)\" fails]", inFile: file, atLine: line, expected:true)
        }
    }
}
