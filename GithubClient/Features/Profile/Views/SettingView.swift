//
//  SettingView.swift
//  GithubClient
//
//  Created by kim on 2025/5/6.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var auth: AuthManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Spacer()
            
            Button {
                auth.logout()
            } label: {
                Text("退出登录")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .background(Color.white)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SettingView()
}
