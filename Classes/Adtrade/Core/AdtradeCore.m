//
// AdtradeCore.h
//
// Created by William Locke on 5/31/15.
// Copyright (c) 2016 Adtrade (http://adtrade.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "Adtrade.h"
#import <AdSupport/AdSupport.h>
#import "AdtradeAdViewController.h"
#import "AdtradeImageDownloader.h"
#import "AdtradeCore.h"
#import "AdtradeScreen.h"
#import <CommonCrypto/CommonDigest.h>
#import "AdtradeAPI.h"
#import "AdtradeModels.h"
#import "ATDate.h"

typedef void (^ AdtradeInstallCallback)(BOOL installed);

@interface AdtradeCore()<AdtradeAdViewControllerDelegate>{
    NSDate *_methodNamedShowInterstitialLastCalledAt;
}

@end

@implementation AdtradeCore

- (id)init{
    self = [super init];
    if (self) {
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [AdtradeScreen mainScreen].bounds.size.width >= 768){
            _device.model = @"iPad";
        }else{
            _device.model = @"iPhone";
        }
    }
    return self;
}

+ (id)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark Start
-(void)startSessionUsingAppKey:(NSString *)appKey{
    _appKey = appKey;
    [[AdtradeAPI sharedInstance] setAppKey:appKey];
    if(!_app.identifier){
        [self install];
    }else{
        [self createSession:^(NSError *error){ }];
    }
}

#pragma mark Sessions
-(void)createSession:(void (^ )(NSError *error))completionHandler{
    [[AdtradeAPI sharedInstance] createSessionWithSuccess:^(NSDictionary *item) {
        completionHandler(nil);
    } failure:^(NSError *error) {
        completionHandler(error);
    }];
}

#pragma mark Installs
-(void)install{
    [[AdtradeAPI sharedInstance] getAppWithSucess:^(NSDictionary *item) {
        _app = [AdtradeApp instanceFromDictionary:item];
        [[AdtradeAPI sharedInstance] createInstallWithSucess:^(NSDictionary *item) {
            [self createSession:^(NSError *error){
                
            }];
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        
    }];
}

-(void)createInstall:(void (^ )(AdtradeInstall *install, NSError *error))completionHandler{
    [[AdtradeAPI sharedInstance] createInstallWithSucess:^(NSDictionary *item) {
        AdtradeInstall *install = [AdtradeInstall instanceFromDictionary:item];
        completionHandler(install, nil);
    } failure:^(NSError *error) {
        completionHandler(nil, error);
    }];
}

#pragma mark Impressions
-(void)createImpressionWithOptions:(NSDictionary *)options completionHandler:(void (^ )(AdtradeImpression *impression, NSError *error))completionHandler{
    [[AdtradeAPI sharedInstance] createImpressionWithSucess:^(NSDictionary *item) {
        AdtradeImpression *impression = [AdtradeImpression instanceFromDictionary:item];
        completionHandler(impression, nil);
    } failure:^(NSError *error) {
        completionHandler(nil, error);
        return;
    }];
}

-(BOOL)validateImpression:(AdtradeImpression *)impression options:(NSDictionary *)options error:(NSError **)error{
    if([_app.identifier intValue] == [impression.ad.app.identifier intValue]){
        *error = [NSError errorWithDomain:@"adtrade.com" code:403 userInfo:@{NSLocalizedDescriptionKey:@"Ad is for this app"}];
        return NO;
    }
    return YES;
}

-(void)showInterstitial:(NSString *)zone withSuccessHandler:(void (^ )())successHandler errorHandler:(void (^ )(NSError *error))errorHandler{
    [[AdtradeCore sharedInstance] showInterstitial:zone withSuccessHandler:successHandler errorHandler:errorHandler options:@{}];
}

-(void)showInterstitial:(NSString *)zone withSuccessHandler:(void (^ )())successHandler errorHandler:(void (^ )(NSError *error))errorHandler options:(NSDictionary *)options{
    _methodNamedShowInterstitialLastCalledAt = [NSDate date];
    zone = zone ? zone : @"";
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{@"zone":zone}];
    
    [self createImpressionWithOptions:params completionHandler:^(AdtradeImpression *impression, NSError *error){
        if(!impression){
            if(successHandler){
                successHandler(nil, error);
            }
            return;
        }

        if (!_device) {
            _device = impression.device;
        }
        if (!_app) {
            _app = impression.app;
        }
        
        // Make sure impression.clicked is false (API may default to true).
        impression.clicked = NO;
        
        AdtradeCreative *selectedCreative;
        for(AdtradeCreative *creative in impression.ad.creatives){
            BOOL sameOrientation = [[creative.orientation lowercaseString] isEqualToString:[_app.orientation lowercaseString]];
            if (!_device.model) {
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    _device.model = @"iPad";
                }else{
                    _device.model = @"iPhone";
                }
            }
            
            BOOL sameDeviceGroup = [self deviceModel:creative.model isInTheSameDeviceModelGroupAsDeviceModel:_device.model];
            if(sameOrientation && sameDeviceGroup){
                selectedCreative = creative;
                break;
            }
        }
        
        if(!selectedCreative){
            NSString *errorMessage = @"Could not find creative for device model/orientation";
            NSString *reason = @"NotFound";
            [self error:errorMessage showingImpression:impression];
            if(successHandler){
                successHandler(nil, [NSError errorWithDomain:@"" code:404 userInfo:@{NSLocalizedDescriptionKey:errorMessage, @"reason":reason}]);
            }
            return;
        }
        
        impression.selectedCreative = selectedCreative;
        
        [AdtradeImageDownloader downloadImage:selectedCreative.adImageLink completionHandler:^(UIImage *image){
            impression.selectedCreative.adImage = image;
            [AdtradeImageDownloader downloadImage:selectedCreative.frameImageLink completionHandler:^(UIImage *image){
                impression.selectedCreative.frameImage = image;
                if([self validateCreative:selectedCreative adImage:impression.selectedCreative.adImage frameImage:impression.selectedCreative.frameImage error:nil]){
                    if ([options objectForKey:@"cache"]) {
                        successHandler(impression, nil);
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showImpression:impression completionHandler:successHandler];
                        });
                    }
                }else{
                    [self error:@"Invalid frame and/or ad images" showingImpression:impression];
                }
            }];
        }];
    }];
}

