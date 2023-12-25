//
//  PageView.swift
//  TestTask
//
//  Created by Evgenii Mikhailov on 25.12.2023.
//

import SwiftUI
import UIKit

struct PageView: View {
    let images: [String]
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 257)
                            .clipped()


                    } placeholder: {
                        ProgressView()

                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            VStack {
                Spacer()
                CustomPageControl(numberOfPages: images.count, currentPage: $currentPage)
                    .padding(.bottom , 8)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 257)
        .clipped()
    }
}

struct CustomPageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    @Namespace private var animation

    var body: some View {
        HStack {
            ForEach(0..<numberOfPages) { index in
                if currentPage == index {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 7)
                        .overlay {
                            Circle() // 2
                                .fill(.black)
                                .frame(height: 7)
                                .matchedGeometryEffect(id: "IndicatorAnimationId", in: animation) // 3
                        }
                } else {
                    Circle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 7)
                }
            }
        }
        .padding(.vertical ,5)
        .padding(.horizontal, 10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .animation(.spring(), value: UUID()) // 4
    }
}

struct CustomPageControl_Previews: PreviewProvider {
    static var previews: some View {
        CustomPageControl(numberOfPages: 3, currentPage: .constant(0))
    }
}

#Preview {
    PageView(images: ["https://www.atorus.ru/sites/default/files/upload/image/News/56149/Club_Priv%C3%A9_by_Belek_Club_House.jpg", "https://deluxe.voyage/useruploads/articles/The_Makadi_Spa_Hotel_02.jpg", "https://deluxe.voyage/useruploads/articles/article_1eb0a64d00.jpg"])
}
