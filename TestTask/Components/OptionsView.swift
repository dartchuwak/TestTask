//
//  OptionsView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 19.12.2023.
//

import SwiftUI

struct OptionsView: View {
    let image: String
    let text: String
    let descriptions: String
    var body: some View {
        HStack(spacing: 12) {
            Image("close-square")
                .resizable()
                .frame(width: 24, height: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                Text(descriptions)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
            }
                Spacer()
                Image(systemName: "chevron.right")
        }
        .padding(.horizontal)
    }
}

#Preview {
    OptionsView(image: "close-square", text: "Удобства", descriptions: "Самое необходимое")
}
