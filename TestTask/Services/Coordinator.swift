//
//  Coordinator.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 23.12.2023.
//

import SwiftUI

enum Page: String, Identifiable {
    case root, room, booking, pay
    var id: String {
        self.rawValue
    }
}

class Coordinator: ObservableObject {

    var viewModel: ViewModel?

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    @Published var path = NavigationPath()

    func push(view: Page) {
        path.append(view)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func build(page: Page) -> some View {
        if let viewModel = viewModel {
            switch page {
            case .root:
                MainView()
            case .room:
                RoomView(rooms: viewModel.rooms, title: "OrderPayedView")
            case .booking:
                BookingView(bookingDetails: viewModel.booking!)
            case .pay:
                OrderPayedView()
            }
        }
    }

}
