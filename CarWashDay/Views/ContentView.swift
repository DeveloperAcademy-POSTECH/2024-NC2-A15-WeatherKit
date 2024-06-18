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
            
            Text("오늘 세차하기 좋아요")
                .font(.custom("Pretendard-Bold", size:24))
                .foregroundColor(.cwGray5)
                .padding(.bottom, 8)
            
            Text("10일간 비 올 확률이 낮아요")
                .font(.custom("Pretendard-Reguler", size:16))
                .foregroundColor(.cwGray4)
                .padding(.bottom, 42)
            
            Image("SunCar")
            
            ScrollView(.vertical, showsIndicators: false){
                if let location = locationManager.location {
                    if weatherManager.dailyWeather.isEmpty {
                        Text("날씨 불러오는 중...")
                            .font(.custom("Pretendard-Reguler", size:16))
                            .foregroundColor(.cwGray4)
                            .padding(.vertical, 42)
                            .onAppear {
                                Task {
                                    await weatherManager.fetchWeather(for: location)
                                }
                            }
                    } else {
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
                                                Text(dateFormatter.string(from: dayWeather.date))
                                                    .font(.custom("Pretendard-Medium", size:20))
                                                    .foregroundColor(.cwGray4)
                                                Spacer()
                                            }
                                            
                                            HStack {
                                                Image(systemName: "sun.max.fill")
                                                    .foregroundColor(.cwYellowSun)
                                                    .font(.system(size: 20))
                                                Text(CWWeatherCondition.convertCondition(condition: dayWeather.condition.rawValue).rawValue)
                                                    .font(.custom("Pretendard-Regular", size:16))
                                                    .foregroundColor(.cwGray3)
                                                    .padding(.leading, 16)
                                                Spacer()
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
                        .background(Color(.cwBlueList))
                        .cornerRadius(16)
                    }
                }
               
                VStack {
                    Rectangle()
                        .foregroundColor(.cwBlueBg)
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
        .background(Color(.cwBlueBg))
        .onAppear {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "E"
        }
    }
}


#Preview {
    ContentView()
}
