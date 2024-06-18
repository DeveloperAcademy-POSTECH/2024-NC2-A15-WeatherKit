//
//  ContentView.swift
//  CarWashDay
//
//  Created by Seol WooHyeok on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
            
            VStack {
                
                Spacer()
                
                HStack{
                    Image(systemName: "location.fill")
                        .foregroundColor(.cwGray4)
                        .imageScale(.small)
                    
                    Text("포항시 지곡동")
                        .font(.custom("Pretendard-Reguler", size:16))
                        .foregroundColor(.cwGray4)
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
                    VStack{
                        Spacer()
                            .padding(.top, 10)
                        HStack{
                            Text("10일간의 일기 예보")
                                .font(.custom("Pretendard-Regular", size:14))
                                .foregroundColor(.cwGray2)
                            
                            Spacer()
                        }
                        .padding(.bottom, 9)
                        
                        Divider()
                            .padding(.bottom, 9)
                        
                        ForEach(1..<11){number in
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
                                    LazyVGrid(columns: columns){
                                        HStack{
                                            Text("오늘")
                                                .font(.custom("Pretendard-Medium", size:20))
                                                .foregroundColor(.cwGray4)
                                            Spacer()
                                        }
                                        HStack{
                                            Image(systemName: "sun.max.fill")
                                                .foregroundColor(.cwYellowSun)
                                                .font(.system(size: 20))
                                            Text("맑음")
                                                .font(.custom("Pretendard-Regular", size:16))
                                                .foregroundColor(.cwGray3)
                                                .padding(.leading, 16)
                                            Spacer()
                                        }
                                        HStack{
                                            Spacer()
                                            Text("0%")
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
                    Rectangle()
                        .foregroundColor(.cwBlueBg)
                        .frame(height: 64)
                }
                .edgesIgnoringSafeArea(.all)
                
                
                
            }
            .padding(.horizontal, 20)
            .background(Color(.cwBlueBg))
            
        }
    }


#Preview {
    ContentView()
}
