//
//  CoordinatorView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 23.12.2023.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var viewModel: ViewModel
    @StateObject private var coordinator: Coordinator
    
    init() {
        let networkService = NetworkService()
        let viewModel = ViewModel(networkService: networkService)
        _viewModel = StateObject(wrappedValue: viewModel)
        _coordinator = StateObject(wrappedValue: Coordinator(viewModel: viewModel))
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .root)
                .navigationDestination(for: Page.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
        .environmentObject(viewModel)
    }
}

#Preview {
    CoordinatorView()
}
