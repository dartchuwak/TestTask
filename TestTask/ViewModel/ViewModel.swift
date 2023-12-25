//
//  ViewModel.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 19.12.2023.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {

    var networkService: NetworkServiceProtocol?
    @Published var hotel: Hotel?
    @Published var rooms: [Room] = []
    @Published var booking: Booking?
    @Published var tourPrice: Int = 0
    @Published var fuelCharge: Int = 0
    @Published var serviceCharge: Int = 0
    @Published var totalPrice: Int = 0

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchHotelData() async {
        do {
            guard let data =  try await networkService?.getData(url: Endpoints.hotel) else { return }
            let hotel = try JSONDecoder().decode(Hotel.self, from: data)
            await MainActor.run {
                self.hotel = hotel
            }
        } catch {
        }
    }

    func fetchRoomData() async {
        do {
            guard let data = try await networkService?.getData(url: Endpoints.room)  else { return }
            let rooms = try JSONDecoder().decode(Rooms.self, from: data)
            await MainActor.run {
                self.rooms = rooms.rooms
            }
        } catch {
            print (error)
        }
    }

    func fetchBookingData() async {
        do {
            guard let data = try await networkService?.getData(url: Endpoints.booking)  else { return }
            let booking = try JSONDecoder().decode(Booking.self, from: data)
            await MainActor.run {
                self.booking = booking
            }
        } catch {

        }
    }
}
