//
//  RemoteCityModel.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>
#import "RemoteWeatherDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@class NSManagedObjectContext;
@class City;

@interface RemoteCityModel : NSObject

@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) RemoteWeatherDetailsModel *weatherDetails;

+ (instancetype)fromJSON:(NSDictionary *)json;

@end


NS_ASSUME_NONNULL_END
