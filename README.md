# Flyreel SDK

[![Swift 5.7 Supported](https://img.shields.io/badge/Swift-5.7-green.svg)](https://github.com/apple/swift) [![iOS 13](https://img.shields.io/badge/iOS-13+-orange.svg)](https://apple.com)

## Installation

### Cocoapods

Add `pod Flyreel` to your Podfile

```
pod 'Flyreel'
```

### Swift Package Manager

1. Follow the [Apple guide](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) to add the package dependency to your app.
2. Search for the `https://github.com/Flyreel/flyreel-sdk-ios` package.


## Initialization

To use the Flyreel SDK, you must provide a configuration with the following parameters:

`settingsVersion`: Identifier of your remote SDK settings.

`organizationId`: Identifier of your organization.

```swift
let configuration = FlyreelConfiguration(
    settingsVersion: "1",
    organizationId: "7d3899f1421a7650241516475"
)
        
FlyreelSDK.shared.set(configuration: configuration)
```
**Setting up the configuration is mandatory. Attempting to open the SDK flow without it will result in a fatal error.**

## Permissions

Since the SDK actively uses some functionalities of the iOS system you need to provide a few permission settings

```
<key>NSCameraUsageDescription</key>
<string>We need access to the camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>We need access to the camera.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need access to your location data</string>
```

## How to present UI

### SwiftUI
For SwiftUI, use our custom modifier similar to a regular sheet presentation:

``` swift
@State private var isFlowPresented = false

var body: some View {
    Button("Open Flyreel flow") {
        isFlowPresented = true
    }
    .presentFlyreel(isPresented: $isFlowPresented)
}
```

### UIKIt

For UIKit, present the Flyreel flow on any UIViewController:

``` swift
FlyreelSDK.shared.presentFlyreel(on: self)
```

### Deep Linking

If you're launching the Flyreel flow from a deep link, push notification, or a custom solution where user details can be provided automatically, use:

```swift
SwiftUI

func presentFlyreel(
    isPresented: Binding<Bool>,
    zipCode: String,
    accessCode: String,
    shouldSkipLoginPage: Bool = true
)

func presentFlyreel(
    isPresented: Binding<Bool>,
    deepLinkURL: URL,
    shouldSkipLoginPage: Bool = true
)

UIKit

func presentFlyreel(
     on rootViewController: UIViewController,
    zipCode: String,
    accessCode: String,
    shouldSkipLoginPage: Bool = true,
    animated: Bool = true
)

func presentFlyreel(
    on rootViewController: UIViewController,
    deepLinkURL: URL,
    shouldSkipLoginPage: Bool = true,
    animated: Bool = true
)
```

### SDK Callbacks
Flyreel SDK supports registering callbacks to perform custom actions when the Flyreel UI is dismissed. This is done via the new registerOnClose function.

For example, you can use it to perform cleanup or update your app’s state when the SDK flow is closed:

```
FlyreelSDK.shared.registerOnClose {
    // Your cleanup code here, e.g., update state or analytics tracking
    print("Flyreel SDK flow has been dismissed!")
}
```
Note: Ensure you register the callback before presenting the Flyreel flow so that your handler is invoked upon the UI dismissal.

## Debug Logs

Enable debug logging for troubleshooting purposes:

```swift
FlyreelSDK.shared.enableLogs()
````

## Flyreel status check
You can manually check Flyreel status 
```swift
///This function makes a network request to retrieve the status of Flyreel for the specified zip code and access code
func fetchFlyreelStatus(zipCode: String, accessCode: String, completion: @escaping (Result<FlyreelStatus, FlyreelError>) -> Void)

// or async version 
func fetchFlyreelStatus(zipCode: String, accessCode: String) async throws -> FlyreelStatus
```

## Analytics

```swift
/// Subscribes to a stream of analytic events and handles each event with a provided closure.
///
/// This function observes a feed of analytic events from the SDK. When an event
/// is received, the provided handler closure is called with the event as its argument.
///
/// - Parameters:
///   - handler: A closure that is called with the analytic event emitted by the SDK.
///     The closure takes a single parameter:
///       - event: A `FlyreelAnalyticEvent` type that contains event's data.
FlyreelSDK.shared.observeAnalyticEvents() { event in
    YourAnalyticProvider.send(event)
}
```

## Sandbox

Verify your implementation in the sandbox mode. Switch the environment with the configuration:

```swift
let configuration = FlyreelConfiguration(
    settingsVersion: "1",
    organizationId: "7d3899f1421a7650241516475",
    environment: .sandbox
)
        
FlyreelSDK.shared.set(configuration: configuration)
```

## Firewall whitelisting

Here is a list of Flyreel's hosts in case you need to whitelist URLs.

```
api3.flyreel.co
sandbox.api3.flyreel.co
```

