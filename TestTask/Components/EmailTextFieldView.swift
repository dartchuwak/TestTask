//
//  EmailTextFieldView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 21.12.2023.
//

import SwiftUI

struct EmailTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    @FocusState var focused: Bool
    @State private var wasFocused: Bool = true
    @State private var isValid: Bool = true

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
                .textCase(.lowercase)
                .textInputAutocapitalization(.never)
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
        .animation(.linear(duration: 0.2), value: focused)
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(isValid ? Color(red: 0.96, green: 0.96, blue: 0.98) : Color.init(hex: "EB5757").opacity(0.15))
        .cornerRadius(10)
        .onChange(of: focused) { _, newValue in
            if newValue == false {
                if !isValidEmail(text) {
                    isValid = false
                } else {
                    isValid = true
                }
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    EmailTextFieldView(text: .constant(""), placeholder: "Имя")
}
