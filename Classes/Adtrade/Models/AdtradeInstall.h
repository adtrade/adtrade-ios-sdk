//
//  AdtradeInstall.h
//  
//
// Created by William Locke on 5/30/15.
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
@class AdtradeDevice;
@class AdtradeImpression;

@interface AdtradeInstall : NSObject <NSCoding> {
    AdtradeApp *app;
    NSNumber *appId;
    AdtradeDevice *device;
    NSNumber *deviceId;
    NSNumber *identifier;
    AdtradeImpression *impression;
    NSNumber *impressionId;
}

@property (nonatomic, strong) AdtradeApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, strong) AdtradeDevice *device;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, strong) AdtradeImpression *impression;
@property (nonatomic, copy) NSNumber *impressionId;

+ (AdtradeInstall *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
