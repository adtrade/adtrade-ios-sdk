//
//  AdtradeAdViewController.m
//
//  Created by William Locke on 5/20/15.
//
//

#import "AdtradeAdViewController.h"
#import "AdtradeApp.h"
#import "AdtradeAd.h"
#import "AdtradeImpression.h"
#import "AdtradeAnimation.h"
#import "AdtradeAdDisplaySettings.h"
#import <QuartzCore/QuartzCore.h>
#import <StoreKit/StoreKit.h>
#import "AdtradeStoreProductHandler.h"

typedef enum {
    AdtradeViewControllerAnimationStyleDefault,
    AdtradeViewControllerAnimationStyleFlipInFromLeft,
    AdtradeViewControllerAnimationStyleSlideInFromLeft
    } AdtradeViewControllerAnimationStyle;

@interface AdtradeAdViewController ()<SKStoreProductViewControllerDelegate>{
    UIView *_backgroundView;
    UIView *_adView;
    UIImageView *_frameImageView;
    UIButton *_adButton;
    UIButton *_closeButton;
    float _animationDuration;
    UIButton *_removeAdsButton;
    CATransform3D _transformStartingPositionForFlipInFromLeftAnimation;
    CATransform3D _transformMiddlePositionForFlipInFromLeftAnimation;
    CATransform3D _transformEndingPositionForFlipInFromLeftAnimation;
    int _animationStyle;
    UIView *_activityIndicatorView;
}

@end

@implementation AdtradeAdViewController

- (id)init{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _animationDuration = 0.3;
        _animationStyle = AdtradeViewControllerAnimationStyleFlipInFromLeft;
        [self layout];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layout{
    CGRect zeroedFullScreenFrame = CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    if (self.creative.orientation && [self.creative.orientation isEqualToString:@"Landscape"]) {
        zeroedFullScreenFrame = CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }
    
    self.view = [[UIView alloc] initWithFrame:zeroedFullScreenFrame];
    CGSize frameSize = self.frameImage.size;
    _frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - frameSize.width) / 2.0, (self.view.frame.size.height - frameSize.height) / 2.0, frameSize.width, frameSize.height)];
    
    _frameImageView.image = self.frameImage;
    
    CGSize adSize = self.adImage.size;
    CGRect frame = CGRectMake((self.view.frame.size.width - adSize.width) / 2.0, (self.view.frame.size.height - adSize.height) / 2.0, adSize.width, adSize.height);
    _adButton = [[UIButton alloc] initWithFrame:frame];
    
    if(self.adImage != nil){
        [_adButton setImage:self.adImage forState:UIControlStateNormal];
    }
    
    [_adButton addTarget:self action:@selector(adPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *deviceSpecificImageName = @"close~iphone.png";
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [[UIScreen mainScreen] bounds].size.width == 768){
        deviceSpecificImageName = @"close~ipad.png";
    }
    
    UIImage *closeButtonImage = [UIImage imageNamed:@"Adtrade.bundle/close.png"];
    CGSize closeButtonSize = closeButtonImage.size;
    CGRect closeButtonFrame = CGRectMake(_frameImageView.frame.origin.x + _frameImageView.frame.size.width - closeButtonSize.width * 0.7, _frameImageView.frame.origin.y - closeButtonSize.height * 0.3, closeButtonSize.width, closeButtonSize.height);
    _closeButton = [[UIButton alloc] initWithFrame:closeButtonFrame];
    
    if(closeButtonImage != nil){
        [_closeButton setImage:closeButtonImage forState:UIControlStateNormal];
    }
    
    [_closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _adView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_adView];
    [_adView addSubview:_frameImageView];
    [_adView addSubview:_adButton];
    [_adView addSubview:_closeButton];
}

#pragma mark Retrieve Application's UIElements
-(UIViewController *)applicationsCurrentRootViewController{
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if (!(self.creative && self.creative.orientation && [[self.creative.orientation lowercaseString] isEqualToString:@"portrait"])) {
        while ([rootViewController isKindOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UINavigationController class]]) {
            if ([rootViewController isKindOfClass:[UITabBarController class]]){
                rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
            }else if ([rootViewController isKindOfClass:[UINavigationController class]]){
                rootViewController = ((UINavigationController *)rootViewController).topViewController;
            }
        }
    }
    return rootViewController;
}


-(UIView *)newActivityIndicatorView{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    UIView *view;
    if(rootViewController){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height)];
    }else{
        view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(view.frame.size.width * 0.4, view.frame.size.height * 0.4, view.frame.size.width * 0.2, view.frame.size.height * 0.2);
    [activityIndicatorView startAnimating];

    [view addSubview:activityIndicatorView];
    return view;
}


#pragma mark Show / Hide
-(void)show{
    UIViewController *rootViewController = [self applicationsCurrentRootViewController];
    UIWindow *window = nil;
    UIView *view = rootViewController.view;
    if(window){
        [self showInView:window];
    }else{
        [self showInView:view];
    }
}

