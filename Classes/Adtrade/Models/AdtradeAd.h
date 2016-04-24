//
//  AdtradeAd.h
//
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

@class AdtradeApp;
@class AdtradeAdType;
@class AdtradeProduct;


@interface AdtradeAd : NSObject <NSCoding> {
    NSString *adImageLink;
    AdtradeApp *app;
    NSNumber *appId;
    NSString *createdAt;
    NSMutableArray *creatives;
    NSNumber *identifier;
    NSString *orientation;
    NSString *updatedAt;
    AdtradeAdType *adType;
    AdtradeProduct *product;
}

@property (nonatomic, copy) NSString *adImageLink;
@property (nonatomic, strong) AdtradeApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSMutableArray *creatives;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, strong) AdtradeAdType *adType;
@property (nonatomic, copy) NSString *offerIdentifier;
@property (nonatomic, strong) AdtradeProduct *product;

+ (AdtradeAd *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
