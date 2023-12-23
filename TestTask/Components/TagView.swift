//
//  TagView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 18.12.2023.
//

import SwiftUI

struct TagView: View {

    let text: String
    var body: some View {
        Text(text)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
            .cornerRadius(5)

    }
}

#Preview {
    TagView(text: "3-я линия")
}
