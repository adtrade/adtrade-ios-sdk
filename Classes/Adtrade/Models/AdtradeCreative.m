//
//  AdtradeCreative.m
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

#import "AdtradeCreative.h"

@implementation AdtradeCreative

@synthesize adImageLink;
@synthesize frameImageLink;
@synthesize identifier;
@synthesize model;
@synthesize orientation;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adImageLink forKey:@"adImageLink"];
    [encoder encodeObject:self.frameImageLink forKey:@"frameImageLink"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.orientation forKey:@"orientation"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adImageLink = [decoder decodeObjectForKey:@"adImageLink"];
        self.frameImageLink = [decoder decodeObjectForKey:@"frameImageLink"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.model = [decoder decodeObjectForKey:@"model"];
        self.orientation = [decoder decodeObjectForKey:@"orientation"];
    }
    return self;
}

+ (AdtradeCreative *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    AdtradeCreative *instance = [[AdtradeCreative alloc] init];
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

    if ([key isEqualToString:@"ad_image_link"]) {
        [self setValue:value forKey:@"adImageLink"];
    } else if ([key isEqualToString:@"frame_image_link"]) {
        [self setValue:value forKey:@"frameImageLink"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else {
//        [super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.adImageLink) {
        [dictionary setObject:self.adImageLink forKey:@"adImageLink"];
    }

    if (self.frameImageLink) {
        [dictionary setObject:self.frameImageLink forKey:@"frameImageLink"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.model) {
        [dictionary setObject:self.model forKey:@"model"];
    }

    if (self.orientation) {
        [dictionary setObject:self.orientation forKey:@"orientation"];
    }

    return dictionary;

}

@end
