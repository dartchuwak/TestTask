//
//  RoomViewCell.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 19.12.2023.
//

import SwiftUI
import WrappingHStack

struct RoomViewCell: View {

    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var coordinator: Coordinator
    let room: Room
    @State var isPresented = false
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                Image("room")
                    .resizable()
                    .frame(height: 257)
                    .scaledToFill()

                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 16)

                Text(room.name)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.black)

                WrappingHStack(room.peculiarities, id: \.self) { item in
                    TagView(text: item)
                }
                HStack {
                    Text("Подробнее о номере")
                        .font(.system(size: 16, weight: .medium))
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))

                Group {
                    Text("\(room.price) ₽")
                        .font(.system(size: 30, weight: .semibold)) +
                    Text(" \(room.pricePer)")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                }
                .textCase(.lowercase)
            }

            Button(action: {
                coordinator.push(view: .booking)
            }, label: {
                Text("Выбрать номер")
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
        .padding(.horizontal, 16)
        .padding(.bottom, 16)

    }
}

#Preview {
    RoomViewCell(room: Room(id: 1, name: "", price: 1, pricePer: "", peculiarities: [], imageUrls: []))
        .environmentObject(ViewModel(networkService: NetworkService()))
}
