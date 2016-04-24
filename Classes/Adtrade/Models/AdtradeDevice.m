//
//  AdtradeDevice.m
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

#import "AdtradeDevice.h"

@implementation AdtradeDevice

@synthesize advertisingIdentifier;
@synthesize countryCode;
@synthesize createdAt;
@synthesize deviceType;
@synthesize identifier;
@synthesize identifierForVendor;
@synthesize model;
@synthesize openUdid;
@synthesize osVersion;
@synthesize screenScale;
@synthesize updatedAt;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.advertisingIdentifier forKey:@"advertisingIdentifier"];
    [encoder encodeObject:self.countryCode forKey:@"countryCode"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.deviceType forKey:@"deviceType"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.identifierForVendor forKey:@"identifierForVendor"];
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.openUdid forKey:@"openUdid"];
    [encoder encodeObject:self.osVersion forKey:@"osVersion"];
    [encoder encodeObject:self.screenScale forKey:@"screenScale"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.advertisingIdentifier = [decoder decodeObjectForKey:@"advertisingIdentifier"];
        self.countryCode = [decoder decodeObjectForKey:@"countryCode"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.deviceType = [decoder decodeObjectForKey:@"deviceType"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.identifierForVendor = [decoder decodeObjectForKey:@"identifierForVendor"];
        self.model = [decoder decodeObjectForKey:@"model"];
        self.openUdid = [decoder decodeObjectForKey:@"openUdid"];
        self.osVersion = [decoder decodeObjectForKey:@"osVersion"];
        self.screenScale = [decoder decodeObjectForKey:@"screenScale"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
    }
    return self;
}

+ (AdtradeDevice *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    AdtradeDevice *instance = [[AdtradeDevice alloc] init];
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"advertising_identifier"]) {
        [self setValue:value forKey:@"advertisingIdentifier"];
    } else if ([key isEqualToString:@"country_code"]) {
        [self setValue:value forKey:@"countryCode"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"device_type"]) {
        [self setValue:value forKey:@"deviceType"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"identifier_for_vendor"]) {
        [self setValue:value forKey:@"identifierForVendor"];
    } else if ([key isEqualToString:@"open_udid"]) {
        [self setValue:value forKey:@"openUdid"];
    } else if ([key isEqualToString:@"os_version"]) {
        [self setValue:value forKey:@"osVersion"];
    } else if ([key isEqualToString:@"screen_scale"]) {
        [self setValue:value forKey:@"screenScale"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {

    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.advertisingIdentifier) {
        [dictionary setObject:self.advertisingIdentifier forKey:@"advertisingIdentifier"];
    }
    
    if (self.countryCode) {
        [dictionary setObject:self.countryCode forKey:@"countryCode"];
    }
    
    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }
    
    if (self.deviceType) {
        [dictionary setObject:self.deviceType forKey:@"deviceType"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.identifierForVendor) {
        [dictionary setObject:self.identifierForVendor forKey:@"identifierForVendor"];
    }
    
    if (self.model) {
        [dictionary setObject:self.model forKey:@"model"];
    }
    
    if (self.openUdid) {
        [dictionary setObject:self.openUdid forKey:@"openUdid"];
    }
    
    if (self.osVersion) {
        [dictionary setObject:self.osVersion forKey:@"osVersion"];
    }
    
    if (self.screenScale) {
        [dictionary setObject:self.screenScale forKey:@"screenScale"];
    }
    
    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }
    
    return dictionary;
    
}

@end
