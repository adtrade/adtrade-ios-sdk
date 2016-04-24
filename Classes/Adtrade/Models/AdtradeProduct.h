#import <Foundation/Foundation.h>

@interface AdtradeProduct : NSObject <NSCoding> {
    
    NSNumber *appId;
    NSNumber *companyId;
    NSNumber *identifier;
    NSString *localizedTitle;
    NSNumber *price;
    NSString *priceLocale;
    NSNumber *priceTier;
    NSString *productIdentifier;
    
}

@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSNumber *companyId;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *localizedTitle;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *priceLocale;
@property (nonatomic, copy) NSNumber *priceTier;
@property (nonatomic, copy) NSString *productIdentifier;

+ (AdtradeProduct *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
