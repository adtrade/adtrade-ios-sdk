//
// AdtradeCore.m
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

#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import "AdtradeAdViewController.h"
#import "AdtradeModels.h"

@class AdtradeCore;

@class AdtradeAdViewController;

@interface AdtradeCore : NSObject

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, strong) AdtradeAdViewController *adViewController;
@property (nonatomic, strong) AdtradeDevice *device;
@property (nonatomic, strong) AdtradeApp *app;

+ (AdtradeCore *)sharedInstance;

-(void)showInterstitial:(NSString *)zone withSuccessHandler:(void (^ )())successHandler errorHandler:(void (^ )(NSError *error))errorHandler;

-(void)startSessionUsingAppKey:(NSString *)appKey;

#pragma mark Clicks
-(void)deleteClick:(AdtradeImpression *)impression;
-(void)createClick:(AdtradeImpression *)impression;

@end

