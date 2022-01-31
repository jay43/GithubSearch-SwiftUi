//
//  RepoRow.swift
//  GithubSearch SwiftUi
//
//  Created by PC on 20/01/22.
//

import SwiftUI
import class Kingfisher.KingfisherManager

struct RepoRow: View {
    let repo: Repo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                RowImage(avatar_url: repo.owner.avatar_url)
                VStack(alignment: .leading) {
                    HStack {
                        Text(repo.name)
                        Spacer()
                        Text(repo.watchers.description)
                    }.font(.headline)
                    Text(repo.description ?? "No Description")
                        .font(.subheadline)
                }
                Image(systemName: "photo") // placeholder
                    .fetchingRemoteImage(from: URL(string: repo.owner.avatar_url)!)
                    .frame(width: 44, height: 44)
            }
        }
    }
}


struct RowImage: View {
    let avatar_url: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(url: URL(string: avatar_url), transaction: .init(animation: .spring())) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .opacity(0.2)
                        .transition(.opacity.combined(with: .scale))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(.opacity.combined(with: .scale))
                case .failure(_):
                    Color.red
                        .opacity(0.2)
                        .transition(.opacity.combined(with: .scale))
                @unknown default:
                    Color.yellow
                        .opacity(0.2)
                        .transition(.opacity.combined(with: .scale))
                }
            }
            .frame(width: 60, height: 60)
            .mask(RoundedRectangle(cornerRadius: 16))
        } else {
            if let url = URL(string: avatar_url) {
                RemoteImageView(
                    url: url,
                    placeholder: {
                        Color.gray
                            .opacity(0.2)
                            .transition(.opacity.combined(with: .scale))
                    },
                    image: {
                        $0.resizable()
                            .aspectRatio(contentMode: .fill)
                            .transition(.opacity.combined(with: .scale))
                    }
                )
                    .frame(width: 60, height: 60)
                    .mask(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}
