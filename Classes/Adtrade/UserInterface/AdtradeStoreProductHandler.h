//
//  AdtradeStoreProductViewController.h
//
//  Created by William Locke on 10/3/15.
//
//

#import <StoreKit/StoreKit.h>

@interface AdtradeStoreProductHandler : SKStoreProductViewController

@property (nonatomic, strong) SKStoreProductViewController *storeViewController;
@property (nonatomic, copy) NSString *appStoreLink;
@property BOOL loaded;

+ (id)sharedInstance;


-(void)loadProductDataForAppStoreLink:(NSString *)appStoreLink completionHandler:(void (^ )(BOOL success))completionHandler;
-(BOOL)appStoreLinkLoaded:(NSString *)appStoreLink;
-(void)openInRootViewController:(UIViewController *)rootViewController completionHandler:(void (^ )(BOOL success))completionHandler;


@end
