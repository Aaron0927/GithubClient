//
//  ContributionGraphView.swift
//  GithubClient
//
//  Created by kim on 2025/4/7.
//

import SwiftUI

/// 贡献日历
struct ContributionGraphView: View {
    var contrbutions: [DayActivity] = []
    var weeks: [String] = []
    @State private var didScroll = false

    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 5) {
                    Text("较少")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    ForEach(DayActivity.colors(), id: \.self) { color in
                        Color(uiColor: color)
                            .frame(width: 15, height: 15)
                            .cornerRadius(5)
                    }
                    Text("较多")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                .font(.body)
                .foregroundStyle(.primary)
            }
            
            // 日历图
            heatmapView
                .clipShape(.rect(cornerRadius: 5))
            
            Spacer()
        }
    }
        
    // 贡献图
    private var heatmapView: some View {
        HStack(spacing: 2) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(weeks, id: \.self) { week in
                    Text(week)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }
            }
            .frame(width: 25)
            .frame(maxHeight: .infinity)
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: Array(repeating: GridItem(.fixed(15), spacing: 2), count: 7), spacing: 2) {
                        ForEach(contrbutions) { item in
                            Rectangle()
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color(uiColor: item.color))
                                .cornerRadius(2)
                                .id(item.id)
                        }
                    }
                }
                .onChange(of: contrbutions) { newValue in
                        guard !didScroll, let last = newValue.last else { return }
                        DispatchQueue.main.async {
                            proxy.scrollTo(last.id, anchor: .trailing)
                            didScroll = true // 避免多次滚动
                        }
                    }
            }
        }
        .frame(height: 15 * 7 + 2 * 6)

    }
    
    private var heatmapView2: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 15), spacing: 2)], spacing: 2) {
                    ForEach(0..<100) { item in
                        Rectangle()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color(uiColor: .randomColor))
                            .cornerRadius(2)
                            .overlay {
                                Text("\(item)")
                            }
                    }
                }
//                LazyHGrid(rows: Array(repeating: GridItem(.fixed(15), spacing: 2), count: 7), spacing: 2) {
//                    
//                }
                .frame(height: 15 * 7 + 2 * 6)
            }
            .onAppear {
            }
        }
    }
}

#Preview {
    ContributionGraphView()
}
