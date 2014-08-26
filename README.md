# NLBaseTests

A SenTestCase subclass that makes testing notification observing easy. More info: 

## Usage

```Objective-C
NLAssertObservingNotification(obj, notifcation, description, ...);
NLAssertObservingNotificationWithSelector(obj, notification, selector, description, ...);
NLAssertNotObservingNotification(obj, notification, description, ...);
```
check the included example project for more details.

## Installation

Drag the `NLBaseTests` folder to your project and select your tests as the target.