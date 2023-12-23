//
//  RoomView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 19.12.2023.
//

import SwiftUI

struct RoomView: View {

    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var viewMOdel: ViewModel
    let rooms: [Room]
    let title: String

    init(rooms: [Room], title: String) {
        self.rooms = rooms
        self.title = title
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ForEach(rooms, id:\.self) { room in
                    RoomViewCell(room: room)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .scrollIndicators(.hidden)
                .listStyle(.grouped)
                .padding(.top, 8)
            }

            .padding(.bottom, geo.safeAreaInsets.bottom - 20)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color(red: 0.96, green: 0.96, blue: 0.98))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(NavigationConfigurator { nc in
                       nc.navigationBar.barTintColor = .blue
                       nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                   })
        .navigationBarBackButtonHidden()
        .navigationTitle(title)
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

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

#Preview {
    RoomView(rooms: [], title: "Hotel")
}
