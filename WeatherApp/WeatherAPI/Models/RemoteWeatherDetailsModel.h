//
//  RemoteCityDetailsModel.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RemoteWindModel;
@class RemoteWeatherDescriptionModel;
@class RemoteWeatherDetailsModel;

@interface RemoteWeatherDetailsModel : NSObject

@property (nonatomic, assign) int humidity;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSString *detailedDescription;
@property (nonatomic, strong) NSString *imageURL;

+ (instancetype)fromJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
