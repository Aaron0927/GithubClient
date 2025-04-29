//
//  GitHubAuthManager.swift
//  GithubClient
//
//  Created by kim on 2025/3/12.
//

import Foundation
import AuthenticationServices

let clientID = "Ov23libgYIaxqVE0lMNC"
let clientSecret = "3684259f4954da9b38026e97fd39a68d6dc2e7d8"
let redirectURI = "mygithubclient://oauth-callback"

enum GitHubAuthError: LocalizedError {
    case authError
    case notGetCode
    case notGetToken
    
    var errorDescription: String? {
        switch self {
        case .authError:
            return "授权失败"
        case .notGetCode:
            return "未获取到授权码"
        case .notGetToken:
            return "未获取到授权码"
        }
    }
}

class GitHubAuthService {
    
    private let provider = AuthenticationContextProvider()
    
    /// 开始授权
    func startAuthentication() async throws -> String {
        let authURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=repo,user&redirect_uri=\(redirectURI)")!
        
        return try await withCheckedThrowingContinuation { continuation in
            webAuth(url: authURL, callbackURLScheme: "mygithubclient") { result in
                switch result {
                case .success(let code):
                    continuation.resume(returning: code)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// 交换token
    func exchangeCodeForToken(code: String) async throws {
        let responseDict: [String: String] = try await APIClient.shared.request(GitHubEndpoint.access_token(code: code))
        guard let token = responseDict["access_token"] else {
            throw GitHubAuthError.notGetToken
        }
        KeyChainHelper.shared.saveAccessToken(token)
    }
    
    private func webAuth(url: URL, callbackURLScheme: String,
                         completion: @escaping (Result<String, Error>) -> Void){
        let authSession = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackURLScheme) { (url, error) in
            if let error = error {
                completion(.failure(error))
            } else if let url = url {
                let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
                guard let code = queryItems?.first(where: { $0.name == "code" })?.value else {
                    completion(.failure(GitHubAuthError.notGetCode))
                    return
                }
                completion(.success(code))
            } else {
                completion(.failure(GitHubAuthError.authError))
            }
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else{
                return
            }
            authSession.presentationContextProvider = provider
            authSession.start()
        }
    }
}

private class AuthenticationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.keyWindow ?? UIWindow()
    }
}
