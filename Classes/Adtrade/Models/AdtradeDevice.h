//
//  AdtradeDevice.h
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

@interface AdtradeDevice : NSObject <NSCoding> {
    NSString *advertisingIdentifier;
    NSString *countryCode;
    NSString *createdAt;
    NSString *deviceType;
    NSNumber *identifier;
    NSString *identifierForVendor;
    NSString *model;
    NSString *openUdid;
    NSString *osVersion;
    NSString *screenScale;
    NSString *updatedAt;
}

@property (nonatomic, copy) NSString *advertisingIdentifier;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *identifierForVendor;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *openUdid;
@property (nonatomic, copy) NSString *osVersion;
@property (nonatomic, copy) NSString *screenScale;
@property (nonatomic, copy) NSString *updatedAt;

+ (AdtradeDevice *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
