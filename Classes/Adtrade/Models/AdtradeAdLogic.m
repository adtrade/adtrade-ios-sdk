//
//  AdtradeAdLogic.m
//  
//
// Created by William Locke on 6/5/15.
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

#import "AdtradeAdLogic.h"

@implementation AdtradeAdLogic

@synthesize appId;
@synthesize createdAt;
@synthesize identifier;
@synthesize maxPerDay;
@synthesize maxPerHour;
@synthesize updatedAt;
@synthesize zone;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.createdAt forKey:@"createdAt"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.maxPerDay forKey:@"maxPerDay"];
    [encoder encodeObject:self.maxPerHour forKey:@"maxPerHour"];
    [encoder encodeObject:self.updatedAt forKey:@"updatedAt"];
    [encoder encodeObject:self.zone forKey:@"zone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.createdAt = [decoder decodeObjectForKey:@"createdAt"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.maxPerDay = [decoder decodeObjectForKey:@"maxPerDay"];
        self.maxPerHour = [decoder decodeObjectForKey:@"maxPerHour"];
        self.updatedAt = [decoder decodeObjectForKey:@"updatedAt"];
        self.zone = [decoder decodeObjectForKey:@"zone"];
    }
    return self;
}

+ (AdtradeAdLogic *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    AdtradeAdLogic *instance = [[AdtradeAdLogic alloc] init];
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

    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"created_at"]) {
        [self setValue:value forKey:@"createdAt"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"max_per_day"]) {
        [self setValue:value forKey:@"maxPerDay"];
    } else if ([key isEqualToString:@"max_per_hour"]) {
        [self setValue:value forKey:@"maxPerHour"];
    } else if ([key isEqualToString:@"updated_at"]) {
        [self setValue:value forKey:@"updatedAt"];
    } else {
//        [super setValue:value forUndefinedKey:key];
        
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }

    if (self.createdAt) {
        [dictionary setObject:self.createdAt forKey:@"createdAt"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.maxPerDay) {
        [dictionary setObject:self.maxPerDay forKey:@"maxPerDay"];
    }

    if (self.maxPerHour) {
        [dictionary setObject:self.maxPerHour forKey:@"maxPerHour"];
    }

    if (self.updatedAt) {
        [dictionary setObject:self.updatedAt forKey:@"updatedAt"];
    }

    if (self.zone) {
        [dictionary setObject:self.zone forKey:@"zone"];
    }

    return dictionary;

}

@end
