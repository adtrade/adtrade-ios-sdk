//
//  AdtradeAd.m
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

#import "AdtradeAd.h"

#import "AdtradeApp.h"
#import "AdtradeCreative.h"
#import "AdtradeAdType.h"
#import "AdtradeProduct.h"

@implementation AdtradeAd

@synthesize adImageLink;
@synthesize app;
@synthesize appId;
@synthesize createdAt;
@synthesize creatives;
@synthesize identifier;
@synthesize orientation;
@synthesize updatedAt;
@synthesize adType;
@synthesize offerIdentifier;
@synthesize product;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adImageLink forKey:@"adImageLink"];
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.creatives forKey:@"creatives"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.orientation forKey:@"orientation"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [encoder encodeObject:self.adType forKey:@"adType"];
    [encoder encodeObject:self.offerIdentifier forKey:@"offerIdentifier"];
    [encoder encodeObject:self.product forKey:@"product"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adImageLink = [decoder decodeObjectForKey:@"adImageLink"];
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.creatives = [decoder decodeObjectForKey:@"creatives"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.orientation = [decoder decodeObjectForKey:@"orientation"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.adType = [decoder decodeObjectForKey:@"adType"];
        self.offerIdentifier = [decoder decodeObjectForKey:@"offerIdentifier"];
        self.product = [decoder decodeObjectForKey:@"product"];
    }
    return self;
}

+ (AdtradeAd *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    AdtradeAd *instance = [[AdtradeAd alloc] init];
    @try {
        [instance setAttributesFromDictionary:aDictionary];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
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
    }else if ([key isEqualToString:@"adType"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.adType = [AdtradeAdType instanceFromDictionary:value];
        }
    }else if ([key isEqualToString:@"product"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.product = [AdtradeProduct instanceFromDictionary:value];
        }
    
    } else if ([key isEqualToString:@"creatives"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                AdtradeCreative *populatedMember = [AdtradeCreative instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }
            
            self.creatives = myMembers;
            
        }
        
    } else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"ad_image_link"]) {
        [self setValue:value forKey:@"adImageLink"];
    } else if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"ad_type"]) {
        [self setValue:value forKey:@"adType"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else if ([key isEqualToString:@"offer_identifier"]) {
        [self setValue:value forKey:@"offerIdentifier"];
    } else {
        
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.adImageLink) {
        [dictionary setObject:self.adImageLink forKey:@"adImageLink"];
    }
    
    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }
    
    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }
    
    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }
    
    if (self.creatives) {
        [dictionary setObject:self.creatives forKey:@"creatives"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.orientation) {
        [dictionary setObject:self.orientation forKey:@"orientation"];
    }
    
    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }
    
    if (self.adType) {
        [dictionary setObject:self.adType forKey:@"adType"];
    }
    
    if (self.offerIdentifier) {
        [dictionary setObject:self.offerIdentifier forKey:@"offerIdentifier"];
    }

    if (self.product) {
        [dictionary setObject:self.product forKey:@"product"];
    }
    
    return dictionary;
    
}

@end
