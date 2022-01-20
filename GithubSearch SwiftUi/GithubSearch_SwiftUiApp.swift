//
//  GithubSearch_SwiftUiApp.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 20/01/22.
//

import SwiftUI

@main
struct GithubSearch_SwiftUiApp: App {
    var body: some Scene {
        WindowGroup {
            let store = ReposStore(service: .init())
            ContentView()
                .environmentObject(store)
        }
    }
}
