//
//  RemoteCityModel.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "RemoteCityModel.h"
#import <CoreData/CoreData.h>
#import <CoreData/CoreData.h>

@implementation RemoteCityModel

+ (instancetype)fromJSON:(NSDictionary *)json {
    RemoteCityModel *model = [[RemoteCityModel alloc] init];
    model.cityName = json[@"name"];
    model.countryName = json[@"sys"][@"country"];
    model.cityId = [json[@"id"] intValue];
    model.weatherDetails = [RemoteWeatherDetailsModel fromJSON:json];
    return model;
}

@end
