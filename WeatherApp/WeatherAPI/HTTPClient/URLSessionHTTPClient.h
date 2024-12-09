//
//  URLSessionHTTPClient.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface URLSessionHTTPClient : NSObject <HTTPClient>

- (instancetype)initWithSession:(NSURLSession *)session;
- (void)getFromURL:(NSURL *)url completion:(HTTPClientCompletion)completion;

@end

NS_ASSUME_NONNULL_END