-(void)showInView:(UIView *)view{
    if(self.adImage && self.adImage.size.width > 0 && self.frameImage && self.frameImage > 0){
        [self layout];
    }else{
        return;
    }
    
    [self showInView:view withAnimationStyle:_animationStyle];
}

-(void)showInView:(UIView *)view withAnimationStyle:(AdtradeViewControllerAnimationStyle)animationStyle{
    if (self.impression.adDisplaySettings.shouldPresentAppStoreInsideApp) {
        [[AdtradeStoreProductHandler sharedInstance] loadProductDataForAppStoreLink:self.impression.ad.app.appStoreLink completionHandler:^(BOOL success) {
        }];
    }
    [self showBackgroundViewInView:view];
    [view addSubview:self.view];
    switch (animationStyle) {
        case AdtradeViewControllerAnimationStyleFlipInFromLeft:
            [[AdtradeAnimation sharedInstance] presentViewWithAnimationStyleFlip:_adView];
            break;
        case AdtradeViewControllerAnimationStyleSlideInFromLeft:
            [[AdtradeAnimation sharedInstance] presentViewWithAnimationStyleSlide:_adView];
            break;
        default:
            [[AdtradeAnimation sharedInstance] presentViewWithAnimationStyleSlide:_adView];
            break;
    }
}

-(void)showBackgroundViewInView:(UIView *)view{
    self.view.backgroundColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [view addSubview:backgroundView];
    UIColor *backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:_animationDuration animations:^{
        backgroundView.backgroundColor = backgroundColor;
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
        self.view.backgroundColor = backgroundColor;
    }];
}

#pragma mark -- Dismiss Elements
-(void)dismissBackgroundView{
    UIView *view = self.view.superview;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    UIColor *backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    backgroundView.backgroundColor = backgroundColor;
    
    [view insertSubview:backgroundView belowSubview:self.view];
    self.view.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        backgroundView.backgroundColor = [UIColor clearColor];
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}

-(void)dismissAdViewWithAnimationStyle:(AdtradeViewControllerAnimationStyle)animationStyle completionHandler:(void (^ )(BOOL finished))completionHandler{

    switch (animationStyle) {
        case AdtradeViewControllerAnimationStyleFlipInFromLeft:
            [[AdtradeAnimation sharedInstance] dismissView:_adView withAnimationStyleFlip:completionHandler];
            break;
        case AdtradeViewControllerAnimationStyleSlideInFromLeft:
            [[AdtradeAnimation sharedInstance] dismissView:_adView withAnimationStyleSlide:completionHandler];
            break;
        default:
            [[AdtradeAnimation sharedInstance] dismissView:_adView withAnimationStyleSlide:completionHandler];
            break;
    }
}

-(void)dismiss{
    UIView *view = self.view.superview;
    if(!view){
        return;
    }
    [self dismissBackgroundView];
    [self dismissAdViewWithAnimationStyle:_animationStyle completionHandler:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    
}

#pragma mark Data
-(NSNumber *)itunesItemIdentifierFromUrlString:(NSString *)urlString{
    NSNumber *iTunesItemIdentifier = nil;
    if(urlString){
        NSRange appIdRange = [urlString rangeOfString:@"/id"];
        NSRange questionMarkRange = [urlString rangeOfString:@"?"];
        
        if(appIdRange.location != NSNotFound && questionMarkRange.location != NSNotFound){
            NSString *substring = [[urlString substringToIndex:questionMarkRange.location] substringFromIndex:appIdRange.location + 3];
            if([substring intValue] > 0){
                iTunesItemIdentifier = [NSNumber numberWithInt:[substring intValue]];
            }
        }
    }
    return iTunesItemIdentifier;
}

#pragma mark IBActions
-(IBAction)closeButtonPressed:(id)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(willCloseImpression:)]){
        [self.delegate willCloseImpression:self.impression];
    }
    
    [self dismiss];
}

-(IBAction)adPressed:(id)sender{
    if(self.impression){
        self.impression.clicked = YES;
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickImpression:)]){
            [self.delegate didClickImpression:self.impression];
        }
        
        UIViewController *rootViewController = [self applicationsCurrentRootViewController];
        NSURL *url = [NSURL URLWithString:self.impression.ad.app.appStoreLink];
        
        // Note! Opening URL in app store inside app happens inside the conditional!
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 && self.impression.adDisplaySettings.shouldPresentAppStoreInsideApp){
            if([[AdtradeStoreProductHandler sharedInstance] appStoreLinkLoaded:self.impression.ad.app.appStoreLink]){
                [[AdtradeStoreProductHandler sharedInstance] openInRootViewController:rootViewController completionHandler:^(BOOL success) {
                }];
            }else{
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    [self dismiss];
}

@end
