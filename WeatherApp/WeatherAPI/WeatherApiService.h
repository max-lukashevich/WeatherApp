//
//  WeatherService.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeatherApiServiceConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@class RemoteCityModel;

@protocol WeatherApiServiceProtocol <NSObject>

- (void)fetchWeatherForCity:(NSString *)cityName
                 completion:(void (^)(RemoteCityModel * _Nullable weatherData, NSError * _Nullable error))completion;

@end

@interface WeatherApiService : NSObject <WeatherApiServiceProtocol>

@property (nonatomic, strong, readonly) WeatherApiServiceConfiguration *configuration;

- (instancetype)initWithConfiguration:(WeatherApiServiceConfiguration *)configuration;

- (void)fetchWeatherForCity:(NSString *)cityName
                 completion:(void (^)(RemoteCityModel * _Nullable weatherData, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
