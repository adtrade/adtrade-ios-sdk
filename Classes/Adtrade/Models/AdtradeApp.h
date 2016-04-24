//
//  AdtradeApp.h
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

@interface AdtradeApp : NSObject <NSCoding> {
    NSMutableArray *adLogics;
    NSString *appKey;
    NSString *appStoreLink;
    NSNumber *appleId;
    NSString *bundleIdentifier;
    NSNumber *companyId;
    NSString *createdAt;
    NSString *iconImageLink;
    NSNumber *identifier;
    BOOL isKidsApp;
    NSString *name;
    NSString *orientation;
    NSString *uniqueToken;
    NSString *updatedAt;
    NSString *urlScheme;
}

@property (nonatomic, copy) NSMutableArray *adLogics;
@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appStoreLink;
@property (nonatomic, copy) NSNumber *appleId;
@property (nonatomic, copy) NSString *bundleIdentifier;
@property (nonatomic, copy) NSNumber *companyId;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *iconImageLink;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, assign) BOOL isKidsApp;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *orientation;
@property (nonatomic, copy) NSString *uniqueToken;
@property (nonatomic, copy) NSString *updatedAt;
@property (nonatomic, copy) NSString *urlScheme;

+ (AdtradeApp *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
