Adtrade SDK
===========

#### Installing with Cocoapods

Add to podfile

~~~
pod 'Adtrade'
~~~


Usage
-----

In your AppDelegate.m:

```objective-c
#import "Adtrade.h"
```


Inside your app delegate's 'applicationDidBecomeActive:' function call the following:

```objective-c

- (void)applicationDidBecomeActive:(UIApplication *)application{


    [[Adtrade sharedInstance] startWithAppKey:@"<APP_KEY>"];
    
    [[Adtrade sharedInstance] showInterstitial:nil withSuccess:^{
        // Ad was shown
        
    } failure:^(NSError *error) {
        // Error, no ad was shown
        
    }];  
}

```


<p align="center">
  <img src="https://raw.githubusercontent.com/adtrade/adtrade-ios-sdk/master/Resources/show-ad.png" alt="Example interstitial"/>
</p>

