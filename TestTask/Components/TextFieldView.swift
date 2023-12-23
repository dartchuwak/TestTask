//
//  PhoneTextFieldView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import Foundation
import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    let placeholder: String
    @FocusState var focused: Bool
    @Binding var isValid: Bool

    var body: some View {
        let isActive = focused || text.count > 0

        ZStack(alignment: isActive ? .topLeading : .center) {
            TextField("", text: $text)
                .frame(height: 24)
                .font(.system(size: 16, weight: .regular))
                .opacity(isActive ? 1 : 0)
                .offset(y: 7)
                .focused($focused)
                .keyboardType(.default)
            HStack {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.3))
                    .frame(height: 16)
                    .font(.system(size: isActive ? 12 : 17, weight: .regular))
                    .offset(y: isActive ? -7 : 0)
                Spacer()
            }
        }
        .onTapGesture {
            focused = true
        }
        .onChange(of: focused, { oldValue, newValue in
            if newValue == true {
                isValid = true
            }
        })
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(isValid ? Color(red: 0.96, green: 0.96, blue: 0.98) : Color.init(hex: "EB5757 ").opacity(0.15))
        .cornerRadius(10)
    }
}

#Preview {
    TextFieldView(text: .constant(""), placeholder: "Имя", isValid: .constant(true))
}

