//
//  ContentView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                HStack{
                    Image(systemName: "location.fill")
                        .foregroundColor(.cwGray4)
                        .imageScale(.small)
                        .foregroundStyle(.tint)
        
                    Text("포항시 지곡동")
                        .font(.custom("Pretendard-reguler", size:16))
                        .foregroundColor(.cwGray4)
                }.padding(.bottom, 40)
                
                Text("오늘 세차하기 좋아요")
                    .font(.custom("Pretendard-bold", size:24))
                    .foregroundColor(.cwGray5)
                    .padding(.bottom, 8)
                Text("10일간 비 올 확률이 낮아요")
                    .font(.custom("Pretendard-reguler", size:16))
                    .foregroundColor(.cwGray4)
                Spacer()
            }
           
        }
    }
}

#Preview {
    ContentView()
}
