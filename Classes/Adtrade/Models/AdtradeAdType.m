#import "AdtradeAdType.h"

@implementation AdtradeAdType

@synthesize identifier;
@synthesize name;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

+ (AdtradeAdType *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    AdtradeAdType *instance = [[AdtradeAdType alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
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

    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else {
        //[super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }

    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }

    return dictionary;

}


@end
