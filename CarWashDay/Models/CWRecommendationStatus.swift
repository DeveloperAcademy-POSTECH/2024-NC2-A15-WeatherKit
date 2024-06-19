//
//  CWRecommendStatus.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/18/24.
//

enum CWRecommendationStatus: String {
    case goodForCarWash = "10일간 비 올 확률이 낮아요"
    case rainLikely = "10일간 전반적으로 흐리고 비 올 확률이 있어요"
    case rainy = "10일간 비 올 확률이 높아요"
    
    var recommend: String {
        switch self {
        case .goodForCarWash:
            return "오늘 세차하기 좋아요"
        case .rainLikely, .rainy:
            return "오늘 세차는 권장하지 않아요"
        }
    }
    
    var description: String {
        return self.rawValue
    }
    
    var imageName: String {
        switch self {
        case .goodForCarWash:
            return "SunCar"
        case .rainLikely, .rainy:
            return "RainCar"
        }
    }
}
