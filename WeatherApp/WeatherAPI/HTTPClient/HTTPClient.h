//
//  HTTPClient.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#ifndef HTTPClient_h
#define HTTPClient_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HTTPClientResult) {
    HTTPClientResultSuccess,
    HTTPClientResultFailure
};

typedef void (^HTTPClientCompletion)(HTTPClientResult result, NSData * _Nullable data, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error);

@protocol HTTPClient <NSObject>
- (void)getFromURL:(NSURL *)url completion:(HTTPClientCompletion)completion;
@end

NS_ASSUME_NONNULL_END

#endif /* HTTPClient_h */
