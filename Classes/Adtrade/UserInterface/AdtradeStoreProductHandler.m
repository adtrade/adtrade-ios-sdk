//
//  AdtradeStoreProductViewController.m
//
//  Created by William Locke on 10/3/15.
//
//

#import "AdtradeStoreProductHandler.h"

typedef void (^AdtradeStoreProductHandlerCompletionHandler)(BOOL success);

@interface AdtradeStoreProductHandler (){
    AdtradeStoreProductHandlerCompletionHandler _storeProductViewControllerClosed;
}

@end

@implementation AdtradeStoreProductHandler

+ (id)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark App Store
-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
        if ([rootViewController isKindOfClass:[UITabBarController class]]){
            rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
        }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
            rootViewController = ((UINavigationController *)rootViewController).topViewController;
        }
    }
    return rootViewController;
}

-(UIView *)newActivityIndicatorViewForViewController:(UIViewController *)viewController{
    UIView *view = viewController.view;
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(view.frame.size.width * 0.4, view.frame.size.height * 0.4, view.frame.size.width * 0.2, view.frame.size.height * 0.2);
    
    [activityIndicatorView startAnimating];
    return activityIndicatorView;
}

-(void)loadProductDataForAppStoreLink:(NSString *)appStoreLink completionHandler:(void (^ )(BOOL success))completionHandler{
    if(!appStoreLink){
        return;
    }
    self.loaded = NO;
    self.appStoreLink = appStoreLink;
    NSURL *url = [NSURL URLWithString:appStoreLink];
    self.storeViewController = [[SKStoreProductViewController alloc] init];
    NSNumber *iTunesItemIdentifier = [self itunesItemIdentifierFromUrlString:[url absoluteString]];
    if([iTunesItemIdentifier intValue] < 0){
        completionHandler(NO);
        return;
    }
    if (!iTunesItemIdentifier) {
        return;
    }

    [self.storeViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:iTunesItemIdentifier, @"at": @"11lLxv" } completionBlock:^(BOOL result, NSError *error){
        
        if(self.appStoreLink && [appStoreLink isEqualToString:self.appStoreLink]){
            if(result){
                self.loaded = YES;
            }else{
                self.loaded = NO;
            }
        }
        if(result){
            if (completionHandler) {
                completionHandler(YES);
            }
        }else{
            if(completionHandler){
                completionHandler(NO);
            }
        }
    }];
}


#pragma mark --Show Interstitial Inside App
-(BOOL)appStoreLinkLoaded:(NSString *)appStoreLink{
    
    if(self.appStoreLink && [self.appStoreLink isEqualToString:appStoreLink] && self.loaded){
        return YES;
    }
    return NO;
}

-(void)openInRootViewController:(UIViewController *)rootViewController completionHandler:(void (^ )(BOOL success))completionHandler{
    _storeProductViewControllerClosed = nil;
    if(!self.storeViewController){
        completionHandler(NO);
        return;
    }
    _storeProductViewControllerClosed = completionHandler;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.storeViewController.delegate = (id<SKStoreProductViewControllerDelegate>)self;
        [rootViewController presentViewController:self.storeViewController animated:YES completion:nil];
    });
}

#pragma mark Data
-(NSNumber *)itunesItemIdentifierFromUrlString:(NSString *)urlString{
    NSNumber *iTunesItemIdentifier = nil;
    if(urlString){
        NSRange appIdRange = [urlString rangeOfString:@"/id"];
        NSRange questionMarkRange = [urlString rangeOfString:@"?"];
        
        if(appIdRange.location != NSNotFound && questionMarkRange.location != NSNotFound){
            NSString *substring = [[urlString substringToIndex:questionMarkRange.location] substringFromIndex:appIdRange.location + 3];
            if([substring intValue] > 0){
                iTunesItemIdentifier = [NSNumber numberWithInt:[substring intValue]];
            }
        }
    }
    return iTunesItemIdentifier;
}

#pragma mark <SKStoreProductViewControllerDelegate>
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:nil];
    self.loaded = NO;
    self.storeViewController = nil;
    if (_storeProductViewControllerClosed) {
        _storeProductViewControllerClosed(YES);
        _storeProductViewControllerClosed = nil;
    }
    
}

@end
