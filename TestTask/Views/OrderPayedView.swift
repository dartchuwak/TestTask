//
//  OrderPayedView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 23.12.2023.
//

import SwiftUI

struct OrderPayedView: View {

    @EnvironmentObject var coordinator: Coordinator
    var body: some View {
        VStack {
            Spacer()
            Image("payed")
                .resizable()
                .frame(width: 72, height: 72)
            Text("Ваш заказ принят в работу")
              .font(
                Font.custom("SF Pro Display", size: 22)
                  .weight(.medium)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.black)
              .padding(.top, 32)

            Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
              .font(Font.custom("SF Pro Display", size: 16))
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
              .padding(.top, 20)
              .padding(.horizontal, 23)
 Spacer()
            Button(action: {
                coordinator.popToRoot()
            }, label: {
                Text("Супер")
                    .foregroundStyle(.white)
            })
            .padding()
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(.blue)
            .cornerRadius(20)
            .clipped()
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Заказ оплачен")
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

#Preview {
    OrderPayedView()
}
