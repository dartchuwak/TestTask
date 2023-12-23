//
//  ContentView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 18.12.2023.
//

import SwiftUI
import WrappingHStack

struct MainView: View {

    init() {
              let coloredAppearance = UINavigationBarAppearance()
              coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.shadowColor = .clear
              coloredAppearance.backgroundColor = .white
              coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
              coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
              UINavigationBar.appearance().standardAppearance = coloredAppearance
              UINavigationBar.appearance().compactAppearance = coloredAppearance
              UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
              UINavigationBar.appearance().tintColor = .white
    }

    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var coordinator: Coordinator
    var body: some View {

            if let hotel = viewModel.hotel {
                VStack {
                    ScrollView {
                        VStack(spacing: 8) {
                            VStack(alignment: .leading) {
                                Image("img")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .padding(.bottom, 16)
                                    .padding(.top, 4)

                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("\(hotel.rating.description) ")
                                        .font(.system(size: 16, weight: .medium)) +
                                    Text(hotel.ratingName)
                                        .font(.system(size: 16, weight: .medium))

                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .foregroundColor(Color(red: 1, green: 0.66, blue: 0))
                                .background(Color(red: 1, green: 0.78, blue: 0).opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .padding(.bottom, 8)

                                Text(hotel.name)
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.bottom, 8)

                                Text(hotel.adress)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
                                    .padding(.bottom, 16)

                                Text("\(hotel.minimalPrice.description) ₽ ")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(.black) +
                                Text(hotel.priceForIt)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))

                                Spacer().frame(height: 16)
                            }
                            .padding(.horizontal)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading) {
                                Text("Об отеле")
                                    .font(.system(size: 22, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.top, 16)
                                WrappingHStack(hotel.aboutTheHotel.peculiarities, id: \.self) {
                                        TagView(text: $0)
                                }


                                Text(hotel.aboutTheHotel.description)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.black.opacity(0.9))

                                VStack {
                                    OptionsView(image: "emoji-happy", text: "Удобства", descriptions: "Самое основное")
                                    Divider()
                                        .padding(.horizontal, 15)
                                    OptionsView(image: "tick-square", text: "Что включено", descriptions: "Самое основное")
                                    Divider()
                                        .padding(.horizontal, 15)
                                    OptionsView(image: "close-square", text: "Что не включено", descriptions: "Самое основное")
                                }
                                .padding(.vertical, 15)
                                .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                                .clipShape(RoundedRectangle(cornerRadius: 15))

                                Spacer().frame(width: UIScreen.main.bounds.width - 32 ,height: 16)

                            }
                            .padding(.horizontal)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }

                        .padding(.bottom, 10)
                        .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                    }
                    .scrollIndicators(.hidden)
                    .background(Color(red: 0.98, green: 0.96, blue: 0.99))

                        Text("К выбору номера")
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background {Color.blue}
                            .font(.system(size: 16, weight: .medium))
                            .kerning(0.1)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                coordinator.push(view: .room)
                            }

                }
                .navigationBarHidden(false)
                .navigationBarTitle(hotel.name, displayMode: .inline)
                .background(NavigationConfigurator { nc in
                               nc.navigationBar.barTintColor = .blue
                               nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                           })
            } else {
                ProgressView()
                    .task {
                        do {
                            try await withThrowingTaskGroup(of: Void.self) { group in
                                group.addTask {
                                    await viewModel.fetchHotelData()
                                }
                                group.addTask {
                                    await viewModel.fetchRoomData()
                                }
                                group.addTask {
                                    await viewModel.fetchBookingData()
                                }

                                for try await _ in group {}
                            }
                        } catch {

                        }
                }
            }
        }

}


#Preview {
    MainView()
}
