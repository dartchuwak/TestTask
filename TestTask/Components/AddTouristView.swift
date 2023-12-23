//
//  TouristView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import SwiftUI

struct AddTouristView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Добавить туриста")
                    .font(Font.custom("SF Pro Display", size: 22).weight(.medium))
                    .foregroundColor(.black)
                    .frame(alignment: .topLeading)
                Spacer()
                Image(systemName: "plus")
                    .resizable()
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .frame(width: 12, height: 12)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(width: 32, height: 32, alignment: .center)
                    .background(Color(red: 0.05, green: 0.45, blue: 1))
                    .cornerRadius(6)
            }
        }
    }
}

#Preview {
    AddTouristView()
}
