#import <UIKit/UIKit.h>

@class AdtradeApp;
@class AdtradeDevice;

@interface AdtradePurchase : NSObject <NSCoding> {

    AdtradeApp *app;
    NSNumber *appId;
    AdtradeDevice *device;
    NSNumber *deviceId;
    NSNumber *identifier;
    NSString *localizedTitle;
    NSNumber *price;
    NSString *priceLocale;
    NSString *productIdentifier;

}

@property (nonatomic, strong) AdtradeApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, strong) AdtradeDevice *device;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *localizedTitle;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *priceLocale;
@property (nonatomic, copy) NSString *productIdentifier;


+ (AdtradePurchase *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
