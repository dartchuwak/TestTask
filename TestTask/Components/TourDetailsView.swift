//
//  TourDetailsView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import SwiftUI

struct TourDetailsView: View {
    let text: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(text)
                .frame(maxWidth: 150, alignment: .leading)
                .multilineTextAlignment(.leading)

            Text(value)
                .frame(alignment: .leading)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}

#Preview {
    TourDetailsView(text: "Вылет из", value: "Санкт-Петербурга")
}
