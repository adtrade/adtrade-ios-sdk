#import <Foundation/Foundation.h>

@interface AdtradeAdType : NSObject <NSCoding> {

    NSNumber *identifier;
    NSString *name;

}

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;

+ (AdtradeAdType *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
