//
//  AdtradeAdViewController.h
//
//  Created by William Locke on 5/20/15.
//
//

#import <UIKit/UIKit.h>
#import "AdtradeImpression.h"
#import "AdtradeCreative.h"
@class AdtradeAdViewController;

@protocol AdtradeAdViewControllerDelegate <NSObject>

@optional
-(void)willCloseImpression:(AdtradeImpression *)impression;

@optional
-(void)didClickImpression:(AdtradeImpression *)impression;

@optional
-(void)didPressRemoveAds;

@optional
-(void)didPurchaseProduct:(NSString *)productIdentifier;

@end

@interface AdtradeAdViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<AdtradeAdViewControllerDelegate> delegate;
@property (nonatomic, strong) AdtradeImpression *impression;
@property (nonatomic, strong) AdtradeCreative *creative;
@property (nonatomic, strong) UIImage *adImage;
@property (nonatomic, strong) UIImage *frameImage;

- (id)init;

#pragma mark Navigation
-(void)show;
-(void)dismiss;

@end
