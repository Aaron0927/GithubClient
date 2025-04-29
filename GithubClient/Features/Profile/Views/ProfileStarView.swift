//
//  ProfileStarView.swift
//  GithubClient
//
//  Created by kim on 2025/4/8.
//

import SwiftUI

struct ProfileStarView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<10) { _ in
                HStack(alignment: .top, spacing: 15) {
                    Rectangle()
                        .fill(.red)
                        .clipShape(.circle)
                        .frame(width: 40, height: 40)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Alamofire")
                            .font(.headline.bold())
                        Text("Alamofire")
                            .font(.subheadline)
                            .foregroundStyle(Color(.secondaryLabel))
                        Text("Elegant HTTP Networking in Swift")
                        HStack {
                            HStack(spacing: 0) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("42K")
                                    .font(.callout)
                                    .foregroundStyle(Color(.secondaryLabel))
                            }

                            HStack(spacing: 0) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("Swift")
                                    .font(.callout)
                                    .foregroundStyle(Color(.secondaryLabel))
                            }

                            Text("于2023-02-20")

                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }
        .frame(minHeight: kScreenH - kStatusAndNavBarH)
    }
}

#Preview {
    ProfileStarView()
}
