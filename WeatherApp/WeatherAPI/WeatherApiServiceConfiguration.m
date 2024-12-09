//
//  WeatherServiceConfiguration.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "WeatherApiServiceConfiguration.h"

@implementation WeatherApiServiceConfiguration

- (instancetype)initWithBaseURL:(NSString *)baseURL apiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        _baseURL = [NSString stringWithFormat:@"%@/data/2.5/weather?appid=%@", baseURL, apiKey];
    }
    return self;
}

@end
