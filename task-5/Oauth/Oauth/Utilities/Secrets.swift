//
//  Secrets.swift
//  Oauth
//
//  Created by Victoria Iashchuk on 22/01/2026.
//

import Foundation

enum Secrets {
    static var githubClientID: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "GithubClientID") as? String else {
            fatalError("GithubClientID not found in Info.plist")
        }
        return id
    }
}
