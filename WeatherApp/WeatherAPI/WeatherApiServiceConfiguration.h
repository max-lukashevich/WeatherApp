//
//  WeatherServiceConfiguration.h
//  WeatherApp
//
//  Created by Max Lukashevich on 07/12/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherApiServiceConfiguration : NSObject

@property (nonatomic, copy, readonly) NSString *baseURL;

- (instancetype)initWithBaseURL:(NSString *)baseURL apiKey:(NSString *)apiKey;

@end

NS_ASSUME_NONNULL_END
