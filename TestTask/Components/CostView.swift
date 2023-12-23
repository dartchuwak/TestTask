//
//  CostView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 21.12.2023.
//

import SwiftUI

struct CostView: View {
    let touristsCount: Int
    let text: String
    let value: Int
    let isTotal: Bool
    var body: some View {
        HStack {
            Text(text)
                .font(Font.custom("SF Pro Display", size: 16))
                .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
            Spacer()
            Text("\(String(value * touristsCount)) ₽")
                .font(.system(size: 16))
                .fontWeight(isTotal ? .semibold : .regular)
                .multilineTextAlignment(.trailing)
                .foregroundColor( !isTotal ? .black : Color(red: 0.05, green: 0.45, blue: 1))
        }
    }
}

#Preview {
    CostView(touristsCount: 1, text: "Тур", value: 16800, isTotal: true)
}
