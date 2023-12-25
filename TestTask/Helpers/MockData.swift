//
//  MockData.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 20.12.2023.
//

import Foundation

final class MockData {
    static let booking = Booking(id: 1123456789, hotelName: "Steigenberger Makadi", hotelAdress: "Madinat Makadi, Safaga Road, Makadi Bay, Египет", horating: 5, ratingName: "Превосходно", departure: "Санкт-Петербург", arrivalCountry: "Египет, Хургада", tourDateStart: "19.09.2023", tourDateStop: "27.09.2023", numberOfNights: 7, room: "Стандартный с видом на бассейн или сад", nutrition: "Все включено", tourPrice: 186600, fuelCharge: 9300, serviceCharge: 2136)

    static let room = Room(id: 1, name: "Стандартный номер с видом на бассейн", price: 186000, pricePer: "за 7 ночей с перелетом", peculiarities: ["Все ключено", "Кондиционер", "Собственный бассейн"], imageUrls: [
        "https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81%20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
        "https://q.bstatic.com/xdata/images/hotel/max1024x768/267647265.jpg?k=c8233ff42c39f9bac99e703900a866dfbad8bcdd6740ba4e594659564e67f191&o=",
        "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"
      ])
}
