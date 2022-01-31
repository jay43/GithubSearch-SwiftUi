//
//  RemoteImageModifier.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 31/01/22.
//

import class Kingfisher.KingfisherManager
import SwiftUI

extension Image {
    func fetchingRemoteImage(from url: URL) -> some View {
        ModifiedContent(content: self, modifier: RemoteImageModifier(url: url))
    }
}

struct RemoteImageModifier: ViewModifier {
    let url: URL
    @State private var fetchedImage: UIImage? = nil
    
    func body(content: Content) -> some View {
        if let image = fetchedImage {
            return Image(uiImage: image)
                .resizable()
                .eraseToAnyView()
        }
        
        return content
            .onAppear(perform: fetch)
            .eraseToAnyView()
    }
    
    private func fetch() {
        KingfisherManager.shared.retrieveImage(with: url) { result in
            self.fetchedImage = try? result.get().image
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
