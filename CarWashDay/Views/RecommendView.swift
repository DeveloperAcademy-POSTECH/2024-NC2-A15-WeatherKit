//
//  RecommendView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/18/24.
//

import SwiftUI

struct RecommendView: View {
    enum RecommendStatus: String {
        case goodForCarWash = "10일간 비 올 확률이 낮아요"
        case rainLikely = "흐리지만 비 올 확률이 높은 날이 있어요"
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
    
    @State var currentStatus: RecommendStatus = .goodForCarWash
    
    var body: some View {
        Text(currentStatus.recommend)
            .font(.custom("Pretendard-Bold", size:24))
            .foregroundColor(.cwGray5)
            .padding(.bottom, 8)
        
        Text(currentStatus.description)
            .font(.custom("Pretendard-Reguler", size:16))
            .foregroundColor(.cwGray4)
            .padding(.bottom, 42)
        
        Image(currentStatus.imageName)
    }
}
