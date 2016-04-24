#import "AdtradeProduct.h"

@implementation AdtradeProduct

@synthesize appId;
@synthesize companyId;
@synthesize identifier;
@synthesize localizedTitle;
@synthesize price;
@synthesize priceLocale;
@synthesize priceTier;
@synthesize productIdentifier;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.companyId forKey:@"companyId"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.localizedTitle forKey:@"localizedTitle"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.priceLocale forKey:@"priceLocale"];
    [encoder encodeObject:self.priceTier forKey:@"priceTier"];
    [encoder encodeObject:self.productIdentifier forKey:@"productIdentifier"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.companyId = [decoder decodeObjectForKey:@"companyId"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.localizedTitle = [decoder decodeObjectForKey:@"localizedTitle"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.priceLocale = [decoder decodeObjectForKey:@"priceLocale"];
        self.priceTier = [decoder decodeObjectForKey:@"priceTier"];
        self.productIdentifier = [decoder decodeObjectForKey:@"productIdentifier"];
    }
    return self;
}

+ (AdtradeProduct *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    AdtradeProduct *instance = [[AdtradeProduct alloc] init];
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
    
    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"company_id"]) {
        [self setValue:value forKey:@"companyId"];
    } else if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else if ([key isEqualToString:@"localized_title"]) {
        [self setValue:value forKey:@"localizedTitle"];
    } else if ([key isEqualToString:@"price_locale"]) {
        [self setValue:value forKey:@"priceLocale"];
    } else if ([key isEqualToString:@"price_tier"]) {
        [self setValue:value forKey:@"priceTier"];
    } else if ([key isEqualToString:@"product_identifier"]) {
        [self setValue:value forKey:@"productIdentifier"];
    } else {
        //[super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }
    
    if (self.companyId) {
        [dictionary setObject:self.companyId forKey:@"companyId"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.localizedTitle) {
        [dictionary setObject:self.localizedTitle forKey:@"localizedTitle"];
    }
    
    if (self.price) {
        [dictionary setObject:self.price forKey:@"price"];
    }
    
    if (self.priceLocale) {
        [dictionary setObject:self.priceLocale forKey:@"priceLocale"];
    }
    
    if (self.priceTier) {
        [dictionary setObject:self.priceTier forKey:@"priceTier"];
    }
    
    if (self.productIdentifier) {
        [dictionary setObject:self.productIdentifier forKey:@"productIdentifier"];
    }
    
    return dictionary;
    
}


@end
