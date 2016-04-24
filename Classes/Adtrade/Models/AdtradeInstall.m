//
//  AdtradeInstall.m
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

#import "AdtradeInstall.h"

#import "AdtradeApp.h"
#import "AdtradeDevice.h"
#import "AdtradeImpression.h"

@implementation AdtradeInstall

@synthesize app;
@synthesize appId;
@synthesize device;
@synthesize deviceId;
@synthesize identifier;
@synthesize impression;
@synthesize impressionId;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.device forKey:@"device"];
    [encoder encodeObject:self.deviceId forKey:@"deviceId"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.impression forKey:@"impression"];
    [encoder encodeObject:self.impressionId forKey:@"impressionId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.device = [decoder decodeObjectForKey:@"device"];
        self.deviceId = [decoder decodeObjectForKey:@"deviceId"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.impression = [decoder decodeObjectForKey:@"impression"];
        self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
    }
    return self;
}

+ (AdtradeInstall *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    AdtradeInstall *instance = [[AdtradeInstall alloc] init];
    
    @try {
        [instance setAttributesFromDictionary:aDictionary];
    }
    @catch (NSException *exception) {

    }    
    return instance;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"app"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.app = [AdtradeApp instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"device"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.device = [AdtradeDevice instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"impression"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.impression = [AdtradeImpression instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"device_id"]) {
        [self setValue:value forKey:@"deviceId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"impression_id"]) {
        [self setValue:value forKey:@"impressionId"];
    } else {
//        [super setValue:value forUndefinedKey:key];
        
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }

    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }

    if (self.device) {
        [dictionary setObject:self.device forKey:@"device"];
    }

    if (self.deviceId) {
        [dictionary setObject:self.deviceId forKey:@"deviceId"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.impression) {
        [dictionary setObject:self.impression forKey:@"impression"];
    }

    if (self.impressionId) {
        [dictionary setObject:self.impressionId forKey:@"impressionId"];
    }

    return dictionary;

}

@end
