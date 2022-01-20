//
//  ContentView.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 20/01/22.
//

import SwiftUI

struct ContentView: View {
    @State private var query: String = "java"
    @EnvironmentObject var repoStore: ReposStore
    
    var body: some View {
        NavigationView {
            List {
                TextField("Type something...", text: $query, onCommit: fetch)
                ForEach(repoStore.repos) { repo in
                    RepoRow(repo: repo)
                }
            }.navigationBarTitle(Text("Search"))
        }.onAppear(perform: fetch)
    }
    
    private func fetch() {
        repoStore.fetch(matching: query)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
