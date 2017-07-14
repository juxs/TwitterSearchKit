# TwitterSearchKit
Demo SDK for fetching Tweets with the Twitter API

## Requirements

- iOS 9.0+
- Swift 3.1 or Objective-C

## Installation

### CocoaPods

To use the SDK with CocoaPods add the following lines to your podfile's target:

```ruby
use_frameworks!

pod 'TwitterSearchKit', :git => 'https://github.com/juxs/TwitterSearchKit.git'
```

### Manual

Download the project and drag the `TwitterSearchKit.xcodeproj` file into your XCode's project navigator.

## Usage

### Objective-C Support

Objective C classes are using the TS prefix. For instance, TwitterSearchKit becomes TSTwitterSearchKit.

Add ```@import TwitterSearchKit;``` to the Objective C file.

### Usage

First the Twitter API credentials have to be set in the AppDelegate. It must be a Base64 encoded string containing the format consumerKey:ConsumerSecret. ConsumerKey and ConsumerSecret can be obtained on https://dev.twitter.com and are used for application-only API requests

```Swift
func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Set Twitter credentials
        TwitterSearchKit.tokenCredentials = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        
        return true
}
```

This is the implementation for fetching tweets with a given search term (the string of a hashtag):

```Swift
TwitterSearchKit.getTweets(withSearchTerm: "AnyHashtagString") { (tweets) in
        //parse tweets
}

```

Tweets are asynchronously fetched and returned as an optional array of Dictionaries. Each dictionary contains the raw Twitter API response.
The request failed if the array is nil. If that's the case make sure your API credentials are set correctly.

## Samples

There are sample apps in this repository.

[Swift Sample](https://github.com/juxs/TwitterSearchKit/tree/master/SwiftSample)

[Objective-C Sample](https://github.com/juxs/TwitterSearchKit/tree/master/ObjcSample)

To run check out this repo and open the Library project file as the samples are targets.
