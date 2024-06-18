//
//  RecommendView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/18/24.
//

import SwiftUI

struct RecommendView: View {
    var currentStatus: CWRecommendationStatus
    
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
