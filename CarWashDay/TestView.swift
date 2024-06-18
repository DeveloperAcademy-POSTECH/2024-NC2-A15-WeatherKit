//
//  ContentView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import SwiftUI
import WeatherKit

struct TestView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager = WeatherManager()
    
//    // 현재 날짜를 가져옵니다.
//    let currentDate = Date()
//    // DateFormatter를 생성하여 요일 형식을 설정합니다.
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEEE" // "EEEE"는 요일을 나타내는 포맷입니다.
//    let dayOfWeek = dateFormatter.string(from: currentDate)

    @State var dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text(locationManager.address)
                    .padding()
                    .multilineTextAlignment(.center)
                if weatherManager.dailyWeather.isEmpty {
                    Text("Loading weather data...")
                        .onAppear {
                            Task {
                                await weatherManager.fetchWeather(for: location)
                            }
                        }
                } else {
                    List(weatherManager.dailyWeather, id: \.date) { dayWeather in
                        VStack(alignment: .leading) {
                            Text(dateFormatter.string(from: dayWeather.date))
                                .font(.headline)
                            Text("강수확률: \(dayWeather.precipitationChance * 100, specifier: "%.0f")%")
                            
                            Text("날씨: \(CWWeatherCondition.convertCondition(condition: dayWeather.condition.rawValue).rawValue)")
                        }
                    }
                }
            } else {
                if locationManager.authorizationStatus == .denied {
                    Text("Location access denied. Please enable location services.")
                } else {
                    Text("Fetching location...")
                }
            }
        }
        .padding()
        .onAppear {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "E"
        }
    }
}
