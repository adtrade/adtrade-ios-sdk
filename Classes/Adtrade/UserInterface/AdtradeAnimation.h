//
//  AdtradeAnimation.h
//
//  Created by William Locke on 10/30/15.
//

#import <UIKit/UIKit.h>

@interface AdtradeAnimation : NSObject

@property float animationDuration;

+ (AdtradeAnimation *)sharedInstance;

-(void)presentViewWithAnimationStyleFlip:(UIView *)view;
-(void)presentViewWithAnimationStyleSlide:(UIView *)view;
-(void)dismissView:(UIView *)view withAnimationStyleFlip:(void (^ )(BOOL finished))completionHandler;
-(void)dismissView:(UIView *)view withAnimationStyleSlide:(void (^ )(BOOL finished))completionHandler;

-(void)dismissView:(UIView *)view withAnimationStyleNone:(void (^ )(BOOL finished))completionHandler;


-(void)presentViewWithAnimationStyleBounce:(UIView *)view;

@end
