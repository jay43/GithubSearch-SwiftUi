//
//  App.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 01/02/22.
//
import Foundation
import Combine

struct World {
    var service = GithubService()
}

enum AppAction {
    case setSearchResults(repos: [Repo])
    case search(query: String)
}

struct AppState {
    var searchResult: [Repo] = []
}

func appReducer(
    state: inout AppState,
    action: AppAction,
    environment: World
) -> AnyPublisher<AppAction, Never> {
    switch action {
    case let .setSearchResults(repos):
        state.searchResult = repos
    case let .search(query):
        return environment.service
            .searchPublisher(matching: query)
            .replaceError(with: [])
            .map { AppAction.setSearchResults(repos: $0) }
            .eraseToAnyPublisher()
    }
    return Empty().eraseToAnyPublisher()
}

typealias AppStore = ReduxRepoStore<AppState, AppAction, World>
