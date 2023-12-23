//
//  dsad.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import SwiftUI

import SwiftUI

struct PhoneTextField: View {
    @Binding var text: String
    @State var placeholderNumber: String = ""
    @FocusState private var focused: Bool
    var placeholder: String = "Номер телефона"
    var body: some View {
        let isActive = focused || text.count > 0
        
        ZStack(alignment: isActive ? .topLeading : .center) {
            ZStack {
                TextField("", text: $placeholderNumber)
                    .disabled(true)
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 16, weight: .regular))
                TextField("", text: $text)
                    .focused($focused)
                    .keyboardType(.numberPad)
                    .onChange(of: text) { _, newValue in
                        text = format2(with: "+X (XXX) XXX-XX-XX", phone: newValue)
                        placeholderNumber = format(with: "+X (XXX) XXX-XX-XX", phone: newValue)
                    }
            }
            .frame(height: 24)
            .font(.system(size: 16, weight: .regular))
            .opacity(isActive ? 1 : 0)
            .offset(y: 7)
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
        .background(Color(red: 0.96, green: 0.96, blue: 0.98))
        .cornerRadius(10)
    }

    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask {
            if ch == "X" {
                if index < numbers.endIndex {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append("*")
                }
            } else {
                result.append(ch)
            }
        }
        return result
    }



    func format2(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}



#Preview {
    PhoneTextField(text: .constant(""), placeholderNumber: "+7 (000) 000-00-00")
}
