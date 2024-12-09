//
//  WeatherApiServiceConfigurationTests.swift
//  WeatherAppTests
//
//  Created by Max Lukashevich on 09/12/2024.
//

import XCTest
@testable import WeatherApp

final class WeatherApiServiceConfigurationTests: XCTestCase {

    private func assertConfiguration(baseURL: String, apiKey: String, expectedURL: String, file: StaticString = #file, line: UInt = #line) {
        // When
        let config = WeatherApiServiceConfiguration(baseURL: baseURL, apiKey: apiKey)

        // Then
        XCTAssertEqual(config.baseURL, expectedURL, "The constructed baseURL is incorrect.", file: file, line: line)
    }

    // MARK: - Tests

    func test_ValidBaseURLAndApiKey_ExpectCorrectlyConstructedBaseURL() {
        // Given
        let baseURL = "https://api.openweathermap.org"
        let apiKey = "testApiKey123"
        let expectedURL = "https://api.openweathermap.org/data/2.5/weather?appid=testApiKey123"

        // Then
        assertConfiguration(baseURL: baseURL, apiKey: apiKey, expectedURL: expectedURL)
    }

    func test_EmptyBaseURL_ExpectURLStartingFromPathOnly() {
        // Given
        let baseURL = ""
        let apiKey = "testApiKey123"
        let expectedURL = "/data/2.5/weather?appid=testApiKey123"

        // Then
        assertConfiguration(baseURL: baseURL, apiKey: apiKey, expectedURL: expectedURL)
    }

    func test_EmptyApiKey_ExpectURLWithoutApiKeyValue() {
        // Given
        let baseURL = "https://api.openweathermap.org"
        let apiKey = ""
        let expectedURL = "https://api.openweathermap.org/data/2.5/weather?appid="

        // Then
        assertConfiguration(baseURL: baseURL, apiKey: apiKey, expectedURL: expectedURL)
    }
}
