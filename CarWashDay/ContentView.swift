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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("폰트 적용")
                .font(.custom("Pretendard-reguler", size:40))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
