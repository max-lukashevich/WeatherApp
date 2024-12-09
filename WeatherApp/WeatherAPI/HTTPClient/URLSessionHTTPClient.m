//
//  URLSessionHTTPClient.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "URLSessionHTTPClient.h"

@interface UnexpectedValuesRepresentation : NSError
@end

@implementation UnexpectedValuesRepresentation
@end

@interface URLSessionHTTPClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation URLSessionHTTPClient

- (instancetype)initWithSession:(NSURLSession *)session {
    self = [super init];
    if (self) {
        _session = session;
    }
    return self;
}

- (instancetype)init {
    return [self initWithSession:[NSURLSession sharedSession]];
}

- (void)getFromURL:(NSURL *)url completion:(HTTPClientCompletion)completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request
                                                 completionHandler:^(NSData * _Nullable data,
                                                                     NSURLResponse * _Nullable response,
                                                                     NSError * _Nullable error) {
        if (error) {
            if (completion) {
                completion(HTTPClientResultFailure, nil, nil, error);
            }
        } else if (data && [response isKindOfClass:[NSHTTPURLResponse class]]) {
            if (completion) {
                completion(HTTPClientResultSuccess, data, (NSHTTPURLResponse *)response, nil);
            }
        } else {
            NSError *unexpectedError = [UnexpectedValuesRepresentation new];
            if (completion) {
                completion(HTTPClientResultFailure, nil, nil, unexpectedError);
            }
        }
    }];

    [task resume];
}

@end
