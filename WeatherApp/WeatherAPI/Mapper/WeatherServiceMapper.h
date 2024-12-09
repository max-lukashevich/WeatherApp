//
//  WeatherServiceMapper.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RemoteCityModel;

@interface WeatherServiceMapper : NSObject

+ (RemoteCityModel *)mapCityData:(NSData *)data fromResponse:(NSHTTPURLResponse * _Nullable)response error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
