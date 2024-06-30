//
//  CWWeekWeather.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/30/24.
//

import Foundation

struct CWWeekWeather: Codable {
    var updateDate: Date
    var weekWeather: [CWDailyWeather]
}
