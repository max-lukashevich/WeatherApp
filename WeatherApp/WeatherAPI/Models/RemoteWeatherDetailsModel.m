//
//  RemoteCityDetailsModel.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "RemoteWeatherDetailsModel.h"

@implementation RemoteWeatherDetailsModel

+ (nonnull instancetype)fromJSON:(nonnull NSDictionary *)json {
    RemoteWeatherDetailsModel *details = [[RemoteWeatherDetailsModel alloc] init];
    [details updateTimeStamp];
    [details updateHumidityFromJSON:json];
    [details updateTempFromJSON:json];
    [details updateWindSpeedFromJSON:json];
    [details updateDescriptionFromJSON:json];
    [details updateImageUrlFromJSON:json];
    return details;
}

- (void)updateTimeStamp {
    self.timestamp = [NSDate date];
}

- (void)updateHumidityFromJSON:(NSDictionary *)json {
    self.humidity = [json[@"main"][@"humidity"] intValue];
}

- (void)updateTempFromJSON:(NSDictionary *)json {
    self.temp = [json[@"main"][@"temp"] doubleValue];
}

- (void)updateWindSpeedFromJSON:(NSDictionary *)json {
    self.windSpeed = [json[@"wind"][@"speed"] doubleValue];
}

- (void)updateDescriptionFromJSON:(NSDictionary *)json {
    NSArray *weather = json[@"weather"];
    if (weather.count > 0) {
        NSDictionary *dict = weather.firstObject;
        self.detailedDescription = dict[@"main"];
    }
}

- (void)updateImageUrlFromJSON:(NSDictionary *)json {
    NSArray *weather = json[@"weather"];
    if (weather.count > 0) {
        NSDictionary *dict = weather.firstObject;
        self.imageURL = dict[@"icon"];
    }
}

@end