-(void)showImpression:(AdtradeImpression *)impression completionHandler:(void (^ )(AdtradeImpression *impression, NSError *error))completionHandler{
    AdtradeAdViewController *adViewController = [[AdtradeAdViewController alloc] init];
    adViewController = [[AdtradeAdViewController alloc] init];
    adViewController.impression = impression;
    adViewController.delegate = (id<AdtradeAdViewControllerDelegate>)[Adtrade sharedInstance];
    adViewController.creative = impression.selectedCreative;
    adViewController.adImage = impression.selectedCreative.adImage;
    adViewController.frameImage = impression.selectedCreative.frameImage;
    
    int minSecondsBetweenImpressions = 5;
    static BOOL throttleLock;
    if(throttleLock){
        NSString *errorMessage = [@"" stringByAppendingFormat:@"Another impression was just shown less than %d seconds ago", minSecondsBetweenImpressions];
        [self error:errorMessage showingImpression:impression];
        if(completionHandler){
            completionHandler(nil, [NSError errorWithDomain:@"" code:429 userInfo:@{NSLocalizedDescriptionKey:errorMessage, @"reason":@"LocallyThrottling"}]);
        }
    }else{
        throttleLock = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(minSecondsBetweenImpressions * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            throttleLock = NO;
        });
        
        if(_adViewController && _adViewController.view && _adViewController.view.superview){
            if ([self shouldDismissAdViewController:_adViewController forViewController:adViewController]) {
                [_adViewController.view removeFromSuperview];
            }else{
                [self error:@"Ad impression already showing" showingImpression:impression];
                return;
            }
        }
        _adViewController = adViewController;
        [_adViewController show];
        if (!impression.shown) { // Checks if impression hasn't been shown (i.e. was cached)
            impression.shown = YES; // Sets to shown and updates server so server knows it was shown.
            [self updateImpression:impression];
        }
        
        if(completionHandler){
            completionHandler(impression,nil);
        }
    }
}

