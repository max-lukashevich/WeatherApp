//
//  WeatherService.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "WeatherApiService.h"
#import "WeatherServiceMapper.h"
#import "WeatherApp-Swift.h"
#import "URLSessionHTTPClient.h"

@interface WeatherApiService ()

@property (nonatomic, strong) URLSessionHTTPClient *httpClient;

@end

@implementation WeatherApiService

- (instancetype)initWithConfiguration:(WeatherApiServiceConfiguration *)configuration {
    self = [super init];
    if (self) {
        _httpClient = [[URLSessionHTTPClient alloc] initWithSession:[NSURLSession sharedSession]];
        _configuration = configuration;
    }
    return self;
}

- (NSString *)encodeForURL:(NSString *)stringToEncode {
    return [stringToEncode stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSURL *)urlForCity:(NSString *)cityName {
    NSString *encodedCityName = [self encodeForURL:cityName];
    NSString *urlString = [NSString stringWithFormat:@"%@&q=%@", self.configuration.baseURL, encodedCityName];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (void)handleError:(NSError *)error completion:(void (^)(RemoteCityModel * _Nullable, NSError * _Nullable))completion {
    completion(nil, error);
}

- (void)handleData:(NSData *)data response:(NSHTTPURLResponse *)response completion:(void (^)(RemoteCityModel * _Nullable, NSError * _Nullable))completion {
    NSError *jsonError;

    RemoteCityModel *model = [WeatherServiceMapper mapCityData:data fromResponse:response error:&jsonError];

    if (jsonError) {
        [self handleError:jsonError completion:completion];
    } else {
        completion(model, nil);
    }
}

- (void)fetchWeatherForCity:(NSString *)cityName
                 completion:(void (^)(RemoteCityModel * _Nullable, NSError * _Nullable))completion {
    __weak typeof(self) weakSelf = self;

    [_httpClient getFromURL:[self urlForCity:cityName]
                 completion:^(HTTPClientResult result,
                              NSData * _Nullable data,
                              NSHTTPURLResponse * _Nullable response,
                              NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) return;

        if (error) {
            [strongSelf handleError:error completion:completion];
            return;
        }

        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (data) {
                [strongSelf handleData:data response:httpResponse completion:completion];
            } else {
                [strongSelf handleError:[NSErrorHelper weatherAppErrorWithCode:0 description:@"Unknown error occurred"] completion:completion];
            }
        } else {
            [strongSelf handleError:[NSErrorHelper weatherAppErrorWithCode:0 description:@"Unexpected API response"] completion:completion];
        }
    }];
}

@end
