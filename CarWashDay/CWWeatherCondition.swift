//
//  WeatherCondition.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/18/24.
//

import Foundation

enum CWWeatherCondition: String, CaseIterable {
    case clear = "맑음"
    case cloudy = "흐림"
    case snow = "눈"
    case rain = "비"
    
    // 문자열을 WeatherCondition으로 매핑하는 Dictionary
    private static let conditionMapping: [String: CWWeatherCondition] = [
        "Clear": .clear, "mostlyClear": .clear, "hot": .clear, "cloudy": .cloudy, "foggy": .cloudy, "haze": .cloudy, "mostlyCloudy": .cloudy, "partlyCloudy": .cloudy, "smoky": .cloudy, "blizzard": .snow, "blowingSnow": .snow, "flurries": .snow, "frigid": .snow, "heavySnow": .snow, "sleet": .snow, "snow": .snow, "sumFlurries": .snow, "drizzle": .rain, "freezingDrizzle": .rain, "freezingRain": .rain, "heavyRain": .rain, "hurricane": .rain, "isolatedThunderstorms": .rain, "rain": .rain, "scatteredThunderstorms": .rain, "strongStorms": .rain, "sunShowers": .rain, "thunderstorms": .rain, "tropicalStorm": .rain, "hail": .rain
    ]
    
    // 문자열을 WeatherCondition으로 변환하는 정적 메서드
    static func convertCondition(condition: String) -> CWWeatherCondition {
        return conditionMapping[condition] ?? .clear
    }
}
