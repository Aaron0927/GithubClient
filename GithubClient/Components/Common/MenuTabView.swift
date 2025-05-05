//
//  CustomTabView.swift
//  V2EX
//
//  Created by kim on 2024/12/30.
//

import SwiftUI

struct MenuTabView: View {
    
    @Namespace var animationNamespace
    @Binding var currentSelected: Int
    @State private var scrollDisabled: Bool = true
    
    private let geometryID: String = "slider_rectangle"
    var titles: [String]
    let selectedColor: Color
    let unselectedColor: Color
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                GeometryReader { geometry in
                    ZStack(alignment: .bottomLeading) {
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(titles.indices, id: \.self) { index in
                                VStack(alignment: .center, spacing: 5) {
                                    Text(titles[index])
                                        .foregroundStyle(currentSelected == index ? selectedColor : unselectedColor)
                                        .font(.body)
                                }
                                .frame(width: 40)
                                .padding(.horizontal, 5)
                                .id(index)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        currentSelected = index
                                        proxy.scrollTo(index, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 6)
                        
                        // 滑块
                        Rectangle()
                            .frame(width: 20, height: 3)
                            .clipShape(.rect(cornerRadius: 10))
                            .foregroundStyle(selectedColor)
                            // 居中 50=(40+5*2)是tab宽度 15=(40+5*2-20)/2是滑块相对于tab居中位置 20等于滑块宽度
                            .offset(x: CGFloat(currentSelected + 1) * 50 - 15 - 20)
                    }
                    .onAppear {
                        scrollDisabled = geometry.size.width <= kScreenW
                    }
                }
            }
            .scrollDisabled(scrollDisabled)
        }
        .frame(height: 40)
    }
}

#Preview {
    MenuTabView(currentSelected: .constant(1), titles: ["讨论", "资金", "资讯", "公告"], selectedColor: .primary, unselectedColor: .gray)
}
