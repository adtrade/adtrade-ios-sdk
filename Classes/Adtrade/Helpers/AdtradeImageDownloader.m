//
//  AdtradeImageDownloader.m
//
//  Created by William Locke on 5/30/15.
//
//

#import "AdtradeImageDownloader.h"

@implementation AdtradeImageDownloader

+ (AdtradeImageDownloader *)sharedInstance{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+(void)downloadImage:(NSString *)imageUrl completionHandler:(void (^ )(UIImage *image))completionHandler{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image;
                                   if ([imageUrl rangeOfString:@"@2x"].location != NSNotFound) {
                                       image = [[UIImage alloc] initWithData:data scale:2.0];
                                   }else{
                                       image = [[UIImage alloc] initWithData:data];
                                   }
                                   completionHandler(image);
                               } else{
                                   completionHandler(nil);
                               }
                           }];    
}


@end
