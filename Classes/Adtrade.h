// Adtrade.h
//
// Created by William Locke on 4/9/15.
//
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

@class Adtrade;

@protocol AdtradeDelegate <NSObject>
@optional
-(void)adtradeDidPressInterstitial;

@optional
-(void)adtradeDidCloseInterstitial;
@end

@interface Adtrade : NSObject

@property (nonatomic, strong) id <AdtradeDelegate> delegate;

+ (Adtrade *)sharedInstance;


///---------------------------------------------------------------------------------------
/// @name Configure
///---------------------------------------------------------------------------------------
/** Start SDK with app key.
 
 @param appKey App key from your Adtrade dashboard.
 */
-(void)startWithAppKey:(NSString *)appKey;


///---------------------------------------------------------------------------------------
/// @name Interstitials
///---------------------------------------------------------------------------------------
/** Show interstitial
 @param zone Pass in ad zone, or nil.
 @param success Block executed when interstitial is successfully shown.
 @param failure Block passes back `NSError` object describing error that occurred. See userInfo[NSLocalizedDescriptionKey] for description of error.
 */
-(void)showInterstitial:(NSString *)zone withSuccess:(void (^ )())success failure:(void (^ )(NSError *error))failure;


///---------------------------------------------------------------------------------------
/// @name Server
///---------------------------------------------------------------------------------------
/** Set server URL, e.g. http://localhost:3000/api/
 
 @param serverUrl API URL you want to point to (defaults to https://api.adtrade.com/api )
 */
-(void)setServer:(NSString *)serverURL;


@end
