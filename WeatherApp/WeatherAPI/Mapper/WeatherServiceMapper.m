//
//  WeatherServiceMapper.m
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import "WeatherServiceMapper.h"
#import "RemoteCityModel.h"
#import "WeatherApp-Swift.h"

@implementation WeatherServiceMapper

+ (RemoteCityModel *)mapCityData:(NSData *)data fromResponse:(NSHTTPURLResponse * _Nullable)response error:(NSError **)error {
    if (response.statusCode != 200) {
        if (error != NULL) {
            *error = [NSErrorHelper weatherAppErrorWithCode:response.statusCode description:@"Invalid status code"];
        }
        return nil;
    }

    NSDictionary *json = [self parseJSONFromData:data error:error];

    if (!json || *error) {
        return nil;
    }

    RemoteCityModel *model = [RemoteCityModel fromJSON:json];
    return model;
}

+ (NSDictionary *)parseJSONFromData:(NSData *)data error:(NSError **)error {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:error];
    if (!json) {
        if (error != NULL) {
            *error = [NSErrorHelper weatherAppErrorWithCode:NSPropertyListReadCorruptError description:@"Corrupted data"];
        }
    }
    return json;
}

@end
