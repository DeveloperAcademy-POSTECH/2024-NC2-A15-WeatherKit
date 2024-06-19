//
//  ContentView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import SwiftUI
import WeatherKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherManager = WeatherManager()
    
    @State var dateFormatter = DateFormatter()
    @State var recommendationStatus: CWRecommendationStatus = .goodForCarWash
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.cwGray4)
                    .imageScale(.small)
                
                if locationManager.location != nil {
                    Text(locationManager.address)
                        .font(.custom("Pretendard-Reguler", size:16))
                        .foregroundColor(.cwGray4)
                } else {
                    if locationManager.authorizationStatus == .denied {
                        Text("설정에서 위치 정보 사용을 허용해 주세요.")
                            .font(.custom("Pretendard-Reguler", size:16))
                            .foregroundColor(.cwGray4)
                    } else {
                        Text("위치를 불러오는 중...")
                            .font(.custom("Pretendard-Reguler", size:16))
                            .foregroundColor(.cwGray4)
                    }
                }
            }
            .padding(.bottom, 40)
            
            RecommendView(currentStatus: recommendationStatus)
                .redacted(reason: weatherManager.dailyWeather.isEmpty ? .placeholder : [])
                .animation(.easeInOut(duration: 0.6), value: weatherManager.dailyWeather.isEmpty)
            
            ScrollView(.vertical, showsIndicators: false){
                if let location = locationManager.location {
                    VStack {
                        Spacer()
                            .padding(.top, 10)
                        HStack {
                            Text("10일간의 일기 예보")
                                .font(.custom("Pretendard-Regular", size:14))
                                .foregroundColor(.cwGray2)
                            
                            Spacer()
                        }
                        .padding(.bottom, 9)
                        
                        Divider()
                            .padding(.bottom, 9)
                        
                        ForEach(weatherManager.dailyWeather, id: \.date) { dayWeather in
                            HStack{
                                GeometryReader { geometry in
                                    let totalWidth = geometry.size.width
                                    let columnWidth1 = totalWidth * 0.25
                                    let columnWidth2 = totalWidth * 0.5
                                    let columnWidth3 = totalWidth * 0.25
                                    
                                    let columns = [
                                        GridItem(.fixed(columnWidth1), spacing: 0, alignment: .center),
                                        GridItem(.fixed(columnWidth2), spacing: 0, alignment: .center),
                                        GridItem(.fixed(columnWidth3), spacing: 0, alignment: .center)
                                    ]
                                    LazyVGrid(columns: columns) {
                                        HStack {
                                            Text(isSameDate(first: Date(), second: dayWeather.date) ? "오늘" : dateFormatter.string(from: dayWeather.date))
                                                .font(.custom("Pretendard-Medium", size:20))
                                                .foregroundColor(.cwGray4)
                                            Spacer()
                                        }
                                        
                                        ZStack(alignment: .leading) {
                                            HStack {
                                                getConditionIcon(condition: CWWeatherCondition.convertCondition(condition: dayWeather.condition.rawValue))
                                                
                                                Spacer()
                                            }
                                            
                                            Text(CWWeatherCondition.convertCondition(condition: dayWeather.condition.rawValue).rawValue)
                                                .font(.custom("Pretendard-Regular", size:16))
                                                .foregroundColor(.cwGray3)
                                                .padding(.leading, 49)
                                        }
                                        
                                        
                                        HStack {
                                            Spacer()
                                            Text("\(dayWeather.precipitationChance * 100, specifier: "%.0f")%")
                                                .font(.custom("Pretendard-Medium", size:20))
                                                .foregroundColor(.cwGray3)
                                        }
                                    }
                                }
                                .padding(.bottom, 32)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .background(getListColor(status: recommendationStatus))
                    .animation(.easeInOut(duration: 1.0), value: getBackgroundColor(status: recommendationStatus))
                    .cornerRadius(16)
                    .onAppear {
                        Task {
                            await weatherManager.fetchWeather(for: location)
                            setRecommendationStatus()
                        }
                    }
                    .redacted(reason: weatherManager.dailyWeather.isEmpty ? .placeholder : [])
                    .animation(.easeInOut(duration: 1.0), value: weatherManager.dailyWeather.isEmpty)
                }
               
                VStack {
                    Rectangle()
                        .foregroundColor(getBackgroundColor(status: recommendationStatus))
                        .animation(.easeInOut(duration: 1.0), value: getBackgroundColor(status: recommendationStatus))
                        .frame(height: 28)
                    HStack(spacing: 3) {
                        Image(systemName: "apple.logo")
                            .foregroundColor(.cwGray3)
                            .font(.system(size: 12))
                        Text("Weather")
                            .font(.custom("Pretendard-Reguler", size:12))
                            .foregroundColor(.cwGray3)
                        Link(destination: URL(string: "https://developer.apple.com/weatherkit/data-source-attribution/")!, label: {
                            Text("Data Sources")
                                .font(.custom("Pretendard-Reguler", size:12))
                                .foregroundColor(.cwGray3)
                                .underline(true, color: .cwGray3)
                                .padding(.leading,8)
                        })
                        
                    }
                    .padding(.bottom,44)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .padding(.horizontal, 20)
        .background(getBackgroundColor(status: recommendationStatus))
        .animation(.easeInOut(duration: 1.0), value: getBackgroundColor(status: recommendationStatus))
        .onAppear {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "E"
        }
    }
    
    private func setRecommendationStatus() {
        if weatherManager.rainyDays >= 1 {
            recommendationStatus = .rainy
        } else if weatherManager.precipitationUpperDays >= 1 {
            recommendationStatus = .rainLikely
        } else {
            recommendationStatus = .goodForCarWash
        }
    }
    
    private func getBackgroundColor(status: CWRecommendationStatus) -> Color {
        switch status {
        case .goodForCarWash:
            return Color(.cwBlueBg)
        case .rainLikely, .rainy:
            return Color(.cwGrayBg)
        }
    }
    
    private func getListColor(status: CWRecommendationStatus) -> Color {
        switch status {
        case .goodForCarWash:
            return Color(.cwBlueList)
        case .rainLikely, .rainy:
            return Color(.cwGrayList)
        }
    }
    
    private func isSameDate(first: Date, second: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(first, inSameDayAs: second)
    }
    
    @ViewBuilder
    private func getConditionIcon(condition: CWWeatherCondition) -> some View {
        switch condition {
        case .clear:
            Image(systemName: "sun.max.fill")
                .foregroundColor(.cwYellowSun)
                .font(.system(size: 20))
        case .cloudy:
            Image(systemName: "cloud.fill")
                .foregroundColor(.cwGrayCloudy)
                .font(.system(size: 20))
        case .snow:
            Image(systemName: "snowflake")
                .foregroundColor(.cwBlueSnow)
                .font(.system(size: 20))
        case .rain:
            Image(systemName: "cloud.heavyrain.fill")
                .foregroundColor(.cwBlueRain)
                .font(.system(size: 20))
        }
    }
}


#Preview {
    ContentView()
}
