# NLBaseTests

Unit testing base class for iOS. XCTestCase subclass that makes notification observing testing easy. 

More info: https://blog.codecentric.de/en/2014/09/unit-testing-notification-observing-ios/

## Usage

Your test case should inherit from `NLBaseTests`

### Objective-C
```Objective-C
NLAssertObservingNotification(obj, notifcation, description, ...);
NLAssertObservingNotificationWithSelector(obj, notification, selector, description, ...);
NLAssertNotObservingNotification(obj, notification, description, ...);
```

### Swift
```Swift
NLAssertObservingNotification("notificationName", object: obj, description: "I forgot to observe")
NLAssertObservingNotificationWithSelector("notificationName", object: obj, selector: "testSelector", description: "I forgot to observe a selector")
NLAssertNotObservingNotification("notificationName", object: obj, description: "I forgot to stop observing a selector")
```

check the included example projects for more details.

## Installation

### Objective-C
* Add the `NLBaseTests` folder to your project and select your unit tests as the target.
* Remove `NLBaseTests\NLBaseTests.swift` from your project as it is not needed.

### Swift 
* Add `NLBaseTests\NLBaseTests.h` and `NLBaseTests\NLBaseTests.m` to your project and select unit tests as the target. _Note: don't add the whole folder because you will have to do the next step manually._
* Confirm when Xcode asks you if you want to create a bridging header
* In the **unit tests** target  build settings make sure that `Objective-C Bridging header` is pointing to the correct file
* Add `NLBaseTests\NLBaseTests.swift` to your project and select unit tests as the target
* In the bridging header `#import "NLBaseTests.h"`