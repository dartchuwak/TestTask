//
//  BookingView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import SwiftUI

struct BookingView: View {
    @EnvironmentObject var coordinator: Coordinator
    let bookingDetails: Booking
    @State var phoneNumber = ""
    @State var email = ""
    @State var isCol = false
    @State var touristEmail = ""
    @State var touristPhone = ""
    @State var touristToggle = false
    @State var touristIsAdded = true
    @State var isPayed = false
    @State var isValid = false
    @State private var tourists: [Tourist] =  [
        Tourist(number: "Первый", name: "", surname: "", birthDate: "", citezenship: "", passportNumber: "", passportValidDate: "", isToogle: false)
    ]
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    Spacer().frame(height: 8)
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .center, spacing: 2) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("\(bookingDetails.horating) \(bookingDetails.ratingName)")
                        }
                        .foregroundColor(Color(red: 1, green: 0.66, blue: 0))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(red: 1, green: 0.78, blue: 0).opacity(0.2))
                        .cornerRadius(5)

                        Text(bookingDetails.hotelName)
                            .font(
                                Font.custom("SF Pro Display", size: 22)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)

                        Text(bookingDetails.hotelAdress)
                            .font(
                                Font.custom("SF Pro Display", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))


                    }
                    .padding(16) 
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(15)

                    VStack(alignment: .leading, spacing: 16) {
                        TourDetailsView(text: "Вылет из", value: bookingDetails.departure)
                        TourDetailsView(text: "Старана, город", value: bookingDetails.arrivalCountry)
                        TourDetailsView(text: "Даты", value: String(bookingDetails.tourDateStart + " – " + bookingDetails.tourDateStop))
                        TourDetailsView(text: "Кол-во ночей", value: String(bookingDetails.numberOfNights.description + " ночей"))
                        TourDetailsView(text: "Отель", value: bookingDetails.hotelName)
                        TourDetailsView(text: "Номер", value: bookingDetails.room)
                        TourDetailsView(text: "Питание", value: bookingDetails.nutrition)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(15)

                    VStack(alignment: .leading) {
                        Text("Информация о покупателе")
                            .font(Font.custom("SF Pro Display", size: 22).weight(.medium))
                            .foregroundColor(.black)
                            .frame(alignment: .topLeading)
                            .padding(.bottom, 12)

                        PhoneTextField(text: $phoneNumber, placeholderNumber: "+7 (***) ***-**-**")
                        EmailTextFieldView(text: $email, placeholder: "Почта")

                        Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                            .font(Font.custom("SF Pro Display", size: 14))
                            .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                            .frame(width: 343, alignment: .topLeading)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(15)

                    VStack {
                        ForEach($tourists.indices, id:\.self) { index in
                            TouristView(number: tourists[index].number, tourist: $tourists[index])
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(15)
                        }

                        AddTouristView()
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(15)
                            .onTapGesture {
                                let newTourist = Tourist(number: String(tourists.count + 1), name: "", surname: "", birthDate: "", citezenship: "", passportNumber: "", passportValidDate: "", isToogle: false)
                                tourists.append(newTourist)
                            }
                    }

                    VStack(spacing: 16) {
                        CostView(touristsCount: self.tourists.count, text: "Тур", value: bookingDetails.tourPrice, isTotal: false)
                        CostView(touristsCount: self.tourists.count, text: "Топливный сбор", value: bookingDetails.fuelCharge, isTotal: false)
                        CostView(touristsCount: self.tourists.count, text: "Сервисный сбор", value: bookingDetails.serviceCharge, isTotal: false)
                        CostView(touristsCount: self.tourists.count, text: "К оплате", value: bookingDetails.tourPrice + bookingDetails.fuelCharge + bookingDetails.serviceCharge, isTotal: true)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                }
                .scrollIndicators(.hidden)
                .frame(width: geo.size.width)
                .background(Color(red: 0.96, green: 0.96, blue: 0.98))

                Button(action: {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    if areAllTouristsValid() {
                        coordinator.push(view: .pay)
                    } else {
                        print("Not valid")
                    }
                }, label: {
                    Text("Оплатить")
                        .font(.system(size: 16, weight: .medium))
                        .kerning(0.1)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                })
                .padding(.vertical, 15)
                .frame(width: UIScreen.main.bounds.width - 32)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Бронирование")
            .toolbar(.visible, for: .navigationBar)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        coordinator.pop()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.medium)
                            .tint(.black)
                    })
                }
            })
        }
    }

    func areAllTouristsValid() -> Bool {
        var allValid = true
        for index in tourists.indices {
            let isValid = !tourists[index].name.isEmpty && !tourists[index].surname.isEmpty && !tourists[index].birthDate.isEmpty && !tourists[index].passportNumber.isEmpty && !tourists[index].passportValidDate.isEmpty && !tourists[index].citezenship.isEmpty

            tourists[index].isNameValid = !tourists[index].name.isEmpty
            tourists[index].isSurnameValid = !tourists[index].surname.isEmpty
            tourists[index].isBirthdateValid = !tourists[index].birthDate.isEmpty
            tourists[index].isCitezenshipValid = !tourists[index].citezenship.isEmpty
            tourists[index].isPassportNumberValid = !tourists[index].passportNumber.isEmpty
            tourists[index].isPassportValidDateValid = !tourists[index].passportValidDate.isEmpty

            if !isValid {
                allValid = false
            }
        }
        return allValid
    }

}

#Preview {
    BookingView(bookingDetails: MockData.booking)
}
