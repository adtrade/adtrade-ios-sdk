//
//  AdtradeImpression.h
//
//
// Created by William Locke on 6/14/15.
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

@class AdtradeAd;
@class AdtradeApp;
@class AdtradeAdDisplaySettings;
@class AdtradeDevice;
@class AdtradeCreative;


@interface AdtradeImpression : NSObject <NSCoding> {
    AdtradeAd *ad;
    NSNumber *adId;
    NSNumber *advertisingCampaignId;
    AdtradeApp *app;
    NSNumber *appId;
    NSNumber *campaignId;
    BOOL clicked;
    BOOL clickedProxy;
    NSString *createdAt;
    NSNumber *deviceId;
    AdtradeDevice *device;
    NSNumber *identifier;
    BOOL installed;
    BOOL maxPerDayReached;
    BOOL maxPerHourReached;
    NSNumber *publishingCampaignId;
    NSString *uniqueToken;
    NSString *updatedAt;
    AdtradeAdDisplaySettings *adDisplaySettings;
    BOOL shown;
}

@property (nonatomic, strong) AdtradeAd *ad;
@property (nonatomic, copy) NSNumber *adId;
@property (nonatomic, copy) NSNumber *advertisingCampaignId;
@property (nonatomic, strong) AdtradeApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSNumber *campaignId;
@property (nonatomic, assign) BOOL clicked;
@property (nonatomic, assign) BOOL clickedProxy;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, strong) AdtradeDevice *device;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, assign) BOOL installed;
@property (nonatomic, assign) BOOL maxPerDayReached;
@property (nonatomic, assign) BOOL maxPerHourReached;
@property (nonatomic, copy) NSNumber *publishingCampaignId;
@property (nonatomic, copy) NSString *uniqueToken;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, strong) AdtradeAdDisplaySettings *adDisplaySettings;
@property (nonatomic, assign) BOOL shown;


// Non-remote object related fields
@property (nonatomic, strong) AdtradeCreative *selectedCreative;
@property (nonatomic, copy) NSString *zone;

+ (AdtradeImpression *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
