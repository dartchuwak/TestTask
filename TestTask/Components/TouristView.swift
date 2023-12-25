//
//  TouristView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import SwiftUI

struct TouristView: View {
    var number: String
    @State private var isToogle: Bool = false
    @Binding var tourist: Tourist
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("\(number) турист")
                    .font(Font.custom("SF Pro Display", size: 22).weight(.medium))
                    .foregroundColor(.black)
                    .frame(alignment: .topLeading)
                Spacer()
                Image(systemName: isToogle ? "chevron.down" : "chevron.up")
                    .resizable()
                    .foregroundStyle(Color.blue)
                    .frame(width: 12, height: 6)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(width: 32, height: 32, alignment: .center)
                    .background(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
                    .cornerRadius(6)
                    .onTapGesture {
                        withAnimation {
                            isToogle.toggle()
                        }
                    }
            }
            .padding(.bottom, !isToogle ? 12 : 0)
            if !isToogle {
                TextFieldView(text: $tourist.name, placeholder: "Имя", isValid: $tourist.isNameValid)

                TextFieldView(text: $tourist.surname, placeholder: "Фамилия", isValid: $tourist.isSurnameValid)

                TextFieldView(text: $tourist.birthDate, placeholder: "Дата рождения", isValid: $tourist.isBirthdateValid)

                TextFieldView(text: $tourist.citezenship, placeholder: "Гражданство", isValid: $tourist.isCitezenshipValid)

                TextFieldView(text: $tourist.passportNumber, placeholder: "Номер загранпаспорта", isValid: $tourist.isPassportNumberValid)

                TextFieldView(text: $tourist.passportValidDate, placeholder: "Срок действия загранпаспорта", isValid: $tourist.isPassportValidDateValid)
            }
        }
    }
}

#Preview {
    TouristView(number: "Первый", tourist: .constant(Tourist(number: "", name: "", surname: "", birthDate: "", citezenship: "", passportNumber: "", passportValidDate: "", isToogle: false)))
}
