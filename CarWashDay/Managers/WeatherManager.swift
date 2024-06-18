//
//  WeatherManager.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import CoreLocation
import SwiftUI
import WeatherKit

// 클래스의 모든 메서드와 속성이 메인 스레드에서 실행됨.
@MainActor
class WeatherManager: ObservableObject {
    // WeatherKit의 공유 인스턴스를 가져옴
    private let weatherService = WeatherService.shared
    
    @Published var dailyWeather: [DayWeather] = []
    @Published var precipitationProbability: Double?
    @Published var rainyDays: Int = 0
    @Published var precipitationUpperDays: Int = 0
    
    func fetchWeather(for location: CLLocation) async {
        do {
            let weather = try await weatherService.weather(for: location)
            dailyWeather = weather.dailyForecast.forecast.prefix(10).map { $0 }
            
            // 비오는 날이나 확률높은 날 계산
            for day in dailyWeather {
                let condition = CWWeatherCondition.convertCondition(condition: day.condition.rawValue)
                
                if condition == .rain {
                    rainyDays += 1
                }
                
                if day.precipitationChance >= 0.6 {
                    precipitationUpperDays += 1
                }
             }
        } catch {
            print("Failed to fetch weather data: \(error)")
        }
    }
}
