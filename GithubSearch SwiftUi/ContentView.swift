//
//  ContentView.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 20/01/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            SearchContainerView()
                .navigationBarTitle(Text("Search"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Container Views should do things only related to data-flow:
//
//1. Store the state of the Rendering View
//2. Fetch data using ObservableObject
//3. Handle life cycle (onAppear/onDisappear)
//4. Provide action handlers to the Rendering View
struct SearchContainerView: View {
    @EnvironmentObject var repoStore: ReposStore
    @State var query = "Swift"
    
    var body: some View {
        SearchView(query: $query, repos: repoStore.repos, onCommit: fetch)
            .onAppear(perform: fetch)
    }
    
    private func fetch() {
        repoStore.fetch(matching: query)
    }
}

//Rendering Views should do things only related to rendering:
//
//1. Build User Interface using primitive components provided by SwiftUI.
//2. Compose User Interface by using other Rendering Views.
//3. Use data as input to render User Interface and don’t store any state.
struct SearchView: View {
    @Binding var query: String
    let repos: [Repo]
    let onCommit: ()-> Void
    
    var body: some View {
        List {
            TextField("Type something...", text: $query, onCommit: onCommit)
            ForEach(repos) { repo in
                RepoRow(repo: repo)
            }
        }
    }
}

