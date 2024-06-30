//
//  CWDailyWeather.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/30/24.
//

import Foundation

struct CWDailyWeather: Codable {
    var date: Date
    var condition: CWWeatherCondition
    var precipitation: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case condition
        case precipitation
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        // DateFormatter를 사용하여 날짜 형식 변환
//        let dateString = try container.decode(String.self, forKey: .date)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        
//        if let date = dateFormatter.date(from: dateString) {
//            self.date = date
//        } else {
//            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
//        }
//        
//        let conditionString = try container.decode(String.self, forKey: .condition)
//        self.condition = CWWeatherCondition.convertCondition(condition: conditionString)
//        
//        self.precipitation = try container.decode(Int.self, forKey: .precipitation)
//    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.condition = try container.decode(CWWeatherCondition.self, forKey: .condition)
        self.precipitation = try container.decode(Int.self, forKey: .precipitation)
    }
}
