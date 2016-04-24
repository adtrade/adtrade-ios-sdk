//
//  AdtradeScreen.m
//
//  Created by William Locke on 2/19/15.
//

#import "AdtradeScreen.h"

@implementation AdtradeScreen

+(AdtradeScreen *)mainScreen{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[AdtradeScreen alloc] init];
    });
    return _sharedObject;
}

-(CGRect)bounds{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    if (bounds.size.width > bounds.size.height) {
        bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width);
    }
    
    return bounds;
}

@end
