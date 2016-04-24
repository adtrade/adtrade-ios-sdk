#import <UIKit/UIKit.h>

@interface AdtradeAdDisplaySettings : NSObject <NSCoding> {

    NSString *adSoundLink;
    NSString *animationStyle;
    BOOL shouldPresentAppStoreInsideApp;

}

@property (nonatomic, copy) NSString *adSoundLink;
@property (nonatomic, copy) NSString *animationStyle;
@property (nonatomic, assign) BOOL shouldPresentAppStoreInsideApp;

+ (AdtradeAdDisplaySettings *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
