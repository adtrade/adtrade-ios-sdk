//
//  AdtradeImageDownloader.h
//
//  Created by William Locke on 5/30/15.
//
//

#import <UIKit/UIKit.h>


@interface AdtradeImageDownloader : NSObject

@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSURLConnection *connection;

+(void)downloadImage:(NSString *)imageUrl completionHandler:(void (^ )(UIImage *image))completionHandler;

@end