-(BOOL)shouldDismissAdViewController:(AdtradeAdViewController *)adViewController forViewController:(AdtradeAdViewController *)secondAdViewController{
    if (!adViewController.impression || !adViewController.impression.createdAt) {
        return YES;
    }
    NSDate *createdAt = [ATDate dateFromString:adViewController.impression.createdAt];
    int secondsSinceAdShown = [[NSDate date] timeIntervalSince1970] - [createdAt timeIntervalSince1970];
    if (secondsSinceAdShown < 6) {
        return NO;
    }
    return YES;
}

-(void)deleteImpression:(AdtradeImpression *)impression error:(NSString *)error{
    
    [[AdtradeAPI sharedInstance] deleteImpressionWithID:[NSString stringWithFormat:@"%@", impression.identifier] uniqueToken:impression.uniqueToken sucess:^(NSDictionary *item) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)updateImpression:(AdtradeImpression *)impression{
    [[AdtradeAPI sharedInstance] updateImpression:[impression dictionaryRepresentation] sucess:^(NSDictionary *item) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)error:(NSString *)error showingImpression:(AdtradeImpression *)impression{
    [self deleteImpression:impression error:error];
}

#pragma mark Creatives
-(BOOL)validateCreative:(AdtradeCreative *)creative adImage:(UIImage *)adImage frameImage:(UIImage *)frameImage error:(NSError **)error{
    if(!adImage || adImage.size.width <= 0){
        return NO;
    }
    CGSize maxCreativeSize;
    if(creative.orientation && [creative.orientation isEqualToString:@"Landscape"]){
        maxCreativeSize = CGSizeMake([[AdtradeScreen mainScreen] bounds].size.height, [[AdtradeScreen mainScreen] bounds].size.width);
    }else{
        maxCreativeSize = CGSizeMake([[AdtradeScreen mainScreen] bounds].size.width, [[AdtradeScreen mainScreen] bounds].size.height);
    }
    
    if(adImage.size.width > maxCreativeSize.width || adImage.size.height > maxCreativeSize.height || ( frameImage && (frameImage.size.width > maxCreativeSize.width || frameImage.size.height > maxCreativeSize.height))){
        return NO;
    }
    return YES;
}

#pragma mark Clicks
-(void)deleteClick:(AdtradeImpression *)impression{
    [[AdtradeAPI sharedInstance] deleteClickForImpression:[impression dictionaryRepresentation] sucess:^(NSDictionary *item) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)createClick:(AdtradeImpression *)impression{
    [[AdtradeAPI sharedInstance] createClickForImpression:[impression dictionaryRepresentation] sucess:^(NSDictionary *item) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark Devices
-(BOOL)deviceModel:(NSString *)device1 isInTheSameDeviceModelGroupAsDeviceModel:(NSString *)device2{
    NSArray *deviceModelGroups = @[@[@"iphone", @"ipod"], @[@"ipad"]];
    BOOL device1Found, device2Found = NO;
    for(NSArray *deviceModelGroup in deviceModelGroups){
        device1Found = NO;
        device2Found = NO;
        for(NSString *model in deviceModelGroup){
            if([device1.lowercaseString rangeOfString:model].location != NSNotFound){
                device1Found = YES;
            }
            if([device2.lowercaseString rangeOfString:model].location != NSNotFound){
                device2Found = YES;
            }
        }
        if(device1Found && device2Found){
            return YES;
        }
    }
    return NO;
}

#pragma mark Purchases
-(void)createPurchase:(AdtradePurchase *)purchase completionHandler:(void (^ )(AdtradePurchase *purchase, NSError *error))completionHandler{
    [[AdtradeAPI sharedInstance] createPurchase:[purchase dictionaryRepresentation] sucess:^(NSDictionary *item) {
        completionHandler([AdtradePurchase instanceFromDictionary:item], nil);
    } failure:^(NSError *error) {
        completionHandler(nil, error);
    }];
}

@end
