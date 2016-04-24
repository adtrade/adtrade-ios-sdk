//
//  Adtrade.m
//
//  Created by William Locke on 4/9/15.
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
#import "AdtradeCore.h"
#import "AdtradeAPI.h"

@interface Adtrade()<AdtradeAdViewControllerDelegate>
@end

@implementation Adtrade

- (id)init
{
    self = [super init];
    if (self) {
        [AdtradeCore sharedInstance];
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
-(void)startWithAppKey:(NSString *)appKey{
    [[AdtradeCore sharedInstance] startSessionUsingAppKey:appKey];
}

- (void)showInterstitial{
    [self showInterstitial:@""];
}

-(void)showInterstitial:(NSString *)zone{
    [self showInterstitial:zone withSuccess:nil failure:nil];
}

-(void)showInterstitial:(NSString *)zone withSuccess:(void (^ )())success failure:(void (^ )(NSError *error))failure{
    [[AdtradeCore sharedInstance] showInterstitial:zone withSuccessHandler:success errorHandler:failure];
}

#pragma mark Delegate
-(void)didClickImpression:(AdtradeImpression *)impression{
    [[AdtradeCore sharedInstance] createClick:impression];
    if(self.delegate && [self.delegate respondsToSelector:@selector(adtradeDidPressInterstitial)]){
        [self.delegate adtradeDidPressInterstitial];
    }
}

-(void)willCloseImpression:(AdtradeImpression *)impression{
    if(!impression.clicked){
        [[AdtradeCore sharedInstance] deleteClick:impression];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(adtradeDidCloseInterstitial)]) {
        [self.delegate adtradeDidCloseInterstitial];
    }
}

-(void)didPressRemoveAds{
    if(self.delegate && [self.delegate respondsToSelector:@selector(adtradeDidPressInterstitial)]){
        [self.delegate adtradeDidPressInterstitial];
    }
}

+(void)setServer:(NSString *)serverURL{
    [[AdtradeAPI sharedInstance] setServer:serverURL];
}

@end
